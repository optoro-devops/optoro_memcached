require 'chefspec'
require 'chefspec/berkshelf'

ChefSpec::Coverage.start!

require File.expand_path('../resources.rb', __FILE__)
