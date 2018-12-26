# frozen_string_literal: true

class Task::Show < Trailblazer::Operation
  step Model(Task, :find_by)
  step Policy::Pundit(Default, :validate_user_and_event)
  failure :handle_failure!

  def handle_failure!(options, params)
    options[:model] = Failure::TaskOperationService.call(params)
  end
end
