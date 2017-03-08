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
		### ENVIAR VALORES
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

else puts "Opcao invalida!"

end

server.close