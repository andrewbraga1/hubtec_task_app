class Api::V1::TasksController < Api::V1::ApiController
 
  # configurando quais métodos realizarão a chamada do metodo 'set_task'
  before_action :set_task, only: [:show,:update, :destroy]
  def index
    
    @tasks = Task.where("user_id=?",current_api_user.id).order("created_at DESC")
    
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
    task.user_id = current_api_user.id
    if task.save
      render json: { message: "Tarefa foi criada com sucesso.", task:task }, status: 200
    else
      render json: { message: "Não foi possivel criar essa tarefa. Tente novamente mais tarde.",error:task.errors.full_messages }, status: 500
    end  
  end

  def show
    unless @task.nil?
      if @task.user_id == current_api_user.id
        render json:  @task 
      else 
        render json: { message: "A tarefa somente pode ser visualizada pelo propriétario." }, status: 500
      end
    else  
      render json: { message: "Não foi possivel encontrar a tarefa desejada." }, status: 500
    end
    
      
      
  end

  def update
    if @task.user_id == current_api_user.id  
      if @task.update_attributes(task_param)
        render json: { message: "Tarefa foi atualizada com sucesso.", task:@task }, status: 200
      else
        render json: { message: "Não foi possivel atualizar essa tarefa. Tente novamente mais tarde." }, status: 500
      end 
    else
      render json: { message: "A tarefa somente pode ser atualizada pelo propriétario." }, status: 500
    end  
  end

  def destroy
    if @task.user_id == current_api_user.id  
      if @task.destroy
        render json: { message: "Tarefa foi excluída com sucesso." }, status: 200
      else  
        render json: { message: "Não foi possivel excluir essa tarefa. Tente novamente mais tarde." }, status: 500
      end
    else
      render json: { message: "A tarefa somente pode ser excluída pelo propriétario." }, status: 500
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