require 'card_reuse'

module Spree
  CheckoutController.class_eval do
    include CardReuse

    before_filter do 
      puts "permitted_checkout_attributes:: #{permitted_checkout_attributes.inspect}"
    end

    private

    Spree::PermittedAttributes.checkout_attributes << [:source, :source_attributes]

    def before_payment
      @order.payments.destroy_all if request.put? 
      @cards = @order.user.credit_cards.available if @order.user.present?
    end

  end
end
