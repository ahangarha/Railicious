class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy
  has_many :foods, through: :recipe_foods

  validates :name, presence: true

  def self.public_recipes
    @recipes = Recipe.includes(:foods, recipe_foods: [:food]).where(public: true).order(created_at: :desc)
  end
end
