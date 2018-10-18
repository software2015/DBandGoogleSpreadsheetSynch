desc 'synchronize data'

task initial_insertion: :environment do
	contact = Contact.new
	contact.initialInsertion
end

task synchronize_data: :environment do
	contact = Contact.new
	contact.syncData
end