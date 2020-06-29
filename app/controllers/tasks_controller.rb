class TasksController < ApplicationController
  before_action :set_user
  before_action :correct_user, only: [:index, :show, :new, :create, :update, :destroy]
  before_action :set_task, only: [:edit]
  
 
  def index
    @tasks = @user.tasks .order(created_at: "DESC")
   
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
      @user = User.find(params[:user_id])
    end
    
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください。"
        redirect_to login_url
      end
    end
    
    def task_params
      params.require(:task).permit(:name, :description)
    end
    
    def correct_user
      # @user = User.find(params[:user_id]) if @user.blank?
      unless current_user?(@user) 
        flash[:danger] = "編集権限がありません。"
        redirect_to(root_url)
      end  
    end
    
    def set_task
      unless @task = @user.tasks.find_by(id: params[:id])
        flash[:danger] = "権限がありません。"
        redirect_to user_tasks_url
      end  
    end
end
