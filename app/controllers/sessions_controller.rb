class SessionsController < ApplicationController
  def sign_in
  end

  def auth
    session[:user_id] = request.env['omniauth.auth']['uid']
    session[:username] = request.env['omniauth.auth']['info']['nickname']
    session[:token] = request.env['omniauth.auth']['credentials']['token']
    session[:secret] = request.env['omniauth.auth']['credentials']['secret']
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['twitter_key']
      config.consumer_secret     = ENV['twitter_secret']
      config.access_token        = session[:token]
      config.access_token_secret = session[:secret]
    end

  end

  def sign_out
    reset_session
  end
end
