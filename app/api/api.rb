class API < Grape::API
  format :json
  helpers do
    def current_user
      @current_user ||= User.authorize!(env)
    end

    def authenticate!
      error!('401 Unauthorized', 401)
    end

    def user_parameter
      ActionController::Parameters.new(params).permit(:email, :password)
    end
  end

  resource :user do
    desc "User all"
    get :user do
      @user = User.find_by(password: params[:password],email: params[:email])
      present @user, with: UserEntity
    end
  end
end
