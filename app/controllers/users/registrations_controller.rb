# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    @user = User.new
  end

  # POST /resource
  def create
    @user = User.new(sign_up_params)
    unless @user.valid?
      flash.now[:alert] = @user.errors.full_messages
      render :new and return
    end
    session["devise.regist_data"] = {user: @user.attributes}
    session["devise.regist_data"][:user]["password"] = params[:user][:password]
    @profile = @user.build_profile
    # render :new_profile
    redirect_to  profiles_path
  end

  def new_profile
    @profile = Profile.new
  end

  def create_profile
    @user = User.new(session["devise.regist_data"]["user"])
    @profile = @user.build_profile(profile_params)
    # @profile = @user.profile.new()
    # valid? = varidationに引っかからないとき。 invalid? 
    if @profile.invalid?
      flash.now[:alert] = @profile.errors.full_messages
      render :new_profile and return
    end
    
    session["profile"] = @profile.attributes
    @shipping_destination = @user.build_shipping_destination
    render :new_shipping 
  end

  def create_shipping_destination
    @user = User.new(session["devise.regist_data"]["user"])
    @profile = Profile.new(session["profile"])
    @shipping_destination = ShippingDestination.new(shipping_destination_params)
  
    if @shipping_destination.invalid?
      flash.now[:alert] = @shipping_destination.errors.full_messages
      render :new_shipping  and return
    end
    @user.build_profile(@profile.attributes)
    @user.build_shipping_destination(@shipping_destination.attributes)
    @user.save
    sign_in(:user, @user)
    redirect_to root_path
  end


  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :first_name_kana, :last_name_kana,:birth_year,:birth_month,:birth_day)
  end


  def shipping_destination_params
    params.require(:shipping_destination).permit(:destination_first_name, :destination_last_name, :destination_first_name_kana, :destination_last_name_kana, :post_code, :prefecture_code, :city, :address, :building, :phone_number)
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end