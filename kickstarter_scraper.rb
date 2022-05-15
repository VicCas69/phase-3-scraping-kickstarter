# require libraries/modules here
require 'nokogiri'
require 'pry'

# projects: kickstarter.css("li.project.grid_4") => projects
# project.css("h2.bbcard_name strong a").text  => titles
# project.css("div.project-thumbnail a img").attribute("src").value  => image
# project.css("ul.project-meta span.location-name").text  => location
# project.css("ul.project-stats li.first.funded strong").text => funded

def create_project_hash
  # write your code here
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)
  #binding.pry

  projects = {}

  #iterate through the projects
  kickstarter.css("li.project.grid_4").each do |project|
    title = project.css("h2.bbcard_name strong a").text
    projects[title] = {
      :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
      :description => project.css("p.bbcard_blurb").text,
      :location => project.css("ul.project-meta span.location-name").text,
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
    }
  end
  # Return the projects hash
  projects
end

create_project_hash
