class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.references :category,         foreign_key: true
      t.string :name,                 default: ''
      t.text :description,            default: ''
      t.boolean :sold_out,            default: false
      t.boolean :under_sale,          default: false
      t.integer :price_in_cents,      default: 0, null: false
      t.integer :sale_price_in_cents, default: 0, null: false
      t.string :sale_text,            default: ''
      t.string :currency,             default: 'SGD', null: false

      t.timestamps
    end
  end
end
