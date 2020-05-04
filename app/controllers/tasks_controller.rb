class TasksController < ApplicationController
  before_action :set_user
 
  def index
   
    @tasks = @user.tasks
  end
  
  def show
   
    @tasks= Task.find(params[:id])
  end
  
  def edit
 
    @tasks = @user.tasks.find(params[:id])
  end


  def new
   
    @task = Task.new
  end
  
  def create
    @tasks = Task.new(tasks_params)
    @tasks = save
    redirect_to user_tasks_url
  end
  
  
  
  def update
    @tasks = @user.tasks.find(params[:id])
    @tasks.name = params[:name]
    @tasks.description = params[:description]
    @tasks.save
    redirect_to tasks_url
  end
  
  def destroy
    @tasks = Task.find(params[:id])
    @tasks.destroy
    redirect_to user_task_url
  end

  private
    def set_user
      @user = User.find(session[:user_id])
    end
    
    def task_params
      params.require(:task).permit(:name,:description)
    end
end
