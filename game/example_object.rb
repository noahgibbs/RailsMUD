gem "railsgame"
require "railsgame"

gem "activerecord"
require "activerecord"

class BasicObject < ActiveRecord::Base
  serialize :tags, Hash
  serialize :descriptions, Hash
end
