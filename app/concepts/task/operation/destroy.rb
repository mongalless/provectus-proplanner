# frozen_string_literal: true

class Task::Destroy < Trailblazer::Operation
  step Model(Task, :find_by)
  step Policy::Pundit(Default, :validate_user_and_event)
  step :destroy_task!
  failure :handle_failure!

  def destroy_task!(options, _params)
    options[:model].destroy
  end

  def handle_failure!(options, params)
    options[:model] = Failure::TaskOperationService.call(params)
  end
end
