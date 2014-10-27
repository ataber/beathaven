namespace :soundcloud do
  task :populate => :environment do
    c = Soundcloud.new(client_id: ENV["SOUNDCLOUD_ID"])
    accounts = c.get("/users", q: "San Francisco", facet: "place", limit: 100)
    performers = accounts.map do |p|
      track_url = (c.get("/users/#{p[:id]}/playlists").first ||
        c.get("/users/#{p[:id]}/tracks").first).try(:[], :permalink_url)
      next unless track_url
      next unless p[:followers_count] > 1000
      name = p[:full_name] || p[:username]
      Performer.new(
        name: name.first(30),
        location: p[:city],
        soundcloud_url: track_url,
      )
    end.compact

    performers.map(&:save)
  end
end