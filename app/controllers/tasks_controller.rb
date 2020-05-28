class TasksController < ApplicationController
  before_action :set_user
 
 
  def index
    @tasks = @user.tasks
  end

  
  def show
    @tasks= @user.tasks.find(params[:id])
  end

  
  def new
    @tasks = Task.new
  end
  
  def create
    @tasks = @user.tasks.new(task_params)
    if @tasks.save
      flash[:success] ='タスクを新規作成しました'
      redirect_to user_tasks_url
    else
      render :new
    end
  end
  

  def edit
    @tasks = @user.tasks.find(params[:id])
  end


  def update
    if @tasks = @user.tasks.find(params[:id])
       @tasks.update_attributes(task_params)
       flash[:success] = "タスクを更新しました。"
       
    else
       flash[:danger] = "#{@user.name}の更新は失敗しました。<br>" + @tasks.errors.full_messages.join("<br>")
       render :edit
    end
    redirect_to user_tasks_url
  end
  
  def destroy
    @tasks = @user.tasks.find(params[:id])
    @tasks.destroy
    flash[:success] = "タスクを削除しました。"    
    redirect_to user_tasks_url
  end

  private
    def set_user
      @user = User.find(session[:user_id])
    end
    
    def task_params
      params.require(:task).permit(:name,:description)
    end
end
