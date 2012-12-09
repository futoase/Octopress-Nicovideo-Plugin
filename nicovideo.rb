# -*- coding:utf-8 -*-

require 'open-uri'
require 'rexml/document'

TEMPLATE = '<script type="text/javascript" src="http://ext.nicovideo.jp/thumb_watch/%s"></script><noscript><a href="http://www.nicovideo.jp/watch/%s">%s</a></noscript>'
API_BASE = 'http://ext.nicovideo.jp/api/getthumbinfo/'

module Jekyll
  class Nicovideo < Liquid::Tag
    def initialize(name, id, tokens)
      super 
      @id = id
    end

    def render(context)
      @title = REXML::XPath.first(
        REXML::Document.new(open(API_BASE + @id).read), '//title'
      ).text
      %(<div style="margin-left: auto; margin-right: auto; width: 500px;"><script type="text/javascript" src="http://ext.nicovideo.jp/thumb_watch/#{@id}"></script><noscript><a href="http://www.nicovideo.jp/watch/#{@id}">#{@title}</a></noscript></div>)
    end
  end
end

Liquid::Template.register_tag('nicovideo', Jekyll::Nicovideo)
