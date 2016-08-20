class LogEntryController < ApplicationController


  get '/log_entry/new' do
    @logbooks = current_user.logbooks
    erb :'/log_entries/create'
  end

  post '/log_entry' do
    binding.pry
    if logged_in?
      log_entry = LogEntry.new(params[:log_entry])
      logbook = current_user.logbooks.find_by(id: params[:logbook][:id])


      if logbook
        log_entry.logbook_id = logbook.id
        if log_entry.save
          redirect "/log_entry/#{log_entry.id}"
        else
          redirect '/log_entry/new'
        end
      else
        redirect '/log_entry/new'
      end
    else
      redirect '/login'
    end
  end

  get '/log_entry/:id' do
    @log_entry = current_user.log_entries.find_by(id: params[:id])
    @logbook = Logbook.find_by(id: @log_entry.logbook_id)
    @fish = @log_entry.creatures
    erb :'/log_entries/show'
  end
end
