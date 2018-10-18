require "google_drive"
require "csv"

class Contact < ApplicationRecord
	validates :name, presence:true, length: { maximum: 50}
	validates :phone, phone: { possible: true, allow_blank: false, countries: :ru}
	attr_accessor :lastModified, :biggestId



	def initialInsertion
		@biggestId = Contact.last.id# we consider that db is initially without blanck rows(No deleted rows)
		dataFile = File.open("app/models/betweenTaskData/rowsNumber.txt","w")
			dataFile << @biggestId
		dataFile.close()
		step = 10
		total = @biggestId
		currentId = 1
		countLoop = 1
		left = total

		if(total<step)
			rangeFrom = 1
			rangeTo = total
		else
			rangeFrom = 1
			rangeTo = step
		end

			
			CSV.open("app/models/betweenTaskData/Contacts.csv", "w") do |csv|
				csv << ["ID","Имя","Номер"]
				while(left>0)

					Contact.find_each(start: rangeFrom, finish: rangeTo) do |user|						
	 					if(user.id==currentId)
 							csv << [currentId,user.name,user.phone]
 							countLoop+=1
 							puts currentId
 						else
 							while(currentId != user.id)
 								csv << [currentId]
 								currentId+=1
 								countLoop+=1
 							end
 								csv << [currentId,user.name,user.phone]
 								countLoop+=1
 						end
						currentId+=1	
					end

					if(currentId < total)
						for i in countLoop..step
							csv <<  [currentId]
							currentId+=1
						end
					end

					if((left-step) < step)
						left-=step
						rangeFrom = rangeTo + 1
						rangeTo = total
					else
						left-=step
						rangeFrom = rangeTo+1
						rangeTo+=step
					end
						currentId = rangeFrom
						countLoop = 1
				end
			end
		session = GoogleDrive::Session.from_config("client_secret.json")
		spreadsheet = session.spreadsheet_by_title("Contacts")
		worksheet = spreadsheet.worksheets.first
		spreadsheet.update_from_file("app/models/betweenTaskData/Contacts.csv")
		@lastModified = worksheet.updated
	end

	def syncData
		dataFile = File.open("app/models/betweenTaskData/rowsNumber.txt","r")
			@biggestId = dataFile.readline.to_i
		dataFile.close()
		step = 50
		maxAtDB = @biggestId
		total = @biggestId		
		currentId = 1
		countLoop = 0

		if(total<step)
			rangeFrom = 1
			rangeTo = total
		else
			rangeFrom = 1
			rangeTo = step
		end

		session = GoogleDrive::Session.from_config("client_secret.json")
		spreadsheet = session.spreadsheet_by_title("Contacts")
		spreadsheet.export_as_file("app/models/betweenTaskData/Contacts.csv")
		
			left = total
			tempFile = CSV.open("app/models/betweenTaskData/ContactsTemp.csv", "w")
			tempFile << ["ID","Имя","Номер"]
			userInDB1 = Contact.where("id>=#{rangeFrom} and id<=#{rangeTo}")
			objectNum = userInDB1.count
			CSV.foreach("app/models/betweenTaskData/Contacts.csv", headers: true, encoding: "UTF-8") do |userInSpreadS|

				if(left>=1)
					if(countLoop == objectNum)
						if(rangeTo != total)
							if(left < step)
								rangeFrom = rangeTo + 1
								rangeTo = total
							else
								rangeFrom = rangeTo+1
								rangeTo+=step
							end
							userInDB1 = Contact.where("id>=#{rangeFrom} and id<=#{rangeTo}")
							objectNum = userInDB1.count
							countLoop = 0
							continueIt = true							
						end				
					end

	 					if(!userInDB1[countLoop].nil? && userInDB1[countLoop].id == currentId)
	 						if(userInDB1[countLoop].name != userInSpreadS["Имя"] || userInDB1[countLoop].phone != userInSpreadS["Номер"])

 								if(userInSpreadS["Имя"].nil? && userInSpreadS["Номер"].nil?)
 									Contact.where("id=#{currentId}").delete_all
 								else
 									Contact.where("id=#{currentId}").update(name:userInSpreadS["Имя"],phone:userInSpreadS["Номер"])
 								end

 							end
							tempFile << [currentId,userInSpreadS["Имя"],userInSpreadS["Номер"]]
 							currentId+=1
 							left-=1
							countLoop+=1
 						else 						
 							tempFile << [currentId]
 							currentId+=1
 							left-=1				
 						end
 				else
 					Contact.create(name:userInSpreadS["Имя"], phone:userInSpreadS["Номер"])
 				end

			end

			lastInDBId = Contact.last.id
			total = lastInDBId - currentId + 1 		
			left = total

			if(total<step)
				rangeFrom = currentId
				rangeTo = lastInDBId
			else
				rangeFrom = currentId
				rangeTo = currentId + step
			end

				while(left>0)
					Contact.find_each(start: rangeFrom, finish: rangeTo) do |user|
	 					if(user.id==currentId)
 							tempFile << [currentId,user.name,user.phone]
 						else
 							while(currentId != user.id)
 								tempFile << [currentId]
 								currentId+=1
 							end
 								tempFile << [currentId,user.name,user.phone]
 						end
 						currentId+=1
					end
							if((left-step) < step)
								left-=step
								rangeFrom = rangeTo + 1
								rangeTo = total
							else
								left-=step
								rangeFrom = rangeTo+1
								rangeTo+=step
							end
				end

			tempFile.close()

		session = GoogleDrive::Session.from_config("client_secret.json")
		spreadsheet = session.spreadsheet_by_title("Contacts")
		spreadsheet.update_from_file("app/models/betweenTaskData/ContactsTemp.csv")
		worksheet = spreadsheet.worksheets.first
		maxAtSheet = worksheet.num_rows
		@biggestId = maxAtSheet - 1
		@lastModified = worksheet.updated
		dataFile = File.open("app/models/betweenTaskData/rowsNumber.txt","w")
			dataFile << @biggestId
		dataFile.close()		
	end



	def e1
		session = GoogleDrive::Session.from_config("client_secret.json")
		spreadsheet = session.spreadsheet_by_title("Contacts")
		worksheet = spreadsheet.worksheets.first
		worksheet.insert_rows(2, [["Hello"]])
		worksheet.save
	end

	def e2
		session = GoogleDrive::Session.from_config("client_secret.json")
		spreadsheet = session.spreadsheet_by_title("Contacts")
		worksheet = spreadsheet.worksheets.first
		return worksheet.rows[0][2]
	end

	def e3
		session = GoogleDrive::Session.from_config("client_secret.json")
		spreadsheet = session.spreadsheet_by_title("Contacts")
		spreadsheet.export_as_file("/home/compdriver/Desktop/Contacts.csv")
	end

	def e4
		session = GoogleDrive::Session.from_config("client_secret.json")
		spreadsheet = session.spreadsheet_by_title("Contacts")
		spreadsheet.export_as_file("/home/compdriver/Desktop/Contacts.csv")
		worksheet = spreadsheet.worksheets.first
		worksheet.rows
	end

	def e5
		session = GoogleDrive::Session.from_config("client_secret.json")
		spreadsheet = session.spreadsheet_by_title("Contacts")
		worksheet = spreadsheet.worksheets.first
		worksheet.update_cells(1, 1, [["ID\n", "Name\n", "Phone\n"], ["1", "Reks", "78962562323"], ["2", "Reks", "78962562323"], ["3", "Alex", "78962562323"], ["4", "George", "78962562323"], ["5", "", ""], ["6", "Hello", "78962562323"], ["7", "Kevin", "78962562323"]])
		worksheet.save		
	end

	def e6
		session = GoogleDrive::Session.from_config("client_secret.json")
		spreadsheet = session.spreadsheet_by_title("Contacts")
		worksheet = spreadsheet.worksheets.first
		spreadsheet.update_from_file("/home/compdriver/Desktop/Contacts.csv")
	end

	def e7
		session = GoogleDrive::Session.from_config("client_secret.json")
		spreadsheet = session.spreadsheet_by_title("Contacts")
		worksheet = spreadsheet.worksheets.first
		@biggestId = Contact.last.id
		@lastModified = worksheet.updated
	end

	def e8
		session = GoogleDrive::Session.from_config("client_secret.json")
		spreadsheet = session.spreadsheet_by_title("Contacts")
		worksheet = spreadsheet.worksheets.first
		worksheet.num_rows
	end

	def e8
Contact.find_each(start: 1, finish: 39) do |userInDB|
	userInDB.update(name:"Hello", phone:"+71112223333")
end
	end

end