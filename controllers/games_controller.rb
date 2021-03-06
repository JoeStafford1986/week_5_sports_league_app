require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry' )
require_relative( '../models/game.rb' )
require_relative( '../models/team.rb' )

#show all games
get '/games' do
  @games = Game.all()
  erb ( :"games/index" )
end

#go to form to add game
get '/games/new' do
  @teams = Team.all()
  erb(:"games/new")
end

#add new game
post '/games' do
  @message = ": Unable to Add"
  @game = Game.new(params)
  if @game.team1_score != @game.team2_score
    @game.save()
    redirect '/games'
  end
  erb(:"games/error")
end

#show singular game
get '/games/:id' do
  @teams = Team.all()
  @game = Game.find(params[:id])
  erb(:"games/show")
end

#go to edit form
get '/games/:id/edit' do
  @game = Game.find(params[:id])
  @teams = Team.all()
  erb(:"games/edit")
end

#run update on edited game
post '/games/:id/edit' do
  @message = ": Unable to Edit"
  @game = Game.new(params)
  if @game.team1_score != @game.team2_score
    @game.update()
    redirect '/games'
  end
  erb(:"games/error")
end

#deletes game
post '/games/:id/delete' do
  game = Game.find(params[:id])
  game.delete()
  redirect '/games'
end
