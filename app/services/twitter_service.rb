class TwitterService
  def initialize(data)
    @data = data
    @client ||= Twitter::REST::Client.new(@data)
  end

  def update_with_images(message, images, user)
    image_ids = []

    images.each do |image|
      file = File.new("#{Dir.pwd}/public#{image}")

      image_ids << @client.upload(file)
    end

    post = @client.update(message, media_ids: image_ids.join(','))

    user.social_posts.create(post_id: post.id, service_name: self.class)
  end

  def favorite_count(tweet_id)
    @client.status(tweet_id).favorite_count
  end

  def retweet_count(tweet_id)
    @client.status(tweet_id).retweet_count
  end
end
