class LogbookController < ApplicationController

  get '/logbooks' do
    if logged_in?
      @user = current_user
      @logbooks = @user.logbooks
      erb :'/logbooks/index'
    else
      redirect '/login'
    end
  end

  get '/logbooks/new' do
    if logged_in?
      erb :'/logbooks/create'
    else
      redirect '/login'
    end
  end

  post '/logbooks' do
    @logbook = Logbook.new(name: params[:logbook][:name], user_id: current_user.id)

    if @logbook.save
      redirect "/logbooks/#{@logbook.id}"
    else
      redirect "/logbooks/new"
    end
  end

  post '/logbooks/:id' do
    @logbook = current_user.logbooks.find_by(id: params[:id])
    if @logbook.update(name: params[:logbook][:name])
      redirect "/logbooks/#{ @logbook.id }"
    else
      redirect "/logbooks"
    end
  end

  get '/logbooks/:id' do
    @logbook = current_user.logbooks.find_by(id: params[:id])
    if logged_in?
      if @logbook
        erb :'/logbooks/show'
      else
        redirect '/logbooks'
      end
    else
      redirect '/login'
    end
  end

  get '/logbooks/:id/edit' do
    @logbook = current_user.logbooks.find_by(id: params[:id])
    erb :'/logbooks/edit'
  end

  get '/logbooks/:id/delete' do
    logbook = current_user.logbooks.find_by(id: params[:id])
    if logbook && logbook.destroy
      redirect '/logbooks'
    else
      redirect "/logbooks/#{ params[:id] }"
    end
  end
end
