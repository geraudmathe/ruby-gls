require 'net/http'
require 'json'

require 'ruby-gls/version'
require 'ruby-gls/configuration'
require 'nokogiri'
require 'byebug'

class RubyGLS
  RubyGLS.configure

  class << self

    def find(tracking_number)
      uri = URI(generate_url(tracking_number))
      res  = Net::HTTP.get_response(uri)
      
      parsed = JSON.parse(res.body)

      key = parsed.dig('content').keys.last
      html = parsed.dig('content', key, 'html')

      doc = Nokogiri::HTML(html)
      
      status = doc.css('.trigger-status').text.strip
      status_desc = doc.css('.text-primary.lead strong').text.strip
      parcel_number = doc.css('.row.justify-content-left').text&.strip&.split(':')&.last&.strip

      detailed = [].tap do |arr|
        doc.css('.data_table tbody tr').each do |row|
          
          date, time, parcel_status, loc = row.css('td').map(&:text).map(&:strip)
          
          arr << {
            date: date,
            time: time,
            parcel_status: parcel_status,
            location: loc
          }
        end
      end
      
      if status == ""
        status      = 'Not found' 
        status_desc = "No tracking information found for #{tracking_number}"
      end

      {
        tracking_number: tracking_number,
        status: status,
        status_description: status_desc,
        parcel_number: parcel_number,
        detailed_tracking: detailed
      }
    rescue => e
      {
        tracking_number: tracking_number,
        status: 'Not found',
        status_description: "#{e.message}"
      }
    end

    private

    def generate_url(tracking_number)
      RubyGLS.config.base_url + "&match=#{tracking_number}"
    end

  end
end