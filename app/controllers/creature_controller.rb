class CreatureController < ApplicationController

  get '/log_entry/:id/add_fish' do
    @log_entry = LogEntry.find_by(id: params[:id])
    erb :'/creatures/new'
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

  get '/fish/:id' do
    if logged_in?
      @creature = Creature.find_by(id: params[:id])
      @log_entry = @creature.log_entry
      erb :'/creatures/show'
    else
      redirect '/login'
    end
  end
end
