class AddDeletedAtToCreditcard < ActiveRecord::Migration
  def change
    add_column :spree_credit_cards, :deleted_at, :datetime
    add_index :spree_credit_cards, :deleted_at
    add_column :spree_credit_cards, :user_id, :integer
    add_index :spree_credit_cards, :user_id
    
  end
end
