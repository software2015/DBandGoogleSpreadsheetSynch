# Synchronization between Rails app and google spreadsheet

This app is for synchronization between ruby on rails app and google spreadsheets.
It takes names and phone numbers, saves them in database and inserts them to bound google spreadsheet every 5 minutes.
It also synchronizes database with spreadsheet once a day.
It has three rake tasks for data synchronization:

	1. update_worksheet
	2. synchronize_database
	3. initial_insertion

### Tech stack:

* Rails version 5.1.6.2
* Default development database: Sqlite3

### Steps for running the app:

	1. bundle install
	2. rails db:create
	3. rails db:migrate
	4. rails server
	5. whenever --update-crontab