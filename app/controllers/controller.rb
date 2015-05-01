require 'bcrypt'

get '/' do
  @spits = Spit.first(50).sort_by &:created_at
  @login_error = session[:login_error]
  if !session[:login_error].nil?
    session.delete[:login_error]
  end
  erb :index
end

post '/login' do
  @user = User.where(email: params[:email]).first
  if @user && @user.password == params[:password]
    session[:user_id] = @user.id
    session[:login_error] = nil
    redirect "/users/#{@user.id}"
  else
    session[:login_error] = "Invalid email or password"
    redirect '/'
  end
end

get '/users/new' do
  erb :"/users/new"
end

post '/users' do
  @user = User.new(
    email: params[:email],
    username: params[:username],
    first_name: params[:first_name],
    last_name: params[:last_name],
    about_me: params[:about_me],
    picture_url: params[:picture_url],
    )
  @user.password=(params[:password])
  @user.save!
  redirect '/'
end

post '/spits' do
  @spit = Spit.new(user_id: session[:user_id], content: params[:content])
  if @spit.valid?
    @spit.save
    redirect '/'
  else
    status 400
    redirect '/'
  end
end

get '/users/:id' do
  @spits = Spit.first(50).sort_by &:created_at
  @login_user = User.where(id: session[:user_id]).first
  @user_profile = User.where(id: params[:id]).first
  @users_spits = Spit.where(user_id: params[:id])
  erb :"/users/profile"
end

get '/users/:id/edit' do
  @user = User.where(id: session[:user_id]).first
  erb :"/users/edit"
end

put '/users/:id' do
  @user = User.where(id: session[:user_id]).first
  @user.username = params[:username]
  @user.email = params[:email]
  @user.first_name = params[:first_name]
  @user.last_name = params[:last_name]
  @user.about_me = params[:about_me]
  @user.picture_url = params[:picture_url]
  @user.save
  redirect "/users/#{session[:user_id]}"
end

delete '/users/:id' do
  User.destroy(params[:id])
  redirect '/'
end

get '/spits/:id' do
  @spit = Spit.where(id: params[:id]).first
  erb :'spits/spit_page'
end

delete '/spits/:id' do
  @spit = Spit.where(id: params[:id]).first
  @spit.destroy
  redirect '/'
end

post '/followers' do
  @follow = Follower.create(follower: session[:user_id], followee: params[:followee_id])
  redirect "users/#{params[:followee_id]}"
end

delete '/followers' do
  @follow = Follower.where(follower: session[:user_id], followee: params[:followee_id]).first
  @follow.destroy
  redirect "users/#{params[:followee_id]}"
end

