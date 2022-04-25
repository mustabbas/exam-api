class Question < ApplicationRecord
    has_many :option_questions, dependent: :destroy
    belongs_to :test
end
