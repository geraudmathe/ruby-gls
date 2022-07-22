# ruby-GLS
Ruby client for GLS shipment tracker and parcel creator

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'ruby-gls', '1.0.5'
```

...followed with:
```
bundle install
```

Or install it with:
```
gem install ruby-gls
```

You can find the full GLS documentation in the [this link](https://shipit.gls-group.eu/webservices/3_0_6/doxygen/WS-REST-API/rest_shipment_processing.html#commonSoapShipmentProcessing)

## Usage
```
connection = RubyGLS::Connection.new(base_url: 'https://shipit-wbm-test01.gls-group.eu:8443', basic_auth: 'Mjc2YTQ1ZmtxTTpsWFpCSUY3dVJjY3lLN09ocjY0ZA==', contact_id: '276a45fkqM')
```

Or with password and username it can be initialized in the following way:

```
connection = RubyGLS::Connection.new(base_url: 'https://shipit-wbm-test01.gls-group.eu:8443', username: '276a45fkqM', password: 'lXZBIF7uRccyK7Ohr64d', contact_id: '276a45fkqM')
```

### Create parcel

```
opts = {
  "Shipment": {
      "ShipmentReference":["Ref-Unit-1234"],
      "Product":"PARCEL",
      "Consignee":{
          "ConsigneeID":"1234567890",
          "Address":{
              "Name1":"Tim Test",
              "Name2":"",
              "Name3":"",
              "CountryCode":"DE",
              "ZIPCode":"65760",
              "City":"Testingen",
              "Street":"Testallee",
              "eMail":"tim.test@gls.de",
              "ContactPerson":"Laura Test",
              "MobilePhoneNumber":"004912345678910",
              "FixedLinePhonenumber":"004912345678910"
          }
      },
      "Shipper": {
          "ContactID": "276a45fkqM"
      },
      "ShipmentUnit": [
          {
              "Weight": 5
          }
      ]
  },
  "PrintingOptions":{
      "ReturnLabels":{
          "TemplateSet":"NONE",
          "LabelFormat":"PDF"
      }
  }
}

connection.create_parcel(opts)
```

### Cancel parcel by ID

```
connection.cancel_parcel(<Tracking Number>)
```

### Get end of day report

```
connection.get_end_of_day_report(Date.today)
```

### Get allowed services

```
opts = {
  "Source":{
      "CountryCode":"DE",
      "ZIPCode":"38106"
  },
  "Destination":{
      "CountryCode":"DE",
      "ZIPCode":"65779"
  }
}

connection.get_allowed_services(opts)
```

### Update parcel weight

```
opts = {
  "TrackID": "ZDF8DOSZ",
  "Weight": "17.0"
}

connection.update_parcel_weight(opts)

```

The base URL for tracking setup to: `https://api.gls-pakete.de/trackandtrace?lang=en`. That can be changed in the following way:

```
RubyGLS.configure do |config|
  config.base_url = <YOUR_BASE_URL>
end
```


### Find a shipment per tracking number

```
gls = RubyGLS::Connection.find(<TRACKING_NUMBER>)

```

### Response
A sample success response looks like this:

```
{
  tracking_number: '1234567',
  status: 'Delivered',
  status_description: 'The parcel has been delivered',
  parcel_number: 'ABC123',
  detailed_tracking: [
    {
      date: 08.12.2021,
      time: 08:12,
      parcel_status: 'The parcel has been picked up by GLS.',
      location: 'Germany Nuernberg-Hafen'
    }
    ...
  ]
}
```

## Thank you for using RubyGLS!


