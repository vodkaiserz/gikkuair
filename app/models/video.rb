class Video < ActiveRecord::Base
	belongs_to :profile
	YT_LINK_FORMAT = /\A.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/i
	
  	validates :link, allow_blank: true, format: YT_LINK_FORMAT


end

