def createScribbleType name, full_name
	s = ScribbleType.new
	s.name = name
	s.full_name = full_name
	s.save()
end

def createUser name
	u = User.new
	u.username = name
	#password: qwerty
	u.crypted_password = "$2a$10$I4H9sFeCiG3hCZ2ionKf1Oqn4gRHkf1UDO3P/D3KN67g5emSqMp.S"
	u.salt = "zUi1psZ7nxZ1EjW3Y839"
	u.save()
end

createUser 'Lyle'
createUser 'Brenda'
createUser 'Caz'
createUser 'Bob'

createScribbleType("duck","a duck");
createScribbleType("car","a car");
