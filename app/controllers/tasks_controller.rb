class TasksController < ApplicationController
    before_action :require_user_logged_in
    before_action :correct_user, only: [:destroy]
    before_action :find_task, only:[:show, :edit, :update, :destroy]
    def index
        if logged_in?
            @tasks = current_user.tasks.order(id: :desc).page(params[:page])
        end
    end
    
    def show
        @task = current_user.tasks.find_by(id: params[:id])
        unless @task
            redirect_to root_url
        end
    end
    
    def new
        @task = Task.new
    end
    
    def create
        @task = current_user.tasks.build(task_params)
        
        if @task.save
            flash[:success] = "タスクは正常に作成されました"
            redirect_to root_url
        else
            flash.now[:danger] ="タスクの作成に失敗しました"
            render :new
        end
    end
    
    def edit
        @task = current_user.tasks.find_by(id: params[:id])
        unless @task
            redirect_to root_url
        end
    end
    
    def update
        @task = current_user.tasks.find_by(id: params[:id])
        unless @task
            redirect_to root_url
        end
        if @task.update(task_params)
            flash[:success] = "タスクは正常に更新されました"
            redirect_to @task
        else
            flash.now[:danger] = "タスクは更新されませんでした"
            render :edit
        end
    end
    
    def destroy
        @task.destroy
        
        flash[:success] = "タスクは正常に削除されました"
        redirect_to @task
    end
    
    private
    
    def find_task
        @task = Task.find(params[:id])
    end
    
    def task_params
        params.require(:task).permit(:content, :status)        
    end
    
    def correct_user
        @task = current_user.tasks.find_by(id: params[:id])
        unless @task
            redirect_to root_url
        end
    end
end
