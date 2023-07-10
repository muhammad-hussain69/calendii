class EventsController < ApplicationController

  require 'google/apis/calendar_v3'
  require "googleauth"

  def home
  end

  def show
    render 'events/show'
  end


  def view
    credentials =
      Google::Auth::UserRefreshCredentials.new(
        client_id: "139530092861-a4u6qbl11cldjf81uaqpjkbf337tt0ic.apps.googleusercontent.com",
        client_secret: "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",
        scope: 'https://www.googleapis.com/auth/calendar.events.readonly, https://www.googleapis.com/auth/userinfo.email, https://www.googleapis.com/auth/userinfo.profile'
      )

    credentials.refresh_token = current_user.refresh_token
    credentials.access_token = current_user.access_token

    client = Google::Apis::CalendarV3::CalendarService.new
    client.authorization = credentials

    @events = client.list_events('primary')

    render 'events/view'
  end

end
