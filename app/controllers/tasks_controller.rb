class TasksController < ApplicationController
  before_action :set_user
 
  def index
    @user = User.find(params[:id])
    @tasks = @user.tasks.all
  end
  
  def show
    @user = User.find(params[:id])
    @tasks = @user.tasks.find(params[:id])
  end

  def new
    @user = User.find(params[:id])
    @tasks = @user.tasks.new
  end
  
  def create
    @task = @user.tasks.create
    if @tasks.save
      log_in @user
      flash[:success] = "タスク新規作成しました。"
      redirect_to user_tasks_url @user
    else
      render :new
    end
  end
  
  def edit
    @user = User.find(params[:id])
    @tasks = @user.tasks.find(params[:id])
  end
  
  def update
    redirect_to tasks_url
  end

  private
    
    def set_user
      @user = User.find(params[:id])
       
    end
    
    def task_params
      params.require(:task).permit(:name,:description,:user_id)
    end
end
