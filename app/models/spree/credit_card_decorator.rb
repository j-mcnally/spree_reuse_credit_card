module Spree
  CreditCard.class_eval do
    # attr_accessible :deleted_at
    belongs_to :user, class_name: "Spree::User"

    scope :available, -> { where("deleted_at IS NULL") }

    def deleted?
      !!deleted_at
    end
  end
end
