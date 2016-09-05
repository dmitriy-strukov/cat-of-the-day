class FacebookService
  def initialize(data)
    @data = data['token']
    @client ||= Koala::Facebook::API.new(@data)
  end

  def update_with_image(social_params, user)
    file = File.new("#{Dir.pwd}/public#{social_params[:image]}")
    post = @client.put_picture(file, { message: social_params[:message] })

    user.social_posts.create(post_id: post['id'], day_subject_id: social_params[:day_subject_id], service_name: self.class)
  end
end