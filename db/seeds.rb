require 'Faker'

10.times do |index|
  User.create(
    username: Faker::Internet.user_name,
    email:  Faker::Internet.safe_email,
    password: Faker::Internet.password,
    first_name: Faker::Name.first_name,
    last_name:  Faker::Name.last_name,
    about_me:  Faker::Lorem.paragraph,
    picture_url:  Faker::Avatar.image,
    )
end

(1..10).each do |user_id|
  10.times do |index|
    Spit.create(
      content: Faker::Lorem.paragraph,
      user_id: user_id,
      )
  end
end
