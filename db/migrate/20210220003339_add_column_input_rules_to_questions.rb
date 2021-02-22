class AddColumnInputRulesToQuestions < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :input_rules, :text
  end
end
