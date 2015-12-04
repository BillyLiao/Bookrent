class Book < ActiveRecord::Base
	validates_numericality_of :left, :greater_than => -1
	validates_numericality_of :left, :only_integer => true
	validates_presence_of :name, :writer
	belongs_to :user

	mount_uploader :image, ImageUploader
end
