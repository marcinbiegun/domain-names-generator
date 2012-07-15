module Saving
  def self.generate_html(data)
    html = ""
    html << "<html>\n"
    html << "<body style='font-family: arial; line-height: 2'>\n"
    html << "<ul>\n"

    data.group_by{|data| data[:domain].split('.').last}.each do |ending, results|
      results.sort_by{|result| result[:domain]}.each do |result|
        case result[:availability]
        when 'available'
          html << "<li>\n"
        else
          html << "<li style='color: gray'>\n"
        end
        html << result[:domain]
        html << "</li>\n"
      end
    end

    html << "</ul>\n"
    html << "</body>\n"
    html << "</html>\n"
  end
end
