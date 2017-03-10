require 'socket'  
require 'sqlite3'


 #BD / Utilizadores ativos / Socket TCP   
db = SQLite3::Database.open "WS.db"
activeUsers = Hash.new "Users"
server = TCPServer.open(2000) 

def addClient(nameC,pwd)

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

def logOffUser(id,connectS)
	nome = userNameG id
	puts "O cliente #{nome} acabou de sair"
	activeUsers.delete(id)
	connectS.close

end

def userNameG(id)
	statement = db.prepare "SELECT Name FROM Users WHERE Id=?"
	statement.bind_param 1,id
  
    rs = statement.execute 
    row = rs.next
end

def addReading(id,type,value,location,timestamp)
	
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

def trataCliente(connect,id)
	line = connect.gets

	while line.chomp != "Sair"
		#gets ID tipo leitura gps timestamp
		line = connect.gets
	end
contagem = connect.gets
puts "#{contagem}"
logOffUser id,connect

end


#Main Loop e Comandos

db.execute "CREATE TABLE IF NOT EXISTS Users(Id INTEGER AUTO_INCREMENT PRIMARY KEY, Name TEXT NOT NULL , Pwd TEXT NOT NULL)"
db.execute "CREATE TABLE IF NOT EXISTS Readings(R_Id INTEGER AUTO_INCREMENT PRIMARY KEY, U_id INTEGER NOT NULL, Sensor TEXT,Valor REAL ,Latitude REAL,Longitude REAL,Ran REAL, TimeS datetime,FOREIGN KEY(U_Id) REFERENCES  Users(Id))"
Thread.new{
i = true
while i == true do
puts "Funcionablidades:\n 1 - Clientes Ativos\n2 - Leituras de Cliente\n3 - Sair"
cmd = gets
case cmd.chomp
when "1"
	puts "ID - NAME"
	activeUsers.each_pair { |id, nome| puts "#{id} - #{nome}"  }
when "2"
	puts "Id de Cliente\n"
	idP = gets.chomp.to_i
	listReads idP
when "3"
	i = false
else puts "Invalido"
end	
end                      # Servers run forever

}

loop {   

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
	Thread.new {trataCliente connect,userId}
	
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
	Thread.new {trataCliente connect,newID}


else
	connect.puts "KO"
	connect.close
end

end



}

#falta quando se desligam um cliente
