require 'elasticsearch'
require 'typhoeus'
require 'typhoeus/adapters/faraday'
require 'multi_json'
require 'oj'
require 'bunny'
require 'pry'

# RabbitMQ
connection = Bunny.new
connection.start

channel = connection.create_channel
queue   = channel.queue('elasticsearch.test', durable: true)

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

delivery_info, metadata, payload = queue.pop

binding.pry

# Elasticsearch
client = Elasticsearch::Client.new(log: true)
client.transport.reload_connections!
health = client.cluster.health





puts 'done'
