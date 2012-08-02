class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :vocabulary
      t.string :meaning
      t.references :user

      t.timestamps
    end
    add_index :words, :user_id
  end
end
