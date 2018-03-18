require 'slack-ruby-client'
# require './daemonize.rb'

Slack.configure do |config|
  config.token = ENV['SLACK_API_TOKEN']
end

client = Slack::Web::Client.new
# client.auth_test
client.chat_postMessage(channel: '#bot_test', text: 'Test', as_user: true)

# client.on :hello do
#   puts "connected!"
# end
#
# # 再コネクション
# client.on :close do
#   logger.error("close!")
#   clinet.stop!
# end
#
# client.on :closed do
#   logger.error("closed!")
#   client.start!
# end
#
# client.on :channel_created do |data|
#   text = "A new channel <\##{data.channel.id}> was created by #{data.creator}."
#   channel_id = 'C9SKF3M6K'  # #bot-test channel
#   client.message channel: channel_id, text: text
# end
#
# channel_id = 'C9SKF3M6K'  # #bot-test channel
# text = 'hello'
# client.message channel: channel_id, text: text
#
# client.start!
