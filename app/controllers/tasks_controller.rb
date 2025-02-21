class TasksController < ApplicationController
  def index
    results = Domain.task_repository.list

    if results.success?
      @tasks = results.tasks
    else
      @tasks = []
      flash[:alert] = "Erreur lors du chargement des tâches"
    end
  end

  def new
    @task = Task.new
  end

  def create
    results = Domain.create_task.execute(
      title: task_params[:title],
      description: task_params[:description],
      due_date: task_params[:due_date]
    )

    if results.success?
      redirect_to tasks_path, notice: 'Tâche créée avec succès'
    else
      @form_errors = results.errors
      @task = Task.new(task_params)
      render :new
    end
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :due_date)
  end
end
