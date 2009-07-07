# Code for connecting to the Juggernaut server.
# Most code is taken from the Juggernaut Rails plugin.

require "yaml"
require "socket"
require "erb"

CONFIG = YAML::load(ERB.new(IO.read("#{File.dirname(__FILE__)}/../config/juggernaut_hosts.yml")).result).freeze
CR = "\0"

def hosts
  CONFIG[:hosts].select {|h|
    !h[:environment] or h[:environment].to_s == ENV['RM_RAILS_ENVIRONMENT']
  }
end

def send_data(hash, response = false)
  hash[:channels] = hash[:channels].to_a if hash[:channels]
  hash[:client_ids] = hash[:client_ids].to_a if hash[:client_ids]

  res = []
  hosts.each do |address|
    begin
      hash[:secret_key] = address[:secret_key] if address[:secret_key]

      @socket = TCPSocket.new(address[:host], address[:port])
      # Do what Flash does
      @socket.print(hash.to_json + CR)
      @socket.flush
      res << @socket.readline(CR) if response
    ensure
      @socket.close if @socket and !@socket.closed?
    end
  end
  res.collect {|r| ActiveSupport::JSON.decode(r.chomp!(CR)) } if response
end
