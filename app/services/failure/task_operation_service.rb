# frozen_string_literal: true

module Failure
  class TaskOperationService
    attr_reader :params

    extend Callable

    def initialize(params)
      @params = params
    end

    def perform
      # Only create and update actions have contracts,
      # also update policies working before creating contract
      if params[:"result.contract.default"]
        params[:"result.contract.default"].errors
      else
        { task: ['Not found'] }
      end
    end
  end
end
