class UserController < ApplicationController

  get '/signup' do
    erb :'/users/signup'
  end

  post '/signup' do
    binding.pry
    @user = User.create(params[:user])
    redirect "/users/#{@user.id}"
  end

  get '/login' do
    erb :'/users/login'
  end

  post '/login' do
    @user = login(params[:username], params[:password])
    redirect "/users/#{ @user.id }"
  end

  get '/users/:id' do
    @user = User.find(params[:id])
    if logged_in?
      erb :'/users/show'
    else
      redirect '/login'
    end

  end

end
