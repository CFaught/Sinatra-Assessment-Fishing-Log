class UserController < ApplicationController

  get '/signup' do
    erb :'/users/signup'
  end

  post '/signup' do
    user = User.new(params[:user])
    if user.save
      redirect "/users/#{user.id}"
    else
      redirect '/signup'
    end
  end

  get '/login' do
    erb :'/users/login'
  end

  post '/login' do
    login(params[:username], params[:password])
  end

  get '/logout' do
    logout!
    redirect '/login'
  end

  get '/users/:id' do
    @user = User.find_by_id(params[:id])
    if logged_in? && current_user == @user
      erb :'/users/show'
    else
      redirect '/login'
    end

  end

end
