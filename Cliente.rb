require "socket"

server = TCPSocket.open("localhost", 2000)

def simula(id,server)

@temp = 0
@ruido = 0

   temperatura = Thread.new {
   loop {
   sleep(30)
   @temp++
   value = rand(-40..80)
   latitude = rand(-90.000000000...90.000000000)
   longitude = rand(-180.000000000...180.000000000)
   time = Time.now.getutc
   server.puts "#{id} Temperatura #{value} #{latitude} #{longitude} #{time}"
    }
   }   
   
   acustica = Thread.new {
   loop {
   sleep(1)
   @ruido++
   value = rand(0..200)
   latitude = rand(-90.000000000...90.000000000)
   longitude = rand(-180.000000000...180.000000000)
   time = Time.now.getutc
   server.puts "#{id} Acustica #{value} #{latitude} #{longitude} #{time}"
    }
   }   
puts "PARA TERMINAR ESCREVA: CLOSE"
if gets.chomp == "CLOSE" || gets.chomp == "close"
	Thread.kill(temperatura) 
	Thread.kill(acustica) 
	server.puts "Sair"
	total_leituras = @temp + @ruido
	server.puts "TOTAL DE LEITURAS: #{total_leituras}"
	puts "TOTAL DE LEITURAS: #{total_leituras}"
	server.close
end

end



puts "O que deseja fazer? (login/registo)"

case gets.chomp
when "login"
	server.puts "login"
	puts "Introduza as suas credenciais!"
	puts "Username:"
	username = gets.chomp
	server.puts "#{username}"
	puts "Password:"
	password = gets.chomp
	server.puts "#{password}"
	resposta = server.gets
	case resposta.chomp
	when "OK"
		
		id = server.gets
		simula(id,server)
	else 
		
		server.close
	end	

when "registo"
	server.puts "registo"
	puts "Introduza as credenciais desejadas:"
	puts "Username:"
	username = gets.chomp
	server.puts "#{username}"
	puts "Password:"
	password = gets.chomp
	server.puts "#{password}"
	resposta = server.gets
	case resposta.chomp
	when "OK"
		id = server.gets
		simula(id,server)
	else server.close
	end

else puts "Opcao invalida!"

end






