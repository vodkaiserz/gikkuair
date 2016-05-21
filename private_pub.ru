# Run with: rackup private_pub.ru -s thin -E production
# run with this instead:  bundle exec thin start -R private_pub.ru -e production -a 0.0.0.0 -p 9292
require "bundler/setup"
require "yaml"
require "faye"
require "private_pub"

Faye::WebSocket.load_adapter('thin')

PrivatePub.load_config(File.expand_path("../config/private_pub.yml", __FILE__), ENV["RAILS_ENV"] || "development")
run PrivatePub.faye_app
