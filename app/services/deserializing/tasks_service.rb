# frozen_string_literal: true

module Deserializing
  class TasksService
    attr_reader :params

    extend Callable

    def initialize(params)
      @params = params
    end

    def perform
      tasks_params.merge(additional_params)
    end

    def tasks_params
      ActiveModelSerializers::Deserialization.jsonapi_parse(params, only: %i[title status])
    end

    def additional_params
      {
        event_id: params[:event_id].presence,
        id: params[:id].presence
      }
    end
  end
end
