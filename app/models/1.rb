require "google_drive"
require "csv"

#			tempFile = CSV.open("/home/compdriver/Desktop/ContactsTemp.csv", "w")
#			tempFile << ["Hello"]

#Contact.find_each(start: 1, finish: 39) do |userInDB|
#	userInDB.update(name:"Hello", phone:"+71112223333")
#end

#hello = CSV.open("/home/compdriver/Desktop/Contacts.csv", headers: true, encoding: "UTF-8")
#				puts hello["Имя"]


#	CSV.foreach('/home/compdriver/Desktop/Contacts.csv', headers: true, encoding: "UTF-8") do |row|
#  	puts row["Имя"] + " " + row["Номер"]
#	end

#	CSV.foreach('/home/compdriver/Desktop/Contacts.csv', headers: true, encoding: "UTF-8") do |row|
#  	User.create(row.to_hash)
#	puts "e"

#		session = GoogleDrive::Session.from_config("client_secret.json")
#		spreadsheet = session.spreadsheet_by_title("Contacts")
#		spreadsheet.export_as_file("/home/compdriver/Desktop/Contacts.csv")
#		worksheet = spreadsheet.worksheets.first


#hello = CSV.open("/home/compdriver/Desktop/ContactsTemp.csv", "a+")

#	hello = CSV.open("/home/compdriver/Desktop/ContactsTemp.csv", "w")
#	hello << ["Good"]
#	CSV.foreach("/home/compdriver/Desktop/Contacts.csv", headers: true, encoding: "UTF-8") do |csv|
#		hello << csv["Имя"]
#		puts  "Hello" #csv["Имя"]  + " " + csv["Номер"]
#		hello << [csv["Имя"]]
#	end

