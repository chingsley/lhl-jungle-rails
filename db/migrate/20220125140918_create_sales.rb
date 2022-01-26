class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.string :name
      t.date :starts_on
      t.date :ends_on
      t.decimal :percent_off

      t.timestamps null: false
    end
  end
end
