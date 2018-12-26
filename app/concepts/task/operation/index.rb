# frozen_string_literal: true

class Task::Index < Trailblazer::Operation
  attr_reader :event

  step Policy::Pundit(Default, :current_user_exists?)
  step :find_event!
  step :current_user_have_event?
  step :get_tasks!
  failure :handle_failure!

  def find_event!(options, params)
    options[:model] = Event.find(params[:params][:event_id])
  end

  # This function almost same to function in Policy, but
  # here event id goes options[:model], not from attribute
  # options[:model][:event_id], because here I manage event, not task.
  def current_user_have_event?(options, _params)
    options[:current_user].events.find(options[:model].id)
  end

  def get_tasks!(options, _params)
    options[:model] = options[:model].tasks
  end

  def handle_failure!(options, params)
    options[:model] = Failure::TaskOperationService.call(params)
  end
end
