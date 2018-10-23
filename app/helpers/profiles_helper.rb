module ProfilesHelper
  def build_profile(profile)
    profile
  end 
  def display_lang languages 
    return languages.reject { |c| c.empty? }.map { |i|  i.to_s  }.join(",")
  end 
  def display_areas areas 
    return areas.map { |i|  i["place"].to_s  }.join(" | ")
  end 
end
