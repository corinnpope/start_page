class StaticController < ApplicationController
  def index
    @hn_stories = hn_stories
    @weather = get_weather
    @weather_icon = @weather["weather"].first["icon"]
    @icon_url = "http://openweathermap.org/img/w/#{@weather_icon}.png"
    @horoscope = get_horoscope
  end

  def hn_stories
    stories = []
    @hn_stories = Faraday.get("https://hacker-news.firebaseio.com/v0/topstories.json")
    obj = JSON.parse(@hn_stories.env.response_body)
    obj.take(7).each do |req|
      result = Faraday.get("https://hacker-news.firebaseio.com/v0/item/#{req}.json")
      req_obj = JSON.parse(result.env.response_body)
      stories << {title: req_obj["title"], url: req_obj["url"]}
    end
    stories
  end

  def get_weather
    api_key = Rails.application.credentials.dig(:openweathermap, :api_key)
    weather = Faraday.get("https://api.openweathermap.org/data/2.5/weather?q=78163&units=imperial&appid=" + api_key)
    JSON.parse(weather.env.response_body)
  end

  def get_horoscope
    horoscope = Faraday.post("https://aztro.sameerkumar.website/?sign=leo&day=today")
    JSON.parse(horoscope.env.response_body)
  end
end
