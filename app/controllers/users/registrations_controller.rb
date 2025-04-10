class Users::RegistrationsController < ApplicationController
    def new
    end

    def create
        @user = User.new(sign_up_params)

        if @user.save
            flash[:notice] = "Registration successful!"
            redirect_to new_user_session_path
        else
            flash[:alert] = @user.errors.full_messages.join(", ")
            render :new, status: :unprocessable_entity
        end
    end

    private

    def sign_up_params
        params.permit(:firstname, :lastname, :email, :phone_number, :birthday, :password)
    end
end
