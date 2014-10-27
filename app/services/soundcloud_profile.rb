class SoundcloudProfile
  attr_reader :permalink

  def initialize(url)
    @permalink = url.split("soundcloud.com/").last.split("/").first
  end

  def avatar_url
    get_remote[:avatar_url].split("-")[0..-2].append("t500x500.jpg").join("-")
  end

  def followers_count
    get_remote[:followers_count]
  end

  def get_remote
    @remote ||= api.get("/users/#{@permalink}")
  end

  private

  def api
    @api ||= Soundcloud.new(client_id: ENV["SOUNDCLOUD_ID"])
  end
end