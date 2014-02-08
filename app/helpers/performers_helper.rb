module PerformersHelper
  def options_for_genre
    genres = ["Rock", "Jazz", "Electronic", "Hip Hop"]
    options_for_select(genres)
  end
end
