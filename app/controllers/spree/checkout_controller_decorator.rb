require 'card_reuse'

module Spree
  CheckoutController.class_eval do
    include CardReuse

    private

    Spree::PermittedAttributes.payment_attributes << [:source_id, :source_type]

    def before_payment
      @order.payments.destroy_all if request.put? 
      @cards = @order.user.credit_cards.available if @order.user.present?
    end

    def object_params
      # For payment step, filter order parameters to produce the expected nested attributes for a 
      # single payment and its source, discarding attributes for payment methods other than the one selected
      if @order.has_checkout_step?("payment") && @order.payment?
        if params[:payment_source].present?
          source_params = params.delete(:payment_source)[params[:order][:payments_attributes].first[:payment_method_id].underscore]

          if params[:existing_card] and params[:existing_card] != 'false'
            credit_card = Spree::CreditCard.find(params[:existing_card])
            authorize! :manage, credit_card
            params[:order][:payments_attributes].first[:source_id] = credit_card.id
            params[:order][:payments_attributes].first[:source_type] = credit_card.class.name
          else
            if source_params
              params[:order][:payments_attributes].first[:source_attributes] = source_params
            end
          end
        end
        if (params[:order][:payments_attributes])
          params[:order][:payments_attributes].first[:amount] = @order.total
        end
      end
      
      if params[:order]
        params[:order].permit(permitted_checkout_attributes)
      else
        {}
      end
    end

  end
end
