require 'htmlentities'
coder = HTMLEntities.new

title = "CocoaHeads Brasil"
author = "CocoaHeads Brasil"
description = "CocoaTalks dos encontros mensais do movimento CocoaHeads no Brasil."
keywords = "ios, osx, development, desenvolvimento, programacao, objective-c, mac, appstore, macappstore"

image = asset_url("capaPodcastCocoaHeadsBR.png")

xml.rss "xmlns:itunes" => "http://www.itunes.com/dtds/podcast-1.0.dtd",  "xmlns:media" => "http://search.yahoo.com/mrss/", "xmlns:atom" => "http://www.w3.org/2005/Atom",  :version => "2.0" do
  xml.channel do
    xml.atom :link, :href => root_url + 'podcasts/itunes.rss', :rel => 'self', :type => 'application/rss+xml'
    xml.title title
    xml.link 'http://cocoaheads.com.br'
    xml.description description
    xml.language 'pt'
    xml.pubDate @videos.first.agenda.data.to_s(:rfc822)
    xml.lastBuildDate @videos.first.agenda.data.to_s(:rfc822)
    xml.itunes :author, author
    xml.itunes :keywords, keywords
    xml.itunes :explicit, 'clean'
    xml.itunes :image, :href => image
    xml.itunes :owner do
      xml.itunes :name, author
      xml.itunes :email, 'contato@cocoaheads.com.br'
    end
    xml.itunes :block, 'no'
    xml.itunes :category, :text => 'Technology' do
      xml.itunes :category, :text => 'Software How-To'
    end
    xml.itunes :category, :text => 'Education' do
      xml.itunes :category, :text => 'Training'
    end

    @videos.each do |episode|
      next if !episode.podcast?
      xml.item do
      	descricao = coder.decode(ActionView::Base.full_sanitizer.sanitize(episode.descricao))
        xml.title episode.titulo
        xml.description descricao
        xml.pubDate episode.created_at.to_s(:rfc822)
        xml.enclosure :url => root_url + 'podcasts/redirect/' + episode.id.to_s + '.mp3', :length => episode.duracao_podcast_sem_pontuacao, :type => 'audio/m4a'
        xml.link agendas_url(episode)
        xml.guid({:isPermaLink => "false"}, "cocoatalk_" + episode.id.to_s)
        xml.itunes :author, episode.palestrante.nome
        xml.itunes :subtitle, truncate(descricao, :length => 150)
        xml.itunes :summary, descricao
        xml.itunes :explicit, 'no'
        xml.itunes :duration, episode.podcast_duration
      end
    end
  end
end