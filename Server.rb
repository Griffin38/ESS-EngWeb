
require 'sqlite3'


    
db = SQLite3::Database.open "WS.db"
activeUsers = Hash.new "Users"


def addClient(nameC,pwd)
	db.execute "CREATE TABLE IF NOT EXISTS Users(Id INTEGER PRIMARY KEY, Name TEXT, Password TEXT)"
	db.execute "INSERT INTO Users VALUES(?,?)",nameC,pwd
	id = db.last_insert_row_id
	rescue SQLite3::Exception => e 
    nil
end

def logUser(nameC,pwd)
	statement = db.prepare "SELECT id FROM Users WHERE Name=? and Password = ?"
    statement.bind_param 1,nameC
    statement.bind_param 2,pwd
    
    rs = statement.execute 
    row = rs.next
	rescue SQLite3::Exception => e 
    nil
end

def userNameG(id)
	statement = db.prepare "SELECT Name FROM Users WHERE Id=?"
	statement.bind_param 1,id
  
    rs = statement.execute 
    row = rs.next
end

def addReading(id,type,value,location,timestamp)
	#db.execute "CREATE TABLE IF NOT EXISTS Readings(Id INTEGER PRIMARY KEY, UserId INTEGER PRIMARY KEY, Sensor TEXT,Value INTEGER,LATitude FLOAT,Longitude FLOAT,RANGE FLOAT,timestamp )"
	#db.execute "INSERT INTO Users VALUES(?,?)",name,pwd
end

def listReads(id)
	statement = db.prepare "SELECT * FROM Readings where UserId = ?"
	statement.bind_param 1,id 
    rs = statement.execute 
    puts "ID - ClientID - Type - Value - Lat - Long - Range - Time "
    rs.each do |row|
        puts row.join " - "
    end

    rescue SQLite3::Exception => e 
    puts "Erro"
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
	connectName = userNameG userId
	activeUsers[userId] = connectName;
	puts "O cliente #{connectName} acabou de se Ligar"

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
	connectName = userNameG newID
	activeUsers[newID] = connectName;
	puts "O cliente #{connectName} acabou de se Ligar"

#leituras
else
	connect.puts "KO"
	connect.close
end

end

puts "Funcionablidades:\n 1 - Clientes Ativos\n2 - Leituras de Cliente\n"
cmd = gets
case cmd.chomp
when "1"
	puts "ID - NAME"
	activeUsers.each_pair { |id, nome| puts "#{id} - #{nome}"  }
when "2"
	puts "Id de Cliente\n"
	idP = gets.chomp.to_i
	listReads idP
else puts "Invalido"
end
}

