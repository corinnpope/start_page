module HackerNews
  class TopStories
    def self.get_stories
      Faraday.get "https://hacker-news.firebaseio.com/v0/askstories.json?print=prett"
    end
  end
end
