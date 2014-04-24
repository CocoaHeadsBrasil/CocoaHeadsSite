#!/usr/bin/ruby
# @Author: george
# @Date:   2014-03-20 23:13:15
# @Last Modified by:   george
# @Last Modified time: 2014-03-21 17:32:05

CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => ENV['AWS_ACCESS_KEY_ID'],
    :aws_secret_access_key  => ENV['AWS_SECRET_ACCESS_KEY'],
    :endpoint 				=> 'http://s3.amazonaws.com'
  }
  config.fog_directory  = ENV['AWS_FOG_DIRECTORY']
end