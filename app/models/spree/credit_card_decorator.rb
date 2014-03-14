module Spree
  CreditCard.class_eval do
    def deleted?
      !!deleted_at
    end
  end
end
