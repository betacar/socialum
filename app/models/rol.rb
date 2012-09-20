class Rol < ActiveRecord::Base
  has_and_belongs_to_many :users

  attr_accessible :name

  validates_associated :users

  validates_presence_of :name, :message => 'Debe indicar el nombre del rol'
end
