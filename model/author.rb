require 'active_record'

class Author < ActiveRecord::Base
  has_many :books
end