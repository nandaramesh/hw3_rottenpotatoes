# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    m=Movie.new(movie)
    m.save
  end
end


# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  fullpage=page.body
  if not fullpage.gsub("\n","").match(/<td>#{e1}.*<td>#{e2}/) then
    flunk "#{e1} is not found before #{e2}"
  end
end
# Assert no movies were listed
Then /I should see no movies/ do 
end
# Assert all movies in the database were listed
Then /I should see all the movies/ do 
  count_all_movies=Movie.count
  number_movies=10
  if (count_all_movies != number_movies) then
    flunk "Expected number of movies:#{number_movies} not equal to actual #{count_all_movies}" 
  end
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  all_ratings=rating_list.split(',')
  all_ratings.each do |rating|
    rating='ratings['+rating+']'
    uncheck ? uncheck(rating) : check(rating) 
  end
end
