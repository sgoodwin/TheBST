class CreateRegions < ActiveRecord::Migration[7.0]
  def change
    create_table :regions do |t|
      t.string :name

      t.timestamps
    end

    change_table :users do |t|
      t.references :region, null: false
    end
  end
end
