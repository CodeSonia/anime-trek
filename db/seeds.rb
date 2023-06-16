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

random_comments = [
  "This is a great anime!",
  "This anime is so good!",
  "I love this anime so much!",
  "This is the best anime I've ever seen!",
  "I don't like this anime!",
  "I hate this anime!",
  "This anime is so bad!",
  "This anime is so boring!",
  "This anime is so stupid!",
  "This anime is so dumb!",
  "This anime is so lame!",
  "This anime is so trash!",
  "This anime is so overrated!",
  "This anime is so underrated!",
  "This anime is so good!",
]

puts "Deleting all comments..."
Comment.delete_all
puts "Deleting all users achievements..."
UserAchievement.delete_all
puts "Deleting all achievements..."
Achievement.delete_all
puts "Deleting all reviews..."
Review.delete_all
# puts "Deleting all watchlists..."
# Watchlist.delete_all
# puts "Deleting all episodes..."
# Episode.delete_all
# puts "Deleting all animes..."
# Anime.delete_all
# puts "Deleting all users..."
# User.delete_all

# 1. get the data from the api
# 2. parse the data
# 3. create the records

# puts "Creating animes..."
# url1 = "https://api.jikan.moe/v4/top/anime?type=TV"

# # 1. get the data from the api
# anime1_serialized = URI.open(url1).read

# # 2. parse the data
# anime1 = JSON.parse(anime1_serialized)
# url2 = "https://api.jikan.moe/v4/top/anime?type=TV&page=2"

# # 1. get the data from the api
# anime2_serialized = URI.open(url2).read

# # 2. parse the data
# anime2 = JSON.parse(anime2_serialized)

# url3 = "https://api.jikan.moe/v4/top/anime?type=TV&page=3"

# # 1. get the data from the api
# anime3_serialized = URI.open(url3).read

# # 2. parse the data
# anime3 = JSON.parse(anime3_serialized)

# ids = []

# anime1["data"].each do |anime|
#   ids << anime["mal_id"]
# end

# anime2["data"].each do |anime|
#   ids << anime["mal_id"]
# end

# anime3["data"].each do |anime|
#   ids << anime["mal_id"]
# end
# puts "Created #{ids.count} ids"

# # ids.map do |id|
# #   puts "Getting data for #{id}"
# #   sleep(1)
# #   url = "https://api.jikan.moe/v4/anime/#{id}"
# #   anime_serialized = URI.open(url).read
# #   anime = JSON.parse(anime_serialized)

# # end


# ids.each do |id|
#   begin

#     producers = []
#     themes = []
#     image_urls = []
#     sleep(1)
#     url = "https://api.jikan.moe/v4/anime/#{id}"
#     anime_serialized = URI.open(url).read
#     anime = JSON.parse(anime_serialized)
#     sleep(1)
#     url_vidoes = "https://api.jikan.moe/v4/anime/#{id}/videos"
#     url_vidoes_serialized = URI.open(url_vidoes).read
#     videos_parse = JSON.parse(url_vidoes_serialized)

#     # p "Creating video: #{videos_parse["data"]["promo"][0]["trailer"]["embed_url"]}"
#     # p "Creating images: #{videos_parse["data"]["promo"][0]["trailer"]["images"]["maximum_image_url"]}"
#     # p "Creating 2nd_images: #{videos_parse["data"]["promo"][1]["trailer"]["images"]["maximum_image_url"]}"

#     puts "Creating #{anime["data"]["title_english"]}, left: #{ids.count - Anime.count}"
#     if anime["data"].present?
#       anime["data"]["producers"].map { |pr| producers << pr["name"]}
#       anime["data"]["themes"].map { |pr| themes << pr["name"]}
#       videos_parse["data"]["promo"].map { |vid| image_urls << vid["trailer"]["images"]["maximum_image_url"]}
#       Anime.create!(
#         title: anime["data"]["title_english"],
#         synopsis: anime["data"]["synopsis"],
#         date_start: anime["data"]["aired"]["from"],
#         date_finish: anime["data"]["aired"]["to"],
#         genre: anime["data"]["genres"][0]["name"],
#         rating: anime["data"]["score"] / 2,
#         episodecount: anime["data"]["episodes"],
#         api_id: anime["data"]["mal_id"],
#         image: anime["data"]["images"]["jpg"]["image_url"],
#         rank: anime["data"]["rank"],
#         embed_url: videos_parse["data"]["promo"][0]["trailer"]["embed_url"][0...-11],
#         image_urls: image_urls ,
#         status: anime["data"]["status"],
#         producers: producers,
#         themes: themes
#       )
#     end
#   rescue Exception => e
#     p "Broken #{e}"
#   end
# end

# puts "Created #{Anime.count} animes"

# puts "Creating users..."

# 10.times do
#   User.create!(
#     email: Faker::Internet.email,
#     username: Faker::Internet.username,
#     password: "123456"
#   )
# end

# puts "Created #{User.count} users"


# puts "Creating episodes..."

# Anime.all.each do |anime|

#   [anime.episodecount, 10].min.times do |n|
#   begin
#     sleep(1)
#     episode_serialized = URI.open("https://api.jikan.moe/v4/anime/#{anime.api_id}/episodes/#{n + 1}").read
#     episodes = JSON.parse(episode_serialized)
#     puts "Creating episodes for #{anime.title}"
#     if episodes["data"].present?
#       Episode.create!(
#         title: episodes["data"]["title"],
#         description: episodes["data"]["synopsis"],
#         image: anime.image,
#         date_aired: episodes["data"]["aired"],
#         rating: anime.rating,
#         episodenumber: episodes["data"]["mal_id"],
#         duration: episodes["data"]["duration"],
#         anime: anime,
#       )
#     end
#     rescue
#       puts "Broken..."
#     end
#   end
# end

# puts "Created #{Episode.count} episodes"

puts "Creating reviews..."
# Let's make some reviews
Anime.all.each do |anime|
  sleep(1)
  begin
    reviews_serialized = URI.open("https://api.jikan.moe/v4/anime/#{anime.api_id}/reviews").read
    reviews = JSON.parse(reviews_serialized)
    reviews["data"].first(5).each do |review|
      puts "Creating reviews for #{anime.title}"
      if review.present?
        Review.create!(
          content: review["review"],
          rating: review["score"].to_i / 2,
          user: User.all.sample,
          anime: anime,
        )
      end
    end
  rescue
    puts "Broken..."
  end
end

puts "Created #{Review.count} reviews"

puts "Creating achievements..."

# Let's make some achievements
Achievement.create!(
  name: "First Review",
  description: "You wrote your first review!",
  points: 10
)

Achievement.create!(
  name: "First Episode",
  description: "You watched your first episode!",
  points: 10
)

Achievement.create!(
  name: "First Anime",
  description: "You watched your first anime!",
  points: 10
)

Achievement.create!(
  name: "Anime Master",
  description: "You watched 100 episodes!",
  points: 100
)

Achievement.create!(
  name: "Anime God",
  description: "You watched 1000 episodes!",
  points: 1000
)

Achievement.create!(
  name: "Anime King",
  description: "You watched 10000 episodes!",
  points: 10000
)

Achievement.create!(
  name: "Super Reviewer",
  description: "You wrote 100 reviews!",
  points: 100
)

Achievement.create!(
  name: "Review Master",
  description: "You wrote 1000 reviews!",
  points: 1000
)

Achievement.create!(
  name: "Review God",
  description: "You wrote 10000 reviews!",
  points: 10000
)

Achievement.create!(
  name: "Anime Addict",
  description: "You watched 100 animes!",
  points: 100
)

Achievement.create!(
  name: "Anime Maniac",
  description: "You watched 1000 animes!",
  points: 1000
)

Achievement.create!(
  name: "Anime God",
  description: "You watched 10000 animes!",
  points: 10000
)

puts "Created #{Achievement.count} achievements"

# puts "Creating user watchlists..."

# User.all.each do |user|
#   Watchlist.create!(
#     user: user,
#     status: true,
#     notes: Faker::Lorem.paragraph(sentence_count: 2),
#     anime: Anime.all.sample
#   )
# end

# puts "Created #{Watchlist.count} user watchlists"

puts "Creating comments for each episode"

Episode.all.each do |episode|
  5.times do
    Comment.create!(
      content: random_comments.sample,
      user: User.all.sample,
      episode: episode
    )
  end
end

puts "Created #{Comment.count} comments"

puts "Creating user achivements..."

User.all.each do |user|
  UserAchievement.create!(
    user: user,
    achievement: Achievement.all.sample
  )
end

puts "Created #{UserAchievement.count} user achievements"
