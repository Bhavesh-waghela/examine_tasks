class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user

  def check_correct_answer
    percent_val = 0.0
    correct_option = self.question.options.where(correct_answer: true).first
    if self.question.is_tlx?
      set_tlx_options
    elsif self.question.q_type == "STENBERG"
      percent_val = set_sternberg_answers
    else
      set_default_answers correct_option
    end
    return self.is_correct_ans, percent_val
  end

  def set_default_answers correct_option
    if self.answer.present?
      if correct_option && correct_option.option == self.answer
        self.update_attributes!(is_correct_ans: "yes")
      else
        self.update_attributes!(is_correct_ans: "no")
      end
    else
      self.update_attributes!(is_correct_ans: "not answered")
    end
  end

  def set_tlx_options
    if self.answer == "Extremely low"
      self.update_attributes!(is_correct_ans: "A")
    elsif self.answer == "Very low"
      self.update_attributes!(is_correct_ans: "B")
    elsif self.answer == "Moderately low"
      self.update_attributes!(is_correct_ans: "C")
    elsif self.answer == "Neither low nor High"
      self.update_attributes!(is_correct_ans: "D")
    elsif self.answer == "Moderately high"
      self.update_attributes!(is_correct_ans: "E")
    elsif self.answer == "Very high"
      self.update_attributes!(is_correct_ans: "F")
    elsif self.answer == "Extremely high"
      self.update_attributes!(is_correct_ans: "G")
    else
      self.update_attributes!(is_correct_ans: "no opinion")
    end
  end

  def set_sternberg_answers
    if self.answer.present?
      user_anwers = self.answer.split(" ")
      total_options = self.question.question.split(" ")
      word_count = total_options - user_anwers
      correct_answers = total_options & user_anwers
      val1 = correct_answers.length
      val2 = total_options.length
      percent_val = (val1.to_f/val2.to_f)*100.0
      if word_count.length > 0
        self.update_attributes!(is_correct_ans: "no")
      else
        self.update_attributes!(is_correct_ans: "yes")
      end
    else
      self.update_attributes!(is_correct_ans: "not answered")
    end
    return percent_val
  end
end