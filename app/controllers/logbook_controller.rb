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
end
