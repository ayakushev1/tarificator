# main, authorities_data, url_access_authorities_data 

%w{
  authorities_data url_access_authorities_data
}.each do |part|
  require File.expand_path(File.dirname(__FILE__))+"/seeds/#{part}.rb"
end
