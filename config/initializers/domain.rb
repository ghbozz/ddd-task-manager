Dir[Rails.root.join('lib/domain/**/*.rb')].each { |file| require file }