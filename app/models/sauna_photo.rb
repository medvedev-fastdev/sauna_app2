#require 'paperclip_processors/watermark'

class SaunaPhoto < ActiveRecord::Base
  belongs_to :sauna
  has_attached_file :photo, 
					#:processors => [:watermark],
                    :styles => {
                      :thumb => ["100x100", :jpg],
					  :pagesize => ["600x400", :jpg]
#					  :pagesize => {
#						:geometry => '500x400',
#						:format => :jpg,
#						:watermark_path => "#{Rails.root}/public/images/watermark.png",
#						:position => 'Center'
#					  }						  
                    },
                    :default_style => :pagesize,
					:storage => :s3,
					:s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
					:path => ":attachment/:id/:style.:extension",
					:bucket => "go-to-sauna"					
									
end
