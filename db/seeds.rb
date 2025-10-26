# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb
Family.find_or_create_by!(name: '自分の家庭') do |f|
  f.is_default = true
end
Family.find_or_create_by!(name: '娘の家庭') 
# ... 他の家庭もあれば追加