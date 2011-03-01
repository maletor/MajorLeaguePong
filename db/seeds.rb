# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

User.create(email: "eberner@gmail.com", 
            password_hash: "$2a$10$UmsgaSLsHzgNpkbxhjMKj.pWZk7MgW9arirKoRY/9y4d7nObNW99K",
            password_salt: "$2a$10$UmsgaSLsHzgNpkbxhjMKj.", 
            username: "Maletor",
            player_attributes: { name: "Ellis Berner" })
