class TasksController < ApplicationController
  def index
    @tasks = Task.page(params[:page]).per(10)
    @tasks = Task.all.order(created_at: 'ASC')
  
    if params[:title].present?
      @tasks = @tasks.where('title LIKE ?', "%#{params[:title]}%")
    end
    if params[:status].present?
      @tasks = @tasks.where(status: params[:status])
    end
    if params[:sort_expired] == 'true'
      @tasks = @tasks.reorder(deadline: 'ASC')
    end
    if params[:sort_priority] == 'true'
      #binding.pry
      @tasks = @tasks.reorder(priority: 'ASC')
    end
  end
  
  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: "作成しました！"
    else
      render 'new'
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to tasks_path, notice: "更新しました！"
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
    params.require(:task).permit(:title, :content, :priority)
  end

end
