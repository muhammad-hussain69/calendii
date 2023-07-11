class EventsController < ApplicationController

  require 'google/apis/calendar_v3'
  require "googleauth"

  def home
  end

  def view
    credentials =
      Google::Auth::UserRefreshCredentials.new(
        client_id: Rails.application.config.client_id,
        client_secret: Rails.application.config.client_secret,
        scope: 'https://www.googleapis.com/auth/calendar.events.readonly, https://www.googleapis.com/auth/userinfo.email, https://www.googleapis.com/auth/userinfo.profile'
      )

    credentials.refresh_token = current_user.refresh_token
    credentials.access_token = current_user.access_token

    client = Google::Apis::CalendarV3::CalendarService.new
    client.authorization = credentials

    if client.authorization.access_token
      if client.authorization.expired?
        resource.destroy
        sign_out_all_scopes
        redirect_to new_user_session_path, alert: "Your session expired. You need to Sign In with Google."
      else
        @events = client.list_events('primary')
        render 'events/view'
      end
    else
      sign_out_all_scopes
      redirect_to new_user_session_path, alert: "You need to Sign In with Google to view Events."
    end

  end
end
