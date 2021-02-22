class AddCorrectAnswerToOptions < ActiveRecord::Migration[6.0]
  def change
    add_column :options, :correct_answer, :boolean, null: false, default: false
  end
end
