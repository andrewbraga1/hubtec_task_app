class TasksController < ApplicationController
  # configurando quais métodos realizarão a chamada do metodo 'set_task'
  before_action :set_task, only: [:update, :destroy]
  def index
    
    @tasks = Task.all.order("created_at DESC")
    
    if @tasks.nil?
      render json: { message: "Erro. Tente novamente mais tarde." }, status: 500
    else
      if @tasks.length == 0
        render json: { message: "Nenhuma tarefa foi encontrada." }, status: 200
      else
        render json: @tasks
      end 
    end  
  end

  def create
    task = Task.create(task_param)
    if task.save
      render json: { message: "Tarefa foi criada com sucesso.", task:task }, status: 200
    else
      render json: { message: "Não foi possivel criar essa tarefa. Tente novamente mais tarde." }, status: 500
    end  
  end

  def update
    
    if @task.update_attributes(task_param)
      render json: { message: "Tarefa foi atualizada com sucesso.", task:@task }, status: 200
    else
      render json: { message: "Não foi possivel atualizar essa tarefa. Tente novamente mais tarde." }, status: 500
    end 
  end

  def destroy
   
    if @task.destroy
      render json: { message: "Tarefa foi excluída com sucesso." }, status: 200
    else  
      render json: { message: "Não foi possivel excluir essa tarefa. Tente novamente mais tarde." }, status: 500
    end
  end
  
  private
    # tarefa sendo definida pelo id
    def set_task
      @task = Task.find(params[:id])
    end
    # definindo a lista branca dos parâmetros permitidos
    def task_param
      params.require(:task).permit(:name, :description,:deadline)
    end
end