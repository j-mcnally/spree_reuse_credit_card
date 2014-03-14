module Spree
  Payment.class_eval do
    attr_accessible :source, :source_attributes
    before_save :save_card_to_user
    after_save :remove_failed_card

    def save_card_to_user
      if source.present? && source_type == 'Spree::CreditCard'
        source.user = order.user
      end
    end

    def remove_failed_card
      if source.present? && source_type == 'Spree::CreditCard' && state == 'failed'
        source.deleted_at = DateTime.now
        source.save
      end
    end

  end
end