class UsersController < ApplicationController
    def index
        @users = User.all
    end

    def user_show
        @user = User.find(params[:id])
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

end
