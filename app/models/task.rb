# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :event

  enum status: %i[open inprogress complete incomplete]

  self.per_page = 10

  scope :completed, -> { where(status: 2) }
end
