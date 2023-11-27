require 'action_view'

class Cat < ApplicationRecord
    include ActionView::Helpers::DateHelper

    validates :name, presence: true
    validates :birth_date, presence: true
    validates :description, presence: true
    validate :birth_date_cannot_be_future
    CAT_COLORS = ["brown", "orange", "black", "white", "multi"]
    CAT_SEXES = ["M", "F"]

    # validates :color, inclusion: { in: ['brown', 'orange', 'black', 'white', 'multi'], message: "%{value} is not a valid color" }
    validates :color, inclusion: { in: CAT_COLORS, message: "%{value} is not a valid color" }
    validates :sex, inclusion: { in: ['M', 'F'], message: "%{value} is not a valid sex" }
    
    def birth_date_cannot_be_future
        if birth_date > Time.now
            errors.add(:birth_date, 'in future...')
        end
    end

    def age
        now = Time.now.utc.to_date  # 11/27/2023
        now.year - birth_date.year - ((now.month > birth_date.month || (now.month == birth_date.month && now.day >= birth_date.day)) ? 0 : 1)
    end


end
