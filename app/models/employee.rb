class Employee < ApplicationRecord
  belongs_to :company
  belongs_to :user

  # Full text search on name and position
  include PgSearch::Model
  pg_search_scope :search_by_name_and_position,
                  against: %i[name position],
                  using: { tsearch: { prefix: true } }
end
