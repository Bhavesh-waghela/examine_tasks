class AddTimerColumnToQuestions < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :countdown_timer, :integer
  end
end
