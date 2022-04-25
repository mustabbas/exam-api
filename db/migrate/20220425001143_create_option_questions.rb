class CreateOptionQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :option_questions do |t|
      t.string :name
      t.boolean :correct

      t.timestamps
    end
  end
end
