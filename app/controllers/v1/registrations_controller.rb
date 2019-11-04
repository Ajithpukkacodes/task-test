class V1::RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token
  respond_to :json

  def create
  	p "111111111"
    @user = User.new(user_params)
    if @user.save
      render json: { status: { success: "User created sucessfully."} }
    else
      render json: { status: { error: @user.errors.full_messages }}, status: :unprocessable_entity
    end
  end
  private

  def user_params
    params.require(:registration).permit(:email, :password, :password_confirmation, :first_name, :second_name, :latitude, :longitude)
  end
end