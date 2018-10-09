class Contact < ApplicationRecord
	validates :name, presence:true, length: { maximum: 50}
	validates :phone, phone: { possible: true, allow_blank: false, countries: :ru}
end
