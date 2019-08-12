class Api::UsersController < ApplicationController
    before_action :set_user, only: [:show, :update, :destroy]
    before_action :authenticate_api_user!
  
    # GET /users
    # GET /users.json
    def index
      @users = User.all
      
      
    end

       
    # GET /users/1
    # GET /users/1.json
    def show
      
    end
  
     
    # POST /users
    # POST /users.json
    def create
      @user = User.new(user_params)
           
      if @user.valid? && @user.save
        render json: {message: "Usuário foi criado com sucesso."}, status: 200 
      else
        render json: {message: "Usuário não foi criado! Verifique se todos os campos foram preenchidos corretamente."}, status: 400
      end  
        
    end
  
    # PATCH/PUT /users/1
    # PATCH/PUT /users/1.json
    def update
        if @user.update(user_params) 
          
            render json: {message: "Usuário foi atualizado com sucesso."}, status: 200
          
        else
            render json: {message: "Usuário não foi atualizado! Verifique se todos os campos foram preenchidos corretamente."}, status: 400
          
        end
      end
    end
  
    # DELETE /users/1
    # DELETE /users/1.json
    def destroy
     
      if @user.destroy
        render json: {message: "Usuário foi excluído com sucesso."}, status: 200
      else
        render json: {message: "Não foi possivel excluir esse usuário. Tente novamente mais tarde."}, status: 500
      end    
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_user
        @user = User.find(params[:id])
      end
  
      # Never trust parameters from the scary internet, only allow the white list through.
      def user_params
        # name, :email, :password, :password_confirmation, :birthdate , :gender, :cardiac_disease, :diabetes_disease, :cancer_disease, :weight_kg, :waist_cm, :height_m
        params.require(:user).permit(:email, :name, :password, :password_confirmation)  
      end
      
     
end
