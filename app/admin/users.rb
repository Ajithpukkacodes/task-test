ActiveAdmin.register User do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  

  index  do
    selectable_column
    id_column
    column :email
    column :latitude
    column :longitude
    column :created_at
    actions
  end

  filter :latitude, as: :select, label: "Range", collection: [["50 KM", "50"],["100 KM", "100"]]

  controller do

    def index
      @filter_users = User.all
      unless params[:q].blank?
        @filter_users = @filter_users.near([-86.002082, -41.887958], params[:q][:latitude_eq])
        @search = @filter_users.ransack(params[:q].except(:latitude_eq))
      else
        @search = @filter_users.ransack(params[:q])
      end
        @users = @search.result
        @collection = @users.page(1).per(10)
    end
end
end
