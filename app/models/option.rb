class Option < ApplicationRecord
  belongs_to :question
  has_one_attached :opt_image, dependent: :destroy
end
