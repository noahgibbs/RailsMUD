class BasicMobile < ActiveRecord::Base
  serialize :tags, Hash
  serialize :descriptions, Hash

  validates_uniqueness_of :name
end
