# frozen_string_literal: true

class Task::Create < Trailblazer::Operation
  step Model(Task, :new)
  step :assign_event!
  step Policy::Pundit(Default, :validate_user_and_event)
  step Contract::Build(constant: Task::Contract::Default)
  step Contract::Validate()
  step Contract::Persist()
  failure :handle_failure!

  def assign_event!(options, params)
    options[:model].event_id = params[:params][:event_id]
  end

  def handle_failure!(options, params)
    options[:model] = Failure::TaskOperationService.call(params)
  end
end
