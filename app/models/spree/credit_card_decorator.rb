module Spree
  CreditCard.class_eval do
    # attr_accessible :deleted_at
    belongs_to :user, class_name: "Spree::User"
    scope :reusable, -> {available.where("gateway_payment_profile_id IS NOT NULL")}
    scope :available, -> { where("deleted_at IS NULL") }

    def card_info
      "#{cc_type} #{last_digits} - #{month}/#{year}"
    end

    def deleted?
      !!deleted_at
    end
  end
end
