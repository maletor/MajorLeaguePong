# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

Team.create({"assholes"=>0, "hit_count"=>0, "hit_percentage"=>0, "id"=>1, "losses"=>0, "name"=>"Keystolopes", "opp"=>0, "points"=>0, "profile"=>"", "shot_count"=>nil, "suicides"=>0, "wins"=>0})

Invitation.create({"id"=>1, "name"=>nil, "recipient_email"=>"eberner@gmail.com", "sender_id"=>nil, "sent_at"=>nil, "team_id"=>nil, "token"=>"6456da3f5db46149ae5be8227d154a157db32f7e"})

User.create({"email"=>"eberner@gmail.com", "id"=>1, "invitation_id"=>1, "password_hash"=>"$2a$10$a5R4IR2jqbGkCUGBlXyqheknNcinar4IMcCf1tSzj7/RDt7zHOIFe", "password_salt"=>"$2a$10$a5R4IR2jqbGkCUGBlXyqhe", "username"=>"Maletor"})

Player.create({"assholes"=>0, "avatar_content_type"=>"image/jpeg", "avatar_file_name"=>"n102600189_30221010_4480.jpg.jpeg", "avatar_file_size"=>29143, "hit_count"=>1, "hit_percentage"=>0, "id"=>1, "last_cups"=>0, "name"=>"Ellis Berner", "opp"=>0, "point_count"=>nil, "points"=>1, "profile"=>"", "shot_count"=>nil, "shots_count"=>6, "suicides"=>0, "team_id"=>1, "user_id"=>1})
