require 'feedzirra'
require 'twitter'
require 'uri'

class IndexController < ApplicationController

  before_filter :get_tweets, :only => [:contacts, :publications, :fotki, :resume, :send_message]

  def fotki
    feed = Feedzirra::Feed.fetch_and_parse("http://api-fotki.yandex.ru/api/users/ligrimp/photos/published/?limit=35")
    @images = Array.new
    for image in feed.entries
      image_url = image.links[3]

      i = ImageBundle.new
      i.xxl_url= image_url.clone

      image_url["XL"] = "XXS"
      i.url= image_url

      i.album_link = image.links[2]
      i.title = image.title
      @images << i
    end
  end

  def publications
    feed = Feedzirra::Feed.fetch_and_parse("http://www.blogger.com/feeds/65761635570882100/posts/full")
    @blogs = Array.new
    is_first = true
    for blog in feed.entries
      blog_bundle = BlogBundle.new
      blog_bundle.title = blog.title
      blog_bundle.published = blog.published.strftime("%d-%m-%Y %H:%M")
      blog_bundle.url = blog.url
      if is_first
        blog_bundle.content = blog.content
        is_first = false
      end      
      @blogs << blog_bundle
    end
  end

  def resume
  end

  @has_errors = false
  @has_sent = false

  def contacts
  end

  def send_message
    message = params["message"]
    if message['subject'].eql? 'Message subject'
         message['subject'] = '';
    end
    if message['content'].eql? ''
      @has_errors = true
      render 'index/contacts'
      return nil
    end
    Contact.deliver_contact(message['subject'], message['from_mail'], message['from_name'], message['content'])
    @has_sent = true
    render 'index/contacts'
  end

  private

    def get_tweets
      client = Twitter::Client.new(:login => 'ligrimp', :password => 'binaneura')
      @statuses = Array.new
      client.timeline_for(:me) do |status|
        t = TwitterBundle.new
        t.status = status.text
        t.date = status.created_at.strftime("%d-%m-%Y %H:%M")
        if  !URI.extract(t.status)[0].nil?
          t.link = URI.extract(t.status)[0]
        end
        @statuses << t
      end
      @statuses
    end

end

class ImageBundle
  attr_accessor :url, :album_link, :title, :xxl_url
end

class TwitterBundle
  attr_accessor :status, :date, :link
end

class BlogBundle
  attr_accessor :title, :content, :published, :url
end