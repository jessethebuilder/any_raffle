Rails.application.config.generators do |g|
  g.test_framework :rspec, :view_specs => false, routing_specs: false, request_specs: false
end