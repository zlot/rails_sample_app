module ApplicationHelper
  
  # Returns the full title on a per-base basis.
  def full_title(page_title)
    base_title = "Ruby on Rails Tutorial Sample App"
    if page_title.empty?
      base_title  # eg "Ruby on Rails Tutorial Sample App"
    else
      "#{base_title} | #{page_title}" # eg "Ruby on Rails Tutorial Sample App | Home"
    end
  end
 
end