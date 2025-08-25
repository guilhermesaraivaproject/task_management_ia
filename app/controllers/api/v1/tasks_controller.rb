class Api::V1::TasksController < ApplicationController
  before_action :set_task, only: [:show, :update, :destroy]

  # GET /api/v1/tasks
  def index
    @tasks = current_user.tasks.includes(:user)
    render json: {
      status: 'SUCCESS',
      message: 'Tasks loaded',
      data: @tasks.map do |task|
        {
          id: task.id,
          title: task.title,
          description: task.description,
          status: task.status,
          due_date: task.due_date,
          overdue: task.overdue?,
          created_at: task.created_at,
          updated_at: task.updated_at
        }
      end
    }
  end

  # GET /api/v1/tasks/:id
  def show
    render json: {
      status: 'SUCCESS',
      message: 'Task loaded',
      data: {
        id: @task.id,
        title: @task.title,
        description: @task.description,
        status: @task.status,
        due_date: @task.due_date,
        overdue: @task.overdue?,
        created_at: @task.created_at,
        updated_at: @task.updated_at
      }
    }
  end

  # POST /api/v1/tasks
  def create
    @task = current_user.tasks.build(task_params)

    if @task.save
      render json: {
        status: 'SUCCESS',
        message: 'Task created successfully',
        data: {
          id: @task.id,
          title: @task.title,
          description: @task.description,
          status: @task.status,
          due_date: @task.due_date,
          overdue: @task.overdue?,
          created_at: @task.created_at,
          updated_at: @task.updated_at
        }
      }, status: :created
    else
      render json: {
        status: 'ERROR',
        message: 'Task not created',
        data: @task.errors
      }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/tasks/:id
  def update
    if @task.update(task_params)
      render json: {
        status: 'SUCCESS',
        message: 'Task updated successfully',
        data: {
          id: @task.id,
          title: @task.title,
          description: @task.description,
          status: @task.status,
          due_date: @task.due_date,
          overdue: @task.overdue?,
          created_at: @task.created_at,
          updated_at: @task.updated_at
        }
      }
    else
      render json: {
        status: 'ERROR',
        message: 'Task not updated',
        data: @task.errors
      }, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/tasks/:id
  def destroy
    @task.destroy
    render json: {
      status: 'SUCCESS',
      message: 'Task deleted successfully'
    }
  end

  private

  def set_task
    @task = current_user.tasks.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: {
      status: 'ERROR',
      message: 'Task not found'
    }, status: :not_found
  end

  def task_params
    params.require(:task).permit(:title, :description, :status, :due_date)
  end
end
