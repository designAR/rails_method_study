class UsersController < ApplicationController
    def index
        @users = User.all
    end

    def user_show
        @user = User.find_by(id: params[:id])
        redirect_to users_path, alert: 'ユーザーが見つかりませんでした。' if @user.nil?
    end  

    def user_search
        if params[:name].blank?
            flash.now[:alert] = '入力してください。'
            render 'user_search'
        else
            @user = User.find_by(name: params[:name])
    
            if @user.nil?
                flash.now[:alert] = 'そのユーザーは存在しません。'
                render 'user_search'
            else
                render 'user_show'
            end
        end
    end

    def new
        @user =User.new
    end

    def create
        @user = User.create(user_param)
      
        if @user.persisted?
          redirect_to user_path(@user), notice: 'ユーザーが登録されました。'
        else
          render :new
        end
    end      
       
    def destroy
        @user = User.find(params[:id])
        @user.destroy
        redirect_to users_path, notice: 'ユーザーが削除されました。'
    end

    private
        def user_param
            params.require(:user).permit(:name, :email, :password, :password_confirmation)
        end
end
