class Question < ApplicationRecord
  has_one :answer, dependent: :destroy
  has_many :options, dependent: :destroy
  has_one_attached :image, dependent: :destroy
  belongs_to :user
  accepts_nested_attributes_for :options, :allow_destroy => true

  scope :easy_questions, -> { where :difficulty_level => "EASY"}
  scope :medium_questions, -> { where :difficulty_level => "MEDIUM"}
  scope :hard_questions, -> { where :difficulty_level => "HARD"}


  enum q_type: ["RAVEN", "STENBERG", "INPUT_DIAGRAMMATIC"]
  enum difficulty_level: ["EASY", "MEDIUM", "HARD"]
end
