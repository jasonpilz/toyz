require 'elasticsearch'
require 'typhoeus'
require 'typhoeus/adapters/faraday'
require 'multi_json'
require 'oj'
require 'bunny'
# require 'sneakers'
require 'pry'

# class Consumer
#   include Sneakers::Worker
#   from_queue 'mmCS.upload.song_title'

#   def work(msg)

#     binding.pry

#     ack!
#   end
# end

# RabbitMQ
connection = Bunny.new
connection.start

channel  = connection.create_channel
queue    = channel.queue('elasticsearch.test', durable: true)

queue.subscribe do |delivery_info, metadata, payload|
  hash = MultiJson.load(payload)

  binding.pry
end

queue.publish(
  MultiJson.dump(
    {
      id: '5a93a47ad7e4f91d27b225a27e6cc436',
      fields: {
      song_code:    '100407',
      song_title:   'WEIRO MANHEIM ',
      song_writers: 'KJEVIL  MAINHEIM'
      }
    }
  )
)

sleep 2

# delivery_info, metadata, payload = queue.pop

binding.pry

# Elasticsearch
client = Elasticsearch::Client.new(log: true)
client.transport.reload_connections!
health = client.cluster.health





puts 'done'
