module Domain
  module Repositories
    module TaskRepository
      class ActiveRecord
        def initialize(ar_model)
          @ar_model = ar_model
        end

        def create(task_entity)
          task_record = @ar_model.new(
            title: task_entity.title,
            description: task_entity.description,
            status: task_entity.status,
            due_date: task_entity.due_date
          )

          if task_record.save
            OpenStruct.new(success?: true, task: task_entity)
          else
            OpenStruct.new(success?: false, errors: task_record.errors)
          end
        end

        def list
          tasks = @ar_model.all.map do |task_record|
            Entities::Task.new(
              id: task_record.id,
              title: task_record.title,
              description: task_record.description,
              status: task_record.status,
              due_date: task_record.due_date
            )
          end

          OpenStruct.new(success?: true, tasks: tasks)
        end
      end
    end
  end

end