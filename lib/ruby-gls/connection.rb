require 'ruby-gls/helper'
require 'ruby-gls/tracking'

class RubyGLS::Connection
  extend RubyGLS::Tracking
  include RubyGLS::Helper

  attr_reader :client

  def initialize(base_url:, basic_auth: nil, username: nil, password: nil, contact_id: nil)
    @client = RubyGLS::Client.new(base_url, basic_auth, username, password, contact_id)
  end

  #
  # https://shipit.gls-group.eu/webservices/3_0_6/doxygen/WS-REST-API/rest_shipment_processing.html#REST_API_REST_F_114
  #
  def create_parcel(opts)
    payload = opts 
    payload[:Shipment][:Shipper][:ContactID] = client.contact_id
    
    action(RubyGLS::URL::CREATE_PARCEL, payload: payload)
  end
  
  def track_parcel(opts)
    action(RubyGLS::URL::TRACK_PARCEL, payload: opts)
  end
  
  def find_parcels(opts)

    action(RubyGLS::URL::FIND_PARCELS, payload: opts)
  end

  #
  # https://shipit.gls-group.eu/webservices/3_0_6/doxygen/WS-REST-API/rest_shipment_processing.html#REST_API_REST_F_115
  #
  def validate_parcels(**opts)
    payload = opts 
    payload[:Shipment][:Shipper][:ContactID] = client.contact_id

    action(RubyGLS::URL::VALIDATE_PARCELS, payload: opts)
  end

  #
  # https://shipit.gls-group.eu/webservices/3_0_6/doxygen/WS-REST-API/rest_shipment_processing.html#REST_API_REST_F_117
  #
  def get_allowed_services(**opts)
    action(RubyGLS::URL::GET_ALLOWED_SERVICES, payload: opts)
  end

  #
  # https://shipit.gls-group.eu/webservices/3_0_6/doxygen/WS-REST-API/rest_shipment_processing.html#REST_API_REST_F_116
  #
  def cancel_parcel(tracking_number)
    path = replace_string(RubyGLS::URL::CANCEL_PARCEL, ':parcel_id', tracking_number)

    action(RubyGLS::URL::CANCEL_PARCEL)
  end

  #    
  # https://shipit.gls-group.eu/webservices/3_0_6/doxygen/WS-REST-API/rest_shipment_processing.html#REST_API_REST_F_119
  #
  def update_parcel_weight(**opts)
    action(RubyGLS::URL::UPDATE_PARCEL_WEIGHT, payload: opts)
  end

  #
  # https://shipit.gls-group.eu/webservices/3_0_6/doxygen/WS-REST-API/rest_shipment_processing.html#REST_API_REST_F_118
  #
  def get_end_of_day_report(date)
    path = replace_string(RubyGLS::URL::GET_END_OF_DAY_REPORT, ':date', date)
    action(path)
  end

  private

  def action(path, payload: {})
    client.action(path, payload: payload)
  end
end
