require "google_drive"

class ContactsController < ApplicationController

	def new_contact
		@contact = Contact.new
	end

	def save_contact
		@contact = Contact.new(contact_params)
		if @contact.save

			session = GoogleDrive::Session.from_config("client_secret.json")
			spreadsheet = session.spreadsheet_by_title("Contacts")
			worksheet = spreadsheet.worksheets.first
			worksheet.insert_rows(2, [[@contact.id,@contact.name,@contact.phone ]])
			worksheet.save

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