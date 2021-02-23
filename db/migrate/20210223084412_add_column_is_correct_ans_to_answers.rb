class AddColumnIsCorrectAnsToAnswers < ActiveRecord::Migration[6.0]
  def change
    add_column :answers, :is_correct_ans, :string
  end
end
