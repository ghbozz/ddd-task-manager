module Domain
  module UseCases
    class CreateTask
      ValidationSchema = Dry::Validation.Schema do
        required(:title).filled
        required(:due_date).filled
      end

      def initialize(task_repository)
        @task_repository = task_repository
      end

      def execute(title:, description:, due_date:)
        validation = ValidationSchema.call(title: title, due_date: due_date)

        if validation.failure?
          return OpenStruct.new(success?: false, errors: validation.errors)
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
