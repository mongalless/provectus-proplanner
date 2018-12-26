# frozen_string_literal: true

class Task::Update < Trailblazer::Operation
  step Model(Task, :find_by)
  step Policy::Pundit(Default, :validate_user_and_event)
  step Contract::Build(constant: Task::Contract::Default)
  step Contract::Validate()
  step Contract::Persist()
  failure :handle_failure!

  def handle_failure!(options, params)
    options[:model] = Failure::TaskOperationService.call(params)
  end
end
