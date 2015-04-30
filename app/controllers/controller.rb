require 'bcrypt'

get '/' do
  erb :index
end

get '/users' do
  @users = User.all
  @current_user = User.find(session[:user_id])
  @hero = User.where(id: params[:id]).first
  erb :'users/users'
end

get '/users/new' do
  @user = User.new
  erb :"users/new_acct"
end

post '/users' do
  password_hash = BCrypt::Password.create(params[:encrypted_password])
  @user = User.new(username: params[:username],  encrypted_password: password_hash)
  if @user.save
    redirect "/users/#{@user.id}"
  else
    erb :'users/new_acct'
  end
end

get '/users/:id' do
  @user = User.where(id: params[:id]).first
  erb :'users/profile'
end

get '/users/:id/edit' do
  @user = User.where(id: params[:id]).first
  erb :'users/edit'
end

patch '/users/:id' do
  @user = User.where(id: params[:id]).first
  @user.update(photo_url: params[:photo_url], bio: params[:bio])
  if @user.save
    redirect "/users/#{@user.id}"
  else
    erb :'users/edit'
  end
end

delete '/users/:id' do
  @user = User.where(id: params[:id]).first
  @user.destroy
  redirect '/'
end

get '/users/:id/tweets/new' do
  @user = User.where(id: params[:id]).first
  @tweet = Tweet.new
  erb :'tweets/new_tweet'
end

post '/users/:id' do
  @user = User.where(id: params[:id]).first
  @tweet = Tweet.new(user_id: params[:id], bat_signal: params[:bat_signal])
  if @tweet.save
    erb :'users/profile'
  else
    redirect '/tweets/new'
  end
end

post '/users/:id/follow/new' do
  current_user = User.find(session[:user_id])
  hero = User.where(id: params[:id]).first
  current_user.i_am_a_fan_relationships << hero
  if current_user.save
    redirect "/users/#{hero.id}"
  else
    erb :'users/users'
  end
end

post '/users/:id/unfollow/new' do
  current_user = User.find(session[:user_id])
  hero = User.where(id: params[:id]).first
  current_user.i_am_a_fan_relationships.delete(hero)
  if current_user.save
    erb :'users/users'
  else
    redirect "/users/#{hero.id}"
  end
end



#### WE CAN USE THIS ROUTE IN CASE OUR OTHER ONE GIVES AN ERROR####
# post "/login" do
#   if @user = User.find_by(username: params[:username])
#     if @user.authenticate(params[:encrypted_password])
#     session[:user_id] = @user.id
#     redirect "/profile"
#   else
#     redirect "/login"
#   end
