module Domain
  def self.task_repository
    @task_repository ||= Repositories::TaskRepository::ActiveRecord.new(Task)
  end

  def self.create_task
    @create_task ||= UseCases::CreateTask.new(task_repository)
  end
end