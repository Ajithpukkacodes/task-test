class V1::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token
  
  respond_to :json

  def create
    # self.resource = warden.authenticate(auth_options)
    # if self.resource
    #   sign_in(resource_name, resource)
    #   yield resource if block_given?
    #   render json: { status: { success: "Login sucessfully."} }
    # else
    #   render json: { status: { error: ['Invalid email or password.'] }}, status: :unprocessable_entity
    #   return
    # end
    @user = User.find_by_email(params[:email])
    if @user && @user.valid_password?(params[:password])
      sign_in :user, @user
      render json: { status: { success: "Login sucessfully."} }
    else
      render json: { status: { error: ['Invalid email or password.'] }}, status: :unprocessable_entity
    end
  end

  private
  
  def respond_with(resource, _opts = {})
    render json: resource
  end

  def respond_to_on_destroy
    head :ok
  end
end