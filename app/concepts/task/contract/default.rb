# frozen_string_literal: true

module Task::Contract
  class Default < Reform::Form
    property :title
    property :status
    validates :title, :status, presence: true
    validates :title, length: { maximum: 50 }
  end
end
