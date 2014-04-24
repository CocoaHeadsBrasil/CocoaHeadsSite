# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = AdminUser.new(:first_name => "Steve", :last_name => "Jobs", :email => "sjobs@cocoaheads.com.br", :username => "sjobs", :password => "sjobsch2014", :password_confirmation => "sjobsch2014").save