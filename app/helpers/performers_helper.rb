module PerformersHelper
  def options_for_genre(genre=nil)
    genres = ["Rock", "Jazz", "Electronic", "Hip Hop", "Experimental"]
    options_for_select(genres, genre)
  end
end
