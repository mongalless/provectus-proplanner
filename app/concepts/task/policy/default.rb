# frozen_string_literal: true

class Default
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @model = model
  end

  # It's quite strange, that if I call three functions below
  # in operations separately, goes strange thing: current_user_exists?
  # executes three times. So, I create this function.
  def validate_user_and_event
    current_user_exists?
    event_exists?
    current_user_have_event?
  end

  def current_user_exists?
    User.find(current_user.id)
  end

  def event_exists?
    Event.find(model[:event_id])
  end

  def current_user_have_event?
    current_user.events.find(model[:event_id])
  end
end
