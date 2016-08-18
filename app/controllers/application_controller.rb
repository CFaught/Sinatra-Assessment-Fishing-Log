class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, 'fishing_logbook'
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  #setup controller here
  get '/' do
   erb :index
  end

  helpers do

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      session[:user_id]
    end

    def login(username, password)
      user = User.find_by(:username => username)
      if user && user.authenticate(password)
        session[:user_id] = user.id
        redirect "/users/#{user.id}"
      else
        redirect '/users/login'
      end
      user
    end

    def logout!
      session.clear
    end
  end
end
