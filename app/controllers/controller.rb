require 'bcrypt'

get '/' do
  @spits = Spit.first(50).sort_by &:created_at
  erb :index
end

get '/spits/:id' do
  @spit = Spit.where(id: params[:id]).first
  erb :'spits/spit_page'
end

delete '/spits/:id' do
end

put '/spits/:id' do
end
