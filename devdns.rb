#!/usr/bin/env ruby
#require 'byebug'
require 'rubydns'

INTERFACES = [
	[:udp, '0.0.0.0', 5300],
	[:tcp, '0.0.0.0', 5300]
]

IN = Resolv::DNS::Resource::IN

# Use upstream DNS for name resolution.
UPSTREAM = RubyDNS::Resolver.new([[:udp, '8.8.8.8', 53], [:tcp, '8.8.8.8', 53]])

DEFAULT_HOST = ENV['DEFAULT_HOST'] || '127.0.0.1'

# Start the RubyDNS server
RubyDNS.run_server(INTERFACES) do
  self.logger = Logger.new($stdout)

	match(%r{\.(dev|lh)$}, IN::A) do |transaction|
    logger.info "==handling domain: #{transaction.name} ..."
    transaction.respond!(DEFAULT_HOST)
	end

	# Default DNS handler
	otherwise do |transaction|
    transaction.passthrough!(UPSTREAM)
  end
end
