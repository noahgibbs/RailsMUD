class BasicExit < ActiveRecord::Base
  belongs_to :basic_object
  serialize :tags, Hash
end
