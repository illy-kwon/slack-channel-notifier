require 'slack-ruby-client'
require './daemonize.rb'

Slack.configure do |config|
  config.token = ENV['SLACK_API_TOKEN']
end

client = Slack::RealTime::Client.new

client.on :hello do
  puts "connected!"
end

client.on :close do
  logger.error("close!")
  clinet.stop!
end

client.on :closed do
  logger.error("closed!")
  client.start!
end

client.on :channel_created do |data|
  text = "A new channel <\##{data.channel.id}> was created by <@#{data.channel.creator}>."
  channel_id = 'C9SKF3M6K'  # #bot-test channel
  puts text
  client.message(channel: channel_id, text: text, as_user: true)
end

client.on :emoji_changed do |data|
  text = "A new emoji :#{data.name}: was added."
  channel_id = 'C9SKF3M6K'  # #bot-test channel
  puts text
  client.message(channel: channel_id, text: text, as_user: true)
end

client.start!
