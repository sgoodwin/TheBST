class CreateListings < ActiveRecord::Migration[7.0]
  def change
    create_table :listings do |t|
      t.string :title
      t.text :info
      t.decimal :price, :precision => 8, :scale => 2
      t.string :currency

      t.timestamps
    end
  end
end
