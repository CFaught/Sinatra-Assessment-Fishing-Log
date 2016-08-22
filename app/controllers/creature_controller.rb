class CreatureController < ApplicationController

  get '/fish' do
    erb :'/creatures/index'
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
