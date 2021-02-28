class CreateShippingAdds < ActiveRecord::Migration[6.0]
  def change
    create_table :shipping_adds do |t|
      t.string :postal_code,      null: false
      t.integer :prefecture_id,   null: false
      t.string :municipalities,   null: false
      t.string :address,          null: false
      t.string :building
      t.string :tel,              null: false
      t.references :buyer,        null: false, foreign_key: true
      t.timestamps
    end
  end
end
