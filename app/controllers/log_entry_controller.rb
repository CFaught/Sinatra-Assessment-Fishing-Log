class LogEntryController < ApplicationController


  get '/log_entry/new' do
    if logged_in?
      @logbooks = current_user.logbooks
      erb :'/log_entries/create'
    else
      redirect '/login'
    end
  end

  post '/log_entry' do
    if logged_in?
      log_entry = LogEntry.new(params[:log_entry])

      log_entry.date = params[:date].to_s + " " + params[:time].to_s
      log_entry.date.to_datetime

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

  post '/log_entry/:id' do
    if logged_in?
      log_entry = current_user.log_entries.find_by(id: params[:id])
      logbook = current_user.logbooks.find_by(id: params[:logbook][:id])

      if logbook
        log_entry.update(params[:log_entry])

        # make sure to save the date and time correctly with timezone
        zone = log_entry.date.to_time
        log_entry.date = params[:date].to_s + " " + params[:time].to_s + ":00 " + zone.to_s
        log_entry.date.to_datetime

        log_entry.logbook_id = logbook.id

        if log_entry.save
          redirect "/log_entry/#{ log_entry.id }"
        else
          redirect "/log_entry/#{ log_entry.id }/edit"
        end
      else
        redirect "/log_entry/#{ log_entry.id }/edit"
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

  get '/log_entry/:id/edit' do
    @log_entry = current_user.log_entries.find_by(id: params[:id])
    @logbooks = current_user.logbooks
    @date = @log_entry.date.to_date
    @time = @log_entry.date.to_time
    erb :'/log_entries/edit'
  end

  get '/log_entry/:id/delete' do
    if logged_in?
      log_entry = current_user.log_entries.find_by(id: params[:id])
      logbook = Logbook.find_by(id: log_entry.logbook_id)
      log_entry.destroy
      redirect "/logbooks/#{ logbook.id }"
    else
      redirect '/login'
    end
  end
end
