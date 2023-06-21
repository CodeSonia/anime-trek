class AddBannerToUsers < ActiveRecord::Migration[7.0]
  def change
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
    add_column :users, :banner, :string, default: random_banners.sample
  end
end
