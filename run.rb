require 'rubygems'
require 'bundler/setup'
require 'typhoeus'
require 'json'
require 'progress'

require_relative 'lib/naming'
require_relative 'lib/saving'

FILENAME = 'domains.html'

domains = Naming.generate_domains
hydra = Typhoeus::Hydra.new
data = []

Progress.start("Generating data for #{domains.count} domains", domains.count) do
  domains.each do |domain|
    request = Typhoeus::Request.new("http://domai.nr/api/json/info?&q=#{domain}")
    request.on_complete do |response|
      data << {:domain => "#{domain}", :availability => JSON.parse(response.body)['availability']}
      Progress.step 1
    end
    hydra.queue(request)
  end
  hydra.run
end

File.delete(FILENAME) if File.exists?(FILENAME)
file = File.open(FILENAME, 'w')
file.write(Saving.generate_html(data))
file.close

puts "Done! results saved to #{FILENAME}"
