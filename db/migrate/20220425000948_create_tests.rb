class CreateTests < ActiveRecord::Migration[7.0]
  def change
    create_table :tests do |t|
      t.string :name
      t.string :description
      t.integer :question_quantity

      t.timestamps
    end
  end
end
