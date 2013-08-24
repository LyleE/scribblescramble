def createScribbleType name, full_name
	s = ScribbleType.new
	s.name = name
	s.full_name = full_name
	s.save()
end

createScribbleType("duck","a duck");
createScribbleType("car","a car");