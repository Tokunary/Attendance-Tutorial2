class TasksController < ApplicationController
  before_action :set_user
 
 
  def index
    @tasks = @user.tasks
  end

  
  def show
    @task = @user.tasks.find(params[:id])
  end

  
  def new
    @task = Task.new
  end
  
  def create
    @task = @user.tasks.new(task_params)
    
    if @task.save
      flash[:success] ='タスクを新規作成しました'
      redirect_to user_tasks_url
    else
      render :new
    end
  end
  

  def edit
    @task = @user.tasks.find(params[:id])
  end


  def update
    @task = @user.tasks.find(params[:id])
    
      if @task.update_attributes(task_params)
        flash[:success] = "タスクを更新しました。"
        redirect_to user_task_url(@user, @task)
      else
        render :edit
      end
  end
  
  def destroy
    @task = @user.tasks.find(params[:id])
    @task.destroy
    flash[:success] = "タスクを削除しました。"    
    redirect_to user_tasks_url
  end

  private
    def set_user
      @user = User.find(session[:user_id])
    end
    
    def task_params
      params.require(:task).permit(:name, :description)
    end
end
