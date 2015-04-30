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

post '/users/new' do
  @user = User.new(email: params[:email], username: params[:username])
  @user.password=(params[:password])
  @user.save!
  redirect '/'
end

get '/users/:id' do
  @spits = Spit.first(50).sort_by &:created_at
  @users_spits = Spit.where(id: params[:id])
  erb :"/users/profile"
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
