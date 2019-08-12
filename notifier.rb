require 'slack-ruby-client'

Slack.configure do |config|
  config.token = ENV['SLACK_ACCESS_TOKEN']
end

client = Slack::RealTime::Client.new

client.on :hello do
  puts 'connected!'
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
  channel_id = ENV['SLACK_CHANNEL_ID']
  client.message(channel: channel_id, text: text, as_user: false)
end

client.on :emoji_changed do |data|
  if data.subtype == 'add'
    text = "A new emoji `:#{data.name}:` :#{data.name}: was added."
    channel_id = 'CLXRR504S'
    client.message(channel: channel_id, text: text, as_user: false)
  end
end

client.start!
