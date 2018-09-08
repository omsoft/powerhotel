module Api
  module V1

    class ApiController < ApplicationController
      #include Devise::Controllers::Helpers

      skip_before_action :verify_authenticity_token, if: Proc.new { |c| c.request.format.json? }

      before_filter :authenticate_user_from_token!
      before_filter :authenticate_user!

      before_action :set_locale

      respond_to :json

      def set_locale
        set_locale_from_browser
      end

      private
      
      def authenticate_user_from_token!
        auth_email = request.headers["X-AUTH-EMAIL"]
        auth_token = request.headers["X-AUTH-TOKEN"]
        user       = auth_email.present? && User.find_by_email(auth_email)

        if user && Devise.secure_compare(user.authentication_token, auth_token)
          @current_user = User.find_by_email(auth_email)
          sign_in user, store: false
        else
          render json: 401, status: :unauthorized
        end
      end

      def set_locale_from_browser
        if (session[:initialized].nil? || !session[:initialized])
          logger.debug "* Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
          I18n.locale = extract_locale_from_accept_language_header
          logger.debug "* Locale set to '#{I18n.locale}'"
        else
          logger.debug "* Locale already set to '#{I18n.locale}'"
        end
        session[:initialized] = true
      end

      def extract_locale_from_accept_language_header
        request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
      end

    end

  end
end