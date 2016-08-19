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

  get '/logbooks/:id' do
    if logged_in?
      @user = current_user
      @logbook = Logbook.find_by(id: params[:id])
      erb :'/logbooks/show' if @user.logbooks.include?(@logbook)
    else
      redirect '/login'
    end
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
