desc "update worksheet"
task update_worksheet: :environment do
	contact = Contact.new
	contact.updateWorksheet
end

desc "synchronize database"
task synchronize_database: :environment do
	contact = Contact.new
	contact.synchronizeDatabase
end

desc "initial_insertion"
task initial_insertion: :environment do
	contact = Contact.new
	contact.initialInsertion
end