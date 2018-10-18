require "google_drive"

class ContactsController < ApplicationController

	def new_contact
		@contact = Contact.new
	end

	def save_contact
		@contact = Contact.new(contact_params)
		if @contact.save

			render 'new_contact'

		else
			render 'new_contact'
		end	
	end


	private

		def contact_params
			params.require(:contact).permit(:name, :phone)
		end

end