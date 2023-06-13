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

Episode.destroy_all
Anime.destroy_all

# 1. get the data from the api
# 2. parse the data
# 3. create the records

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

Anime.all.each do |anime|
    p anime.api_id
    [anime.episodecount, 10].min.times do |n|
    begin
      p n+1
      episode_serialized = URI.open("https://api.jikan.moe/v4/anime/#{anime.api_id}/episodes/#{n + 1}").read
      sleep(3)
      # # 2. parse the data
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
