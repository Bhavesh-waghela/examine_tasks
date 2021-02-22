class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.text :question
      t.integer :q_type
      t.integer :difficulty_level
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
