require 'logger'
require 'slack-ruby-client'

Slack.configure do |config|
  config.token = ENV['SLACK_ACCESS_TOKEN']
end

logger = Logger.new('/tmp/log')
client = Slack::RealTime::Client.new
channel_id = ENV['SLACK_CHANNEL_ID']

client.on :hello do
  logger.info 'connected!'
end

client.on :close do
  logger.error('close!')
  client.stop!
end

client.on :closed do
  logger.error('closed!')
  client.start!
end

client.on :channel_created do |data|
  text = "A new channel <\##{data.channel.id}> was created by <@#{data.channel.creator}>."
  client.message(channel: channel_id, text: text, as_user: false)
end

client.on :emoji_changed do |data|
  if data.subtype == 'add'
    text = "A new emoji `:#{data.name}:` :#{data.name}: was added."
    client.message(channel: channel_id, text: text, as_user: false)
  end
end

client.start!
