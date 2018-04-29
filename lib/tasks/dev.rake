namespace :dev do

 task fake_user: :environment do
    User.destroy_all
    20.times do |i|
      name = FFaker::Name::first_name
      file = File.open("#{Rails.root}/public/avatar/user#{i+1}.jpg")

      user = User.new(
        name: name,
        email: "#{i}@gmail.com",
        password: "123456",
        introduction: FFaker::Lorem::sentence(360),
        avatar: file
      )

      user.save!
      puts user.name
    end
  end

  task fake_clean_dojo: :environment do
    Dojo.destroy_all
    puts "Clean all dojos"
  end

  task fake_dojo_less: :environment do
      User.all.sample(8).each do |user|
        dojo = user.dojos.build(title: FFaker::Lorem.word ,description: FFaker::Lorem.paragraph[0,500])
        dojo.save!
      end
      puts "create 8 fake dojo"
  end

  task fake_dojo_more: :environment do
      User.all.sample(15).each do |user|
        dojo = user.dojos.build(title: FFaker::Lorem.word ,description: FFaker::Lorem.paragraph[0,500])
        dojo.save!
      end
      puts "create 15 fake dojo"
  end

   task fake_clean_comment: :environment do
    Comment.destroy_all
    puts "Clean all comments"
  end

  task fake_comments: :environment do
    User.all.each do |user|
      Dojo.all.sample(8).each do |dojo|
        dojo.comments.create(user: user, content: FFaker::Lorem.paragraph[0,400])
      end
    end
    puts "create some fake comments"
  end

 task fake_clean_collect: :environment do
    Like.destroy_all
    puts "Clean all collects"
  end

  task fake_collect: :environment do
    i = 0
    User.all.each do |user|
      i = i +1
      num = i % 5
      num = 6-num
      Dojo.all.sample(num).each do |dojo|
        unless dojo.is_collected?(user)
            dojo.collects.create(user: user)
        end
      end
    end
    puts "create some fake collects"
  end

  task fake_clean_friendship: :environment do
    Friendship.destroy_all
    puts "Clean all friendships"
  end

  task fake_friendship: :environment do
    i = 0
    User.all.each do |user1|
      i = i +1
      num = i % 5
      num = 6-num
      j = -1
      User.all.sample(num).each do |user2|
        j = j + 1
        unless user1 == user2
          user1.create_friendships(user2)
          puts "#{user1.name} add #{user2.name} friend"
        end
      end
    end
  end

  task show_friendship: :environment do
    User.all.each do |user1|
      puts ""
      puts " ======================= "
      @friendships = user1.friendships
      @friendships.each do |friendships|
        puts "#{user1.id} has friendships #{friendships.friend_id}"
      end
      @inverse_friendships = user1.inverse_friendships
      @inverse_friendships.each do |friendships|
        puts "#{user1.id} has inverse_friendships #{friendships.user_id}"
      end
    end
  end

end