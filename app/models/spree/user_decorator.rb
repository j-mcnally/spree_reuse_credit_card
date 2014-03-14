module Spree
  User.class_eval do
    has_many :credit_cards, class_name: "Spree::CreditCard"
  end
end
