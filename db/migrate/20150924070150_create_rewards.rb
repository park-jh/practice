class CreateRewards < ActiveRecord::Migration
  def change
    create_table :rewards do |t|
      t.references :customer
      t.integer :points

      t.timestamps null: false
    end
  end
end
