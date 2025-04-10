class Users::SessionController < Devise::SessionsController
    def new
        super
    end

    def create
        self.resource = User.find_for_authentication(email: params[:email])

        if self.resource&.valid_password?(params[:password])
            set_flash_message!(:succes, :signed_in)
            sign_in(resource_name, resource)
            yield resource if block_given?
            respond_with resource, location: after_sign_in_path_for(resource)
        else
            flash[:alert] = "Invalid email or password"
            redirect_to new_user_session_path
        end
    end

    def destroy
        signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
        set_flash_message! :notice, :signed_out if signed_out
        yield if block_given?
        respond_to_on_destroy
    end
end
