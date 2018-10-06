class Contact < ApplicationRecord
	validates :name, :phone, presence:true
	validates :phone, presence:true	
end
