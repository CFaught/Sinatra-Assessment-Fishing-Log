class CreatureController < ApplicationController

  get '/log_entry/:id/add_fish' do
    @log_entry = LogEntry.find_by(id: params[:id])
    erb :'/creatures/new'
  end

  get '/fish/:id/edit' do
    @creature = Creature.find_by(id: params[:id])
    @log_entry = @creature.log_entry
    erb :'/creatures/edit'
  end

  get '/fish/:id/delete' do
    if logged_in?
      creature = Creature.find_by(id: params[:id])
      log_entry = creature.log_entry
      # only the user who created a fish can delete it
      if current_user.id == creature.log_entry.logbook.user_id
        creature.destroy
        redirect "/log_entry/#{log_entry.id}"
      else
        redirect "/fish/#{creature.id}"
      end
    else
      redirect '/login'
    end
  end

  get '/fish' do
    erb :'/creature/index'
  end

  post '/fish' do
    binding.pry
    if logged_in?
      fish = Creature.new(params[:fish])
      if fish.save
        redirect "/fish/#{ fish.id }"
      else
        redirect "/log_entry/#{ params[:fish][:log_entry_id] }/add_fish"
      end
    else
      redirect '/login'
    end

  end

  post '/fish/:id' do
    if logged_in?
      @creature = Creature.find_by(id: params[:id])
      @creature.update(params[:fish])
      @log_entry = @creature.log_entry
      erb :'/creatures/show'
    else
      redirect '/login'
    end
  end

  get '/fish/:id' do
    if logged_in?
      @creature = Creature.find_by(id: params[:id])
      @log_entry = LogEntry.find_by(id: @creature.log_entry_id)
      erb :'/creatures/show'
    else
      redirect '/login'
    end
  end
end
