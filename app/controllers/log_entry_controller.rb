class LogEntryController < ApplicationController

  get '/log_entry/:id' do
    @log_entry = current_user.log_entries.find_by(id: params[:id])
    erb :'/log_entries/show'
  end
end
