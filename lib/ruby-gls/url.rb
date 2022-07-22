module RubyGLS::URL
  CREATE_PARCEL         = '/backend/rs/shipments'
  CANCEL_PARCEL         = '/backend/rs/shipments/cancel/:parcel_id'
  GET_ALLOWED_SERVICES  = '/backend/rs/shipments/allowedservices'
  VALIDATE_PARCELS      = '/backend/rs/shipments/validate'
  GET_END_OF_DAY_REPORT = '/backend/rs/shipments/endofday?date=:date'
  UPDATE_PARCEL_WEIGHT  = '/backend/rs/shipments/updateparcelweight'
end