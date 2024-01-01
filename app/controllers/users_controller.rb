class UsersController < ApplicationController

    before_action :correct_user, only: [:user_show, :edit, :update, :destroy]

    def index
        if params[:search].present?
          @users = User.where("email LIKE ?", "%#{params[:search]}%")
          @search_performed = true
        else
          @users = User.all
          @search_performed = false
        end

        case params[:sort_by]
        when 'created_at'
            @users = @users.order(created_at: :desc)
        when 'name'
            @users = @users.order(:name)
        end
    
        @search_performed = params[:search].present?
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
      @user = User.new(user_param)
      if @user.save
          redirect_to user_path(@user), notice: "User successfully created"
      else
          Rails.logger.info(@user.errors.inspect)
          render :new
      end
    end

    def destroy
        @user = User.find(params[:id])
        @user.destroy
        redirect_to users_path, notice: 'ユーザーが削除されました。'
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        if @user.update(user_param)
          redirect_to users_path, notice: 'ユーザーがupdateされました。'
        else
          render :edit, status: :unprocessable_entity
        end
    end      

    def confirm_email
        user= User.find_by(confimation_token: params[:token])
        if user
            user.update(confirmed_at: Time.current, confimation_token: nil)
            redirect_to root_path, notice: 'Your email has been confirmed'
        else
            redirect_to root_path, alert: 'Invaild confirmation link'
        end
    end

    private
        def user_param
            params.require(:user).permit(:name, :email, :password, :password_confirmation)
        end

        def correct_user
          @user = User.find_by(id: params[:id])
          unless @user && @user == current_user
            flash[:alert] = 'Loginしてください！'
            redirect_to root_path
          end
        end
          
end