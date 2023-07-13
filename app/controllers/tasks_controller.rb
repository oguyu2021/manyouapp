class TasksController < ApplicationController
  def index
    @tasks = Task.all.order(created_at: 'ASC')

    if params[:sort_deadline] == 'true'
      @tasks = @tasks.reorder(deadline: 'DESC')
    end
    if params[:sort_priority] == 'true'
      #binding.pry
      @tasks = @tasks.reorder(priority: 'ASC')
    end
  
    if params[:task].present?
      if params[:task][:title].present? && params[:task][:status].present?
        @tasks = @tasks.title_search(params[:task][:title]).status_search(params[:task][:status])
      elsif params[:task][:title].present?
        @tasks = @tasks.title_search(params[:task][:title])
      elsif params[:task][:status].present?
        @tasks = @tasks.status_search(params[:task][:status])
      end
    end
    @tasks = @tasks.page(params[:page]).per(10) 
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params) 
      if params[:back]
      render :new
    else
      if @task.save
        redirect_to tasks_path, notice: "作成しました！"
      else
        render :new
      end
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to tasks_path, notice: "編集しました！"
    else
      render 'edit'
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path, notice: "削除しました！"
  end

  private

  def task_params
    params.require(:task).permit(:title, :content, :deadline, :status, :priority)
  end
end

