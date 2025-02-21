module Domain
  module Entities
    class Task
      attr_accessor :id, :title, :description, :status, :due_date, :assignees

      def initialize(id: nil, title:, description:, status: 'En attente', due_date:, assignees: [])
        @id = id
        @title = title
        @description = description
        @status = status
        @due_date = due_date
        @assignees = assignees
      end
    end
  end
end