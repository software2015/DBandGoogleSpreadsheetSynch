every  5.minutes do
	rake 'update_worksheet'
end

every  :day, :at => "1:00am" do
	rake 'synchronize_database'
end

every :monday, :at => "2:00am" do
	rake 'initial_insertion'
end