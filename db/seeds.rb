# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# hey copilot let's make some anime seeds from this api https://kitsu.io/api/edge/anime
# https://kitsu.docs.apiary.io/#reference/anime/anime-collection/get-anime

require "json"
require "open-uri"
puts "Are you sure you want to delete all the data?"
puts "Type 'yes' to continue"
answer = gets.chomp
if answer != "yes"
  puts "Aborting..."
  exit
end

Review.destroy_all
Achievement.destroy_all
Watchlist.destroy_all
Episode.destroy_all
Anime.destroy_all
User.destroy_all
# 1. get the data from the api
# 2. parse the data
# 3. create the records

puts "Creating animes..."
url = "https://api.jikan.moe/v4/top/anime?type=TV"

# 1. get the data from the api
anime_serialized = URI.open(url).read

# 2. parse the data
animes = JSON.parse(anime_serialized)

# 3. create the records
animes["data"].each do |anime|
  Anime.create!(
    title: anime["title_english"],
    synopsis: anime["synopsis"],
    date_start: anime["aired"]["from"],
    date_finish: anime["aired"]["to"],
    genre: anime["genres"][0]["name"],
    rating: anime["score"],
    episodecount: anime["episodes"],
    api_id: anime["mal_id"],
    image: anime["images"]["jpg"]["image_url"]
  )
end

puts "Created #{Anime.count} animes"

puts "Creating users..."

10.times do
  User.create!(
    email: Faker::Internet.email,
    username: Faker::Internet.username,
    password: "123456"
  )
end

puts "Created #{User.count} users"


puts "Creating episodes..."

Anime.all.each do |anime|
  [anime.episodecount, 2].min.times do |n|
  begin
    sleep(1)
    episode_serialized = URI.open("https://api.jikan.moe/v4/anime/#{anime.api_id}/episodes/#{n + 1}").read
    puts "Creating episode #{n + 1} for #{anime.title}"
    episodes = JSON.parse(episode_serialized)
    if episodes["data"].present?
      Episode.create!(
        title: episodes["data"]["title"],
        description: episodes["data"]["synopsis"],
        image: anime.image,
        date_aired: episodes["data"]["aired"],
        rating: anime.rating,
        anime: anime,
      )
    end
    rescue
      p "Broken"
    end
  end
end

puts "Created #{Episode.count} episodes"

puts "Creating reviews..."
# Let's make some reviews
Anime.all.each do |anime|
  reviews_serialized = URI.open("https://api.jikan.moe/v4/anime/#{anime.api_id}/reviews").read
  reviews = JSON.parse(reviews_serialized)
    reviews["data"].each do |review|
      begin
      sleep(1)

        puts "Creating review for #{anime.title}"
        if review.present?
          Review.create!(
            content: review["review"],
            rating: review["score"],
            user: User.all.sample,
            anime: anime,
          )
        end
      rescue
        p "Broken"
      end
    end
end

puts "Created #{Review.count} reviews"

puts "Creating achievements..."

# # Let's make some achievements
# Achievement.create!(
#   name: "First Review",
#   description: "You wrote your first review!",
#   image: "https://i.imgur.com/6Z2ZQ0M.png",
#   points: 10
# )

# Achievement.create!(
#   name: "First Episode",
#   description: "You watched your first episode!",
#   image: "https://i.imgur.com/6Z2ZQ0M.png",
#   points: 10
# )

# Achievement.create!(
#   name: "First Anime",
#   description: "You watched your first anime!",
#   image: "https://i.imgur.com/6Z2ZQ0M.png",
#   points: 10
# )

# Achievement.create!(
#   name: "Anime Master",
#   description: "You watched 100 episodes!",
#   image: "https://i.imgur.com/6Z2ZQ0M.png",
#   points: 100
# )

# Achievement.create!(
#   name: "Anime God",
#   description: "You watched 1000 episodes!",
#   image: "https://i.imgur.com/6Z2ZQ0M.png",
#   points: 1000
# )

# Achievement.create!(
#   name: "Anime King",
#   description: "You watched 10000 episodes!",
#   image: "https://i.imgur.com/6Z2ZQ0M.png",
#   points: 10000
# )

# Achievement.create!(
#   name: "Super Reviewer",
#   description: "You wrote 100 reviews!",
#   image: "https://i.imgur.com/6Z2ZQ0M.png",
#   points: 100
# )

# Achievement.create!(
#   name: "Review Master",
#   description: "You wrote 1000 reviews!",
#   image: "https://i.imgur.com/6Z2ZQ0M.png",
#   points: 1000
# )

# Achievement.create!(
#   name: "Review God",
#   description: "You wrote 10000 reviews!",
#   image: "https://i.imgur.com/6Z2ZQ0M.png",
#   points: 10000
# )

# Achievement.create!(
#   name: "Anime Addict",
#   description: "You watched 100 animes!",
#   image: "https://i.imgur.com/6Z2ZQ0M.png",
#   points: 100
# )

# Achievement.create!(
#   name: "Anime Maniac",
#   description: "You watched 1000 animes!",
#   image: "https://i.imgur.com/6Z2ZQ0M.png",
#   points: 1000
# )

# Achievement.create!(
#   name: "Anime God",
#   description: "You watched 10000 animes!",
#   image: "https://i.imgur.com/6Z2ZQ0M.png",
#   points: 10000
# )

User.all.each do |user|
  Achievement.create!(
    name: "First Review",
    description: "You wrote your first review!",
    points: 10,
    user: user
  )
end
puts "Created #{Achievement.count} achievements"

puts "Creating user profiles..."

User.all.each do |user|
  UserProfile.create!(
    user: user,
    bio: Faker::Lorem.paragraph(sentence_count: 2),
    photo: "https://i.imgur.com/6Z2ZQ0M.png",
    # to add
    # points: 0
  )
end

puts "Created #{UserProfile.count} user profiles"

puts "Creating user watchlists..."

User.all.each do |user|
  Watchlist.create!(
    user: user,
    status: true,
    notes: Faker::Lorem.paragraph(sentence_count: 2),
    anime: Anime.all.sample
  )
end

puts "Created #{Watchlist.count} user watchlists"
