# Code for connecting to the Juggernaut server.

require "yaml"
require "socket"
require "erb"
require "activesupport"

module JuggernautConnect
  # Code for configuration handling is taken from the Juggernaut Rails plugin
  CONFIG = YAML::load(ERB.new(IO.read("#{File.dirname(__FILE__)}/../config/juggernaut_hosts.yml")).result).freeze
  CR = "\0"

  def self.connect
    @sockets.nil? || @sockets.empty? or raise "Already connected to Juggernaut"

    h = self.hosts

    @sockets = []
    @sockbuf = h.map { "" }
    h.each do |address|
      @sockets << TCPSocket.new(address[:host], address[:port])
    end 

    @sockets.each {|s| !s.nil?} or raise "Error opening sockets!"
  end

  def self.poll
    res = []
    @sockets.map do |s|
        begin
	  msg, s_sa = s.recv_nonblock(10240)
	rescue Errno::EAGAIN, Errno::EWOULDBLOCK, Errno::EINTR,
	       Errno::ENOMEM, Errno::ENOBUFS, Errno::ENOSR, Errno::ETIMEDOUT,
               Errno::EINPROGRESS
          # The preceding are all recoverable "try again" errors
          msg = nil
        rescue => err
          raise "Unfixable error [#{err}] reading from Juggernaut!"
	end

        unless msg.nil?
          @sockbuf += msg

          empty_buffer = false # Whether we'll use up the whole buffer
	  empty_buffer = true if @sockbuf.chomp!(CR)

          chunks = @sockbuf.split(CR)
          @sockbuf = ""
	  @sockbuf = chunks.pop unless empty_buffer
          res += chunks
	  print "JugCon: got #{chunks.size} chunks...\n"
	  print "JugCon: chunks: #{' *** '.join(chunks)} (End chunks)\n"
        end

	print "JugCon: No message, but not blocking\n" if msg.nil?
    end
    res
  end

  # Code for outgoing data is taken from the Juggernaut Rails plugin.
  def self.hosts
    CONFIG[:hosts].select {|h|
      !h[:environment] or h[:environment].to_s == ENV['RM_RAILS_ENVIRONMENT']
    }
  end

  def self.send_data(hash)
    hash[:channels] = hash[:channels].to_a if hash[:channels]
    hash[:client_ids] = hash[:client_ids].to_a if hash[:client_ids]

    self.hosts.each do |address|
      begin
        hash[:secret_key] = address[:secret_key] if address[:secret_key]

        @socket = TCPSocket.new(address[:host], address[:port])
        # Do what Flash does
        @socket.print(hash.to_json + CR)
        @socket.flush
      ensure
        @socket.close if @socket and !@socket.closed?
      end
    end
  end

  def self.send_to_all(data)
    fc = {
      :command   => :broadcast,
      :body      => data, 
      :type      => :to_channels,
      :channels  => []
    }
    self.send_data(fc)
  end

  def self.send_to_clients(data, client_ids)
    fc = {
      :command    => :broadcast,
      :body       => data, 
      :type       => :to_clients,
      :client_ids => client_ids
    }
    self.send_data(fc)
  end

end
