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





createScribbleType("duck","a duck");
createScribbleType("car","a car");
createScribbleType("house","a house");
createScribbleType("boat","a boat");
createScribbleType("cat","a cat");
createScribbleType("guitar","a guitar");
createScribbleType("headphones","a pair of headphones");
createScribbleType("train","a train");
createScribbleType("mouse","a mouse");
createScribbleType("football","a football");
createScribbleType("high-heeled shoe","a high-heeled shoe");
createScribbleType("cheese","a slice of cheese");
createScribbleType("dog","a dog");
createScribbleType("toothbrush","a toothbrush");
createScribbleType("Earth","Earth");
createScribbleType("newspaper","a newspaper");
createScribbleType("chcolate bar","a chocolate bar");
createScribbleType("coke","a bottle of coke");
createScribbleType("hammer","a hammer");
createScribbleType("lightbulb","a lightbulb");
createScribbleType("self portrait","yourself");
createScribbleType("glasses","a pair of glasses");
createScribbleType("skull","a skull");
createScribbleType("television","a television");
createScribbleType("spaceship","a spaceship");
createScribbleType("flower","a flower");
createScribbleType("giraffe","a giraffe");
createScribbleType("ferris wheel","a ferris wheel");
createScribbleType("lighthouse","a lighthouse");
createScribbleType("postbox","a postbox");
createScribbleType("bee","a bee");
createScribbleType "brick", "a brick"
createScribbleType "discoball", "a discoball"
createScribbleType "seagull", "a seagull"
createScribbleType "dice", "a set of dice"
createScribbleType "frisbee", "a frisbee"
createScribbleType "crown", "a crown"
createScribbleType "spork", "a spork"
createScribbleType "diamond", "a diamond"
createScribbleType "catapult", "a catapult"
createScribbleType "robot", "a robot"
createScribbleType "castle", "a castle"
createScribbleType "butterfly", "a butterfly"
createScribbleType "bridge", "a bridge"
createScribbleType "strawberry", "a strawberry"
createScribbleType "hot air balloon", "a hot air balloon"
createScribbleType "spider", "a spider"
createScribbleType "fireplace", "a fireplace"
createScribbleType "sword", "a sword"
createScribbleType("monkey","a monkey");