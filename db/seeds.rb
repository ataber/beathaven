user = User.create(:email => "andrew.e.taber@gmail.com", :password => "nutpalace", :password_confirmation => "nutpalace")
user2 = User.create(:email => "jesus.shuttlesworth@gmail.com", :password => "rayallenfor3", :password_confirmation => "rayallenfor3")
User.create(:email => "king.james@gmail.com", :password => "fuckyoukobe", :password_confirmation => "fuckyoukobe")
Performer.create(:name => "Pink Floyd", :genre => "Rock", :user_id => user.id, :price => 50)
chance = Performer.create(:name => "Chance the Rapper", :genre => "Rock", :user_id => user.id, :soundcloud_url => "https://soundcloud.com/chancetherapper/sets/chance-the-rapper-acid-rap", :description => "A raunchy time from a pothead with too much of it", :price => 200)
file = File.open(Rails.root.join("app/assets/images/chance.jpg"))
chance.avatar = file
file.close()
chance.save!
Performer.create(:name => "Skrillex", :genre => "Electric", :user_id => user2.id, :price => 20)
