require "google_drive"
class ContactsController < ApplicationController


	def new_contact
		@contact = Contact.new
	end

	def save_contact
		@contact = Contact.new(contact_params)
		if @contact.save

	session = GoogleDrive::Session.from_config("client_secret.json")
	spreadsheet = session.spreadsheet_by_title("Hello")
	worksheet = spreadsheet.worksheets.first

			worksheet.insert_rows(2, [[contact_params[:name],contact_params[:phone] ]])
			worksheet.save

		else
		end	
	end


	private

		def contact_params
			params.require(:contact).permit(:name, :phone)
		end

end