class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user

  def check_correct_answer
    correct_option = self.question.options.where(correct_answer: true)
    if correct_option && correct_option == self.answer
      return "Yes"
    else
      return "No"
    end
  end
end