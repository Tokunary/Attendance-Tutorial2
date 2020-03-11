class TasksController < ApplicationController
  before_action :logged_in_user,only: [:index, :show]
  
  def index
    @tasks = Task.paginate(page: params[:page], per_page: 20)
  end
  
  def show
  end

  def new
    @tasks = Task.new
  end
  
  def create
    @tasks = Task.new(task_params)
    if @tasks.save
        log_in @tasks
        flash[:success] = '新規作成に成功しました。'
        redirect_to @tasks
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end
  
  private
  
  def task_params
    params.require(:task).permit(:task, :task_details).merge(user_id: current_user.id)
  end


  

  def logged_in_user
    unless logged_in?
    flash[:danger] = "ログインしてください。"
    redirect_to login_url
    end
  end
  
  def corrent_user
    @user = user.find(params[:id])
    redirect_to(root_url) unless @user == current_user
  end
end