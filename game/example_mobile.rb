gem "railsgame"
require "railsgame"

gem "activerecord"
require "activerecord"

class BasicMobile < ActiveRecord::Base
  serialize :tags, Hash
  serialize :descriptions, Hash

end
