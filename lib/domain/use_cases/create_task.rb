module Domain
  module UseCases
    class CreateTask
      TaskContract = Dry::Schema.Params do
        required(:title).filled(:string)
        required(:description).filled(:string)
        required(:due_date).filled(:date)
      end

      def initialize(task_repository)
        @task_repository = task_repository
        @contract = TaskContract
      end

      def execute(title:, description:, due_date:)
        validation = @contract.call(title:, description:, due_date:)

        if validation.failure?
          return OpenStruct.new(success?: false, errors: validation.errors.to_h)
        end

        task_entity = Entities::Task.new(
          title: title,
          description: description,
          due_date: due_date
        )

        @task_repository.create(task_entity)
      end
    end
  end
end
