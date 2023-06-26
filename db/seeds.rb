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

random_banners = [
  "https://images8.alphacoders.com/131/1318148.png",
  "https://images.alphacoders.com/131/1318416.png",
  "https://images.alphacoders.com/131/1318412.png",
  "https://images8.alphacoders.com/131/1318523.png",
  "https://images.alphacoders.com/131/1318300.png",
  "https://images.alphacoders.com/131/1317738.png",
  "https://images8.alphacoders.com/129/1298087.jpg",
  "https://images4.alphacoders.com/710/710501.png",
  "https://images8.alphacoders.com/131/1318410.png",
  "https://images4.alphacoders.com/129/1293106.png",
  "https://images.alphacoders.com/129/1291412.jpg",
  "https://images3.alphacoders.com/109/109509.jpg",
  "https://images3.alphacoders.com/116/1163420.jpg",
]

puts "Deleting all comments..."
Comment.delete_all
puts "Deleting all users achievements..."
UserAchievement.delete_all
puts "Deleting all achievements..."
Achievement.delete_all
puts "Deleting all reviews..."
Review.delete_all
puts "Deleting all watchlists..."
Watchlist.delete_all
puts "Deleting all episodes..."
Episode.delete_all
puts "Deleting all animes..."
Anime.delete_all
puts "Deleting all users..."
User.delete_all

# # 1. get the data from the api
# # 2. parse the data
# # 3. create the records

puts "Creating animes..."
url1 = "https://api.jikan.moe/v4/top/anime?type=TV"

# 1. get the data from the api
anime1_serialized = URI.open(url1).read

# 2. parse the data
anime1 = JSON.parse(anime1_serialized)
sleep(1)

url2 = "https://api.jikan.moe/v4/top/anime?type=TV&page=2"

# 1. get the data from the api
anime2_serialized = URI.open(url2).read

# 2. parse the data
anime2 = JSON.parse(anime2_serialized)
sleep(1)
# url3 = "https://api.jikan.moe/v4/top/anime?type=TV&page=3"

# # 1. get the data from the api
# anime3_serialized = URI.open(url3).read

# # 2. parse the data
# anime3 = JSON.parse(anime3_serialized)
# sleep(1)
# url4 = "https://api.jikan.moe/v4/top/anime?type=TV&page=4"

# # 1. get the data from the api
# anime4_serialized = URI.open(url4).read

# # 2. parse the data
# anime4 = JSON.parse(anime4_serialized)
# sleep(1)
# url5 = "https://api.jikan.moe/v4/top/anime?type=TV&page=5"

# # 1. get the data from the api
# anime5_serialized = URI.open(url5).read

# # 2. parse the data
# anime5 = JSON.parse(anime5_serialized)
# sleep(1)
# url6 = "https://api.jikan.moe/v4/top/anime?type=TV&page=6"

# # 1. get the data from the api
# anime6_serialized = URI.open(url6).read

# # 2. parse the data
# anime6 = JSON.parse(anime6_serialized)

ids = []

anime1["data"].each do |anime|
  ids << anime["mal_id"]
end

anime2["data"].each do |anime|
  ids << anime["mal_id"]
end

# anime3["data"].each do |anime|
#   ids << anime["mal_id"]
# end
# anime4["data"].each do |anime|
#   ids << anime["mal_id"]
# end
# anime5["data"].each do |anime|
#   ids << anime["mal_id"]
# end
# anime6["data"].each do |anime|
#   ids << anime["mal_id"]
# end
# puts "Created #{ids.count} ids"

# ids.map do |id|
#   puts "Getting data for #{id}"
#   sleep(1)
#   url = "https://api.jikan.moe/v4/anime/#{id}"
#   anime_serialized = URI.open(url).read
#   anime = JSON.parse(anime_serialized)

# end


ids.each do |id|
  begin

    producers = []
    themes = []
    image_urls = []
    sleep(1)
    url = "https://api.jikan.moe/v4/anime/#{id}"
    anime_serialized = URI.open(url).read
    anime = JSON.parse(anime_serialized)
    sleep(1)
    url_vidoes = "https://api.jikan.moe/v4/anime/#{id}/videos"
    url_vidoes_serialized = URI.open(url_vidoes).read
    videos_parse = JSON.parse(url_vidoes_serialized)

    # p "Creating video: #{videos_parse["data"]["promo"][0]["trailer"]["embed_url"]}"
    # p "Creating images: #{videos_parse["data"]["promo"][0]["trailer"]["images"]["maximum_image_url"]}"
    # p "Creating 2nd_images: #{videos_parse["data"]["promo"][1]["trailer"]["images"]["maximum_image_url"]}"

    puts "Creating #{anime["data"]["title_english"]}, left: #{ids.count - Anime.count}"
    if anime["data"].present?
      anime["data"]["producers"].map { |pr| producers << pr["name"]}
      anime["data"]["themes"].map { |pr| themes << pr["name"]}
      videos_parse["data"]["promo"].map { |vid| image_urls << vid["trailer"]["images"]["maximum_image_url"]}
      Anime.create!(
        title: anime["data"]["title_english"],
        synopsis: anime["data"]["synopsis"],
        date_start: anime["data"]["aired"]["from"],
        date_finish: anime["data"]["aired"]["to"],
        genre: anime["data"]["genres"][0]["name"],
        rating: anime["data"]["score"] / 2,
        episodecount: anime["data"]["episodes"],
        api_id: anime["data"]["mal_id"],
        image: anime["data"]["images"]["jpg"]["image_url"],
        rank: anime["data"]["rank"],
        embed_url: videos_parse["data"]["promo"][0]["trailer"]["embed_url"][0...-11],
        image_urls: image_urls ,
        status: anime["data"]["status"],
        producers: producers,
        themes: themes
      )
    end
  rescue Exception => e
    p "Broken #{e}"
  end
end

puts "Created #{Anime.count} animes"

puts "Creating users..."

30.times do
  User.create!(
    email: Faker::Internet.email,
    username: Faker::Internet.username,
    password: "123456",
    bio: Faker::Quote.famous_last_words,
    photo: Faker::Avatar.image,
    banner: random_banners.sample,
    points: rand(1000..10000)
  )
end

puts "Created #{User.count} users"


puts "Creating episodes..."

Anime.all.each do |anime|

  [anime.episodecount, 10].min.times do |n|
  begin
    sleep(1)
    episode_serialized = URI.open("https://api.jikan.moe/v4/anime/#{anime.api_id}/episodes/#{n + 1}").read
    episodes = JSON.parse(episode_serialized)
    puts "Creating episodes for #{anime.title}"
    if episodes["data"].present?
      Episode.create!(
        title: episodes["data"]["title"],
        description: episodes["data"]["synopsis"],
        image: anime.image,
        date_aired: episodes["data"]["aired"],
        rating: anime.rating,
        episodenumber: episodes["data"]["mal_id"],
        duration: episodes["data"]["duration"],
        anime: anime,
      )
    end
    rescue
      puts "Broken..."
    end
  end
end

puts "Created #{Episode.count} episodes"

puts "Creating reviews..."
# Let's make some reviews
Anime.all.each do |anime|
  sleep(1)
  begin
    reviews_serialized = URI.open("https://api.jikan.moe/v4/anime/#{anime.api_id}/reviews").read
    reviews = JSON.parse(reviews_serialized)
    reviews["data"].first(10).each do |review|
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
  name: "The Review Rookie",
  description: "Unleashed your inner critic! You wrote your first review and shared your thoughts with the world.",
  image: "https://res.cloudinary.com/dtjuz4kkr/image/upload/v1687269885/review_rookie_wr0u0n.png ",
  points: 10
)

Achievement.create!(
  name: "Anime Adventurer",
  description: "Your anime collection starts here! You added your first anime to your watchlist.",
  image: "https://res.cloudinary.com/dtjuz4kkr/image/upload/v1687272685/anime_adventurer_ar9gvk.png",
  points: 10
)

Achievement.create!(
  name: "The Commentator",
  description: "Voiced your thoughts! You wrote your first comment and joined the discussion.",
  image: "https://res.cloudinary.com/dtjuz4kkr/image/upload/v1687287085/commentator_ryfm4a.png",
  points: 10
)

Achievement.create!(
  name: "The Review Guru",
  description: "Reviewing Prodigy! You've written 5 reviews and become a master of sharing your anime experiences.",
  image: "https://res.cloudinary.com/dtjuz4kkr/image/upload/v1687269878/review_guru_viayuc.png",
  points: 20
)

Achievement.create!(
  name: "Anime Collector",
  description: "Anime Collector Extraordinaire! You've added 5 animes to your watchlist, building an epic collection.",
  image: "https://res.cloudinary.com/dtjuz4kkr/image/upload/v1687272677/anime_collector_ml1z3z.png",
  points: 20
)

Achievement.create!(
  name: "The Chatterbox",
  description: "Opinionator Supreme! You've written 5 comments, spreading your wisdom and sparking conversations.",
  image: "https://res.cloudinary.com/dtjuz4kkr/image/upload/v1687287093/chatterbox_tx9mfs.png",
  points: 20
)

Achievement.create!(
  name: "The Anime Connoisseur",
  description: "Anime Enthusiast Overlord! You've added a whopping 10 animes to your watchlist. Your power level is off the charts!",
  image: "https://res.cloudinary.com/dtjuz4kkr/image/upload/v1687272873/connoisseur_1_cly9uw.png",
  points: 50
)

Achievement.create!(
  name: "The Review Maestro",
  description: "Review Maestro! You've written 10 reviews, captivating readers with your unparalleled anime analysis.",
  image: "https://res.cloudinary.com/dtjuz4kkr/image/upload/v1687269882/review_maestro_knxkxq.png",
  points: 50
)

Achievement.create!(
  name: "The Socializer",
  description: "Commenting Dynamo! You've written 10 comments, creating a tidal wave of discussion and camaraderie.",
  image: "https://res.cloudinary.com/dtjuz4kkr/image/upload/v1687287096/socialiser_i06tu9.png",
  points: 50
)

puts "Created #{Achievement.count} achievements"

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

puts "Creating comments for each episode"

Episode.all.each do |episode|
  10.times do
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
  3.times do
    UserAchievement.create!(
      user: user,
      achievement: Achievement.all.sample
    )
  end
end

puts "Created #{UserAchievement.count} user achievements"
