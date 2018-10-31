require "google_drive"

class Contact < ApplicationRecord
	validates :name, presence:true, length: { maximum: 50}
	validates :phone, phone: { possible: true, allow_blank: false, countries: :ru }
	after_initialize :default_values

	def default_values
		@step = 10
		@maxColumns = 7
		@skip = 1
		@workshTitles = ["ID","Имя","Номер","Дата","Повтор","Отказ","Заказ"]
	end

	def initialInsertion #run it with break longer than 1 minute
		Contact.where('addrow2="отказ"').all.delete_all
		maxInDb = Contact.all.count
		lastContactId = 0
		step = @step
		maxColumns = @maxColumns
		skip = @skip
		worksheetNum = 1

		session = GoogleDrive::Session.from_config("client_secret.json")
		spreadsheet = session.spreadsheet_by_title("contactsSpreadsheet")
		worksheet = spreadsheet.worksheets

		worksheet.count.downto(2){|i| worksheet[i-1].delete} #first worksheet must remain
		worksheet.first.delete_rows(1,worksheet.first.max_rows-1) #interpreter returning error if i refer to last worksheet (worksheet.last)
		worksheet.first.save

		while(maxInDb > 0) do
			rowsFromDB = Contact.where("id>#{lastContactId}").limit(step).order(id: :asc)
			lastContactId = rowsFromDB.last.id
			maxInDb -= rowsFromDB.count
			worksheet = spreadsheet.worksheets						 
			worksheet.last.insert_rows(1,objectToArray(rowsFromDB))
			worksheet.last.save
			if maxInDb > 0
				spreadsheet.add_worksheet("#{worksheet.count + 1}", max_rows = 1, max_cols = maxColumns)
			end
		end		
	end


	def updateWorksheet

		if(Time.now.localtime.hour == 1 && (Time.now.localtime.min >= 0 && Time.now.localtime.min <=10))
			return
		elsif(Time.now.localtime.wday == 1 && (Time.localtime.now.hour == 2 && (Time.localtime.now.min >= 0 && Time.localtime.now.min <=20)))
			return
		end
			
		step = @step
		skip = @skip
		maxColumns = @maxColumns

		session = GoogleDrive::Session.from_config("client_secret.json")
		spreadsheet = session.spreadsheet_by_title("contactsSpreadsheet")
		worksheet = spreadsheet.worksheets
		currentRowsNum = worksheet.last.num_rows
		currentContactsNum = currentRowsNum - skip

		if(currentRowsNum > 0)
			lastDBObjId = worksheet.last.numeric_value(2, 1)
			if lastDBObjId.nil?
				lastDBObjId = 0
			end
			arrayOfRows = Contact.where("id>#{lastDBObjId}")
			newData = arrayOfRows.size
			if(newData > 0)
				if((step - currentContactsNum) > 0)
					if(newData <= step - currentContactsNum)
						worksheet.last.insert_rows(skip + 1, hashToArray(arrayOfRows))
						worksheet.last.save
					else
						upTo = lastDBObjId + step - currentContactsNum
						arrayOfRowsL = arrayOfRows.where("id>#{lastDBObjId} and id<=#{upTo}")
						worksheet.last.insert_rows(skip + 1,hashToArray(arrayOfRowsL))
						worksheet.last.save
						headers = worksheet.last.rows[0]
						spreadsheet.add_worksheet("#{worksheet.count + 1}", max_rows = 1, max_cols = maxColumns)
						worksheet = spreadsheet.worksheets
						worksheet.last.insert_rows(1,[headers])
						arrayOfRowsR = arrayOfRows.where("id>#{upTo} and id<=#{arrayOfRows.last.id}")
						worksheet.last.insert_rows(skip + 1,hashToArray(arrayOfRowsR))
						worksheet.last.save										
					end
				else
					headers = worksheet.last.rows[0]
					spreadsheet.add_worksheet("#{worksheet.count + 1}", max_rows = 1, max_cols = maxColumns)
					worksheet = spreadsheet.worksheets
					worksheet.last.insert_rows(1,[headers])
					worksheet.last.insert_rows(skip + 1, hashToArray(arrayOfRows))
					worksheet.last.save
				end
			end
		end
	end

	def synchronizeDatabase
		skip = @skip
		betweenSyncTime = 86400 #24 hours in seconds
		errorTime = 900 #900 seconds = 15 minutes

		session = GoogleDrive::Session.from_config("client_secret.json")
		spreadsheet = session.spreadsheet_by_title("contactsSpreadsheet")
		worksheet = spreadsheet.worksheets

		worksheet.each{|worksh|
			lastModified = worksh.updated.localtime.utc
			if((Time.now.localtime.utc - lastModified) < (betweenSyncTime - errorTime))# do not update if spreadsheet wasn't updated
				firstId = worksh.rows[worksh.num_rows-1][0]
				lastId = worksh.rows[skip][0]
				arrayOfRows = worksh.rows(skip = skip)
				numberOfRows = arrayOfRows.size
				j = numberOfRows - 1

				Contact.find_each(start: firstId, finish: lastId) do |user|
	 				if(user.id == arrayOfRows[j][0].to_i)
 						if (arrayOfRows[j][4] != "" && user.addrow1 != arrayOfRows[j][4])
 							user.update(addrow1:"#{arrayOfRows[j][4]}")
 						elsif (arrayOfRows[j][5] != "" && user.addrow2 != arrayOfRows[j][5])
 							user.update(addrow2:"#{arrayOfRows[j][5]}")
 						elsif (arrayOfRows[j][6] != "" && user.addrow3 != arrayOfRows[j][6])
							user.update(addrow3:"#{arrayOfRows[j][6]}")
						end
					end
					j-=1							
 				end 					
 			end
		}
	end

	def hashToArray(arrayOfRows)#actually works similar to objectToArray
		arrayOfRows1 = []
		j = 0
		arrayOfRows.last.id.downto(arrayOfRows.first.id) { |i|
			array = arrayOfRows.where("id=#{i}").first
			next if array.nil?
			arrayOfRows1[j] = [array.id, array.name, array.phone, array.created_at.localtime, array.addrow1, array.addrow2, array.addrow3]
			j += 1
		}
		return arrayOfRows1
	end

	def objectToArray(arrayOfRows)#actually works similar to hashToArray
		arrayOfRows1 = []
		j = arrayOfRows.count
		arrayOfRows1[0] = @workshTitles
		arrayOfRows.each {|array|
			arrayOfRows1[j] = [array.id, array.name, array.phone, array.created_at.localtime, array.addrow1, array.addrow2, array.addrow3]
			j -= 1
		}
		return arrayOfRows1
	end
	
end