

######################### Seed Database with Users #############################

user_limit = ENV["SEED_USER_LIMIT"].to_i
space_limit = ENV["SEED_SPACE_LIMIT"].to_i

if User.all.length < user_limit.to_i

  user_count = User.all.length
  (user_limit - user_count).times do |user_index|

    user_hash = {}

    user_hash[:first_name]            = Faker::Name.first_name
    user_hash[:last_name]             = Faker::Name.last_name
    user_hash[:email]                 = "user#{user_count + user_index + 1}@example.com"
    user_hash[:password]              = "password"
    user_hash[:password_confirmation] = "password"

    User.create(user_hash)
  end

end

if Space.all.length < space_limit.to_i

  space_count = Space.all.length
  (space_limit - space_count).times do |user_index|

    space_hash = {}

    address = Faker::Address.name.split(" ")

    space_hash[:owner_id]              = User.first(:order => "RANDOM()").id
    space_hash[:title]                 = Faker::Company.catch_phrase
    space_hash[:booking_rate_daily]    = rand(200)
    space_hash[:residence_type]        = rand(Space.residence_types.length)
    space_hash[:bedroom_count]         = rand(5 + 1)
    space_hash[:bathroom_count]        = rand(3 + 1)
    space_hash[:room_type]             = rand(Space.room_types.length)
    space_hash[:bed_type]              = rand(Space.bed_types.length)
    space_hash[:accommodates]          = rand(6 + 1)
    space_hash[:amenities]             = rand(2 ** Space.amenities_list.length)
    space_hash[:description]           = Faker::Company.catch_phrase
    space_hash[:house_rules]           = Faker::Company.catch_phrase
    space_hash[:address]               = "#{(rand(125) + 1).ordinalize} and #{(rand(10) + 1).ordinalize}"
    space_hash[:city]                  = ENV["SEED_CITY"]
    space_hash[:country]               = ENV["SEED_COUNTRY"]

    Space.create(space_hash)
    sleep(0.25)
  end

end

################# Associate Users/Spaces with Random Photos ####################

User.all.each do |user|
  unless user.user_photos.length > 0
    photos = UserPhoto.where("user_id IS NULL")
    if photos.length > 0
      photo = photos.sample
      photo.update_attributes(user_id: user.id)
    end
  end
end

Space.all.each do |space|
  unless space.space_photos.length > 0
    photos = SpacePhoto.where("space_id IS NULL")
    if photos.length > 0
      photo = photos.sample
      photo.update_attributes(space_id: space.id)
    end
  end
end

