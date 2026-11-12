resource "graylog_index_set_field_type_profile" "http" {
  name        = "HTTP fields"
  description = "Consistent field types for application logs"

  custom_field_mappings = {
    "client.ip"   = "ip"
    response_code = "long"
    duration_ms   = "double"
    request_path  = "string"
    error_message = "string_fts"
  }
}

resource "graylog_index_set" "http" {
  title              = "HTTP logs"
  index_prefix       = "http_logs"
  shards             = 1
  replicas           = 0
  field_type_profile = graylog_index_set_field_type_profile.http.id

  use_legacy_rotation = false
  data_tiering = jsonencode({
    type               = "hot_only"
    index_lifetime_min = "P30D"
    index_lifetime_max = "P40D"
  })
}

# Mapping/profile changes apply to future indices. Rotate separately in Graylog
# when you want a changed mapping to apply to newly ingested messages immediately.
# To detach: field_type_profile = ""
# To stop managing the binding while preserving it: remove field_type_profile.
