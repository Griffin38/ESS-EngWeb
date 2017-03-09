
require 'sqlite3'


    
db = SQLite3::Database.open "WS.db"
activeUsers = Hash.new
users = Hash.new "Users"

def addClient(name,pwd)
	db.execute "CREATE TABLE IF NOT EXISTS Users(Id INTEGER PRIMARY KEY, Name TEXT, Password TEXT)"
	db.execute "INSERT INTO Users VALUES(?,?)",name,pwd
	id = db.last_insert_row_id
	rescue SQLite3::Exception => e 
    nil
end

def logUser(name,pwd)
	statement = db.prepare "SELECT id FROM Users WHERE Name=? and Password = ?"
    stm.bind_param 1,name
    statement.bind_param 2 , pwd
    
    rs = stm.execute 
    row = rs.next
	rescue SQLite3::Exception => e 
    nil
end

def addReading(id,type,value,location,timestamp)
	#db.execute "CREATE TABLE IF NOT EXISTS Readings(Id INTEGER PRIMARY KEY, UserId INTEGER PRIMARY KEY, Sensor TEXT,Value INTEGER,LATitude FLOAT,Longitude FLOAT,RANGE FLOAT,timestamp )"
	#db.execute "INSERT INTO Users VALUES(?,?)",name,pwd
end

loop {                          # Servers run forever
connect = server.accept
line = connect.gets
case line.chomp
when "login"
user = connect.gets.chomp 
pwd = connect.gets.chomp
userID = logUser user,pwd
if userID
	connect.puts "OK"
	connect.puts "#{userID}"
	#leiturass
	#gets ID tipo leitura gps timestamp
else
	connect.puts "KO"
	connect.close
end

when "registo"
user = connect.gets.chomp 
pwd = connect.gets.chomp
newID = addClient user,pwd
if newID
connect.puts "OK"
connect.puts "#{newID}"
#leituras
else
	connect.puts "KO"
	connect.close
end

end
}

