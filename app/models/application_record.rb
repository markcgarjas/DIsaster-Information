class ApplicationRecord < ActiveRecord::Base
  require 'carrierwave/orm/activerecord'
  primary_abstract_class
end
