module Naming
  def self.generate_domains
    domains = []

    begin
      nouns = File.open('data/nouns').lines.map(&:strip).map(&:capitalize)
      nouns_multi = File.open('data/nouns_multi').lines.map(&:strip).map(&:capitalize)
      verbs = File.open('data/verbs').lines.map(&:strip).map(&:capitalize)
      numbers = File.open('data/numbers').lines.map(&:strip).map(&:capitalize)
    rescue => error
      puts "Unable to files in /data directory:"
      puts error
    end

    # com
    domains << nouns.map { |noun| verbs.map { |verb| "#{verb}#{noun}.com" } }
    domains << nouns_multi.map { |noun| verbs.map { |verb| "#{verb}#{noun}.com" } }
    domains << nouns_multi.map { |noun| numbers.map { |number| "#{number}#{noun}.com" } }

    # co
    domains << nouns.map { |noun| verbs.map { |verb| "#{verb}#{noun}.co" } }
    domains << nouns_multi.map { |noun| verbs.map { |verb| "#{verb}#{noun}.co" } }
    domains << nouns_multi.map { |noun| numbers.map { |number| "#{number}#{noun}.co" } }

    # io
    domains << nouns.map { |noun| "#{noun}.io" }
    domains << nouns_multi.map { |noun| numbers.map { |number| "#{number}#{noun}.io" } }

    domains.flatten
  end
end
