class AddQuestionsToOptionQuestions < ActiveRecord::Migration[7.0]
  def change
    add_reference :option_questions, :question, null: false, foreign_key: true
  end
end
