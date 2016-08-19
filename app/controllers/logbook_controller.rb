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

  get '/logbooks/:id' do
    if logged_in?
      @user = current_user
      @logbook = Logbook.find_by(id: params[:id])
      erb :'/logbooks/show' if @user.logbooks.include?(@logbook)
    else
      redirect '/login'
    end
  end
end
