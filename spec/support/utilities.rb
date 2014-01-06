def full_title(page_title)
  base_title = "Ruby on Rails Tutorial Sample App"
  if page_title.empty?
    base_title
  else
    "#{base_title} | #{page_title}"   # e.g. "Ruby on Rails Tutorial Sample App | Contact"
  end
end

# This is essentially a duplicate of the helper function in the app directory, 
# but having two independent methods allows us to catch any typos in the base title.