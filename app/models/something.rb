class Something < ActiveRecord::Base
  # extend Slugifiable::ClassMethods
  # include Slugifiable::InstanceMethods

  belongs_to :users
  belongs_to :nothings

end
