class Skill < ActiveRecord::Base
  has_and_belongs_to_many :users
  scope :not_chosen, ->(skills) { where.not(id: skills.map(&:id)) }
end
