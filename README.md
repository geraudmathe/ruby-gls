# ruby-GLS
Ruby client for GLS shipment tracker

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'ruby-gls', '0.0.3'
```

...followed with:
```
bundle install
```

Or install it with:
```
gem install ruby-gls
```

## Usage
```
gls = RubyGLS.find(<TRACKING_NUMBER>)
```

The base URL for tracking setup to: `https://api.gls-pakete.de/trackandtrace?lang=en`. That can be changed in the following way:

```
RubyVibe.configure do |config|
  config.base_url = <YOUR_BASE_URL>
end
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


