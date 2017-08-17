class Api::V1::BaseController < ApplicationController
  # before_action :authenticate_user_using_auth_token
  # before_action :authenticate_user!

  respond_to :json

  rescue_from Exception, with: :handle_api_exceptions
  rescue_from ArgumentError, with: :handle_argument_exceptions
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def render_errors(errors, status = 422)
    render json: { success: false, message: errors }, status: status
  end

  def user_not_authorized
    error_message = 'User not authorized to perform this action.'

    respond_error(error_message, 403)
  end

  def record_not_found
    error_message = 'Record not found.'

    render_errors(error_message, 404)
  end

  def handle_argument_exceptions exception
    log_exception exception

    render_errors(exception.message, 422)
  end

  def handle_api_exceptions exception
    log_exception exception

    error_message = 'Something went wrong. Please try again later.'
    render_errors(error_message, 500)
  end

  def log_exception exception
    Rails.logger.info exception.class.to_s
    Rails.logger.info exception.to_s
    Rails.logger.info exception.backtrace.join("\n")
  end

  def authenticate_user_using_auth_token
    user_email = params[:email].presence || request.headers['X-Auth-Email']
    auth_token = request.headers['X-Auth-Token'].presence

    @user = user_email && User.find_by("lower(email) = ? ", user_email.downcase)

    if @user && Devise.secure_compare(@user.authentication_token, auth_token)
      sign_in @user, store: false
    else
      render_errors('Could not authenticate with the provided credentials', 401)
    end
  end
end
