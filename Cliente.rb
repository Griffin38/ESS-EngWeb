require "socket"

server = TCPSocket.open("localhost", 2626)

puts "O que deseja fazer? (login/registo)"

case gets.chomp
when "login"
	server.puts "login"
	puts "Introduza as suas credenciais!"
	puts "Login:"
	login = gets.chomp
	server.puts "#{login}"
	puts "Password:"
	password = gets.chomp
	server.puts "#{password}"
	resposta = server.gets
	if resposta = "OK"
		simula()
	else server.close
	end	

when "registo"
	server.puts "registo"
	puts "Introduza as credenciais desejadas:"
	puts "Login:"
	login = gets.chomp
	server.puts "#{login}"
	puts "Password:"
	password = gets.chomp
	server.puts "#{password}"

	if resposta = "OK"
		simula()
	else server.close
	end

else puts "Opcao invalida!"

end

def simula()
puts "PARA TERMINAR ESCREVA: CLOSE"
@temp = 0
@ruido = 0

   Thread.new {
   loop
   sleep(30)
   @temp++
   value = rand(-40..80)
   latitude = rand(-90.000000000...90.000000000)
   longitude = rand(-180.000000000...180.000000000)
   time = Time.now.getutc
   server.puts "Nome: #{login} | Tipo: Temperatura | Valor: #{value} | GPS: #{latitude}, #{longitude} | Timestamp: #{time}"
   end
   }   
   
   Thread.new {
   loop
   sleep(1)
   @ruido++
   value = rand(0..200)
   latitude = rand(-90.000000000...90.000000000)
   longitude = rand(-180.000000000...180.000000000)
   time = Time.now.getutc
   server.puts "Nome: #{login} | Tipo: Acustica | Valor: #{value} | GPS: #{latitude}, #{longitude} | Timestamp: #{time}"
   end
   }   

if gets.chomp == "CLOSE" || gets.chomp == "close"
	total_leituras = @temp + @ruido
	server.puts "TOTAL DE LEITURAS: #{total_leituras}"
	puts "TOTAL DE LEITURAS: #{total_leituras}"
	server.close
end

end




