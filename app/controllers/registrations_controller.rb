class RegistrationsController < Devise::RegistrationsController

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in :user, @user
      flash[:notice] = "Logged in!"
      redirect_to home_index_path
    else
      render 'new'
    end
  end
  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :second_name, :latitude, :longitude)
  end
end