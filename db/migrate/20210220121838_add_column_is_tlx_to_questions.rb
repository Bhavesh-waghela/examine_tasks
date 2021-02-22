class AddColumnIsTlxToQuestions < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :is_tlx, :boolean, null: false, default: false
  end
end
