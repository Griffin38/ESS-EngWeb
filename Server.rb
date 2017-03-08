






users = Hash.new("Users")

loop {                          # Servers run forever
connect = server.accept
line = connect.gets
case line.chomp
when "login"
user = connect.gets.chomp 
pwd = connect.gets.chomp
if users[user]==pwd
	connect.puts("OK")
	#trabaho de leituras
else
	connect.puts("KO")
	connect.close
end

when "registo"
user = connect.gets.chomp 
pwd = connect.gets.chomp
users[user] = pwd
connect.puts("OK")
#leituras
end
}

