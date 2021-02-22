class AddColumnSternbergTimerToQuestions < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :sternberg_timer, :integer
    add_column :questions, :description, :text
  end
end
