require 'rubygems'
require 'bcrypt'

password = BCrypt::Password.create('zildjian')

# puts password
puts "Salt: #{password.salt}"
puts "Checksum: #{password.checksum}"
