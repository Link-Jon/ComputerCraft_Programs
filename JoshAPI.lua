-- General API
-- ...
-- Helper functions and whatnots
-- Mostly by Josh, if not is probably noted
--
-- os.loadAPI("JoshAPI")

version = 0.4 --Very arbitrary

--For prevent and allow termination
osPullEvent = os.pullEvent

function getVersion()
	return version
end

function refuel() --Turtle
	if not turtle then return false end

	local fuelLevel = turtle.getFuelLevel() --Note this is from built in turtle programs (excavate, tunnel)
	if fuelLevel == "unlimited" or fuelLevel > 0 then
		return
	end

	local function tryRefuel()
		for n=1,16 do
			if turtle.getItemCount(n) > 0 then
				turtle.select(n)
				if turtle.refuel(1) then
					turtle.select(1)
					return true
				end
			end
		end
		turtle.select(1)
		return false
	end

	if not tryRefuel() then
		print( "Add more fuel to continue." )
		while not tryRefuel() do
			sleep(1)
		end
		print( "Resuming." )
	end
end

function cleanTerm()
	term.clear()
	term.setCursorPos(1,1)
end

function forward(num) --Turtle
	if not turtle then return false end

	refuel()
	if num == nil or num <= 0 then num = 1 end
	for x = 1, num do
		if not turtle.forward() then
			print("Obstruction")
			sleep(1)
			forward()
		end
	end
end

function back(num) --Turtle
	if not turtle then return false end

	refuel()
	if num == nil or num <= 0 then num = 1 end
	for x = 1, num do
		if not turtle.back() then
			print("Obstruction")
			sleep(1)
			back()
		end
	end

end

function up(num) --Turtle
	if not turtle then return false end

	refuel()
	if num == nil or num <= 0 then num = 1 end
	for x = 1, num do
		if not turtle.up() then
			print("Obstruction")
			sleep(1)
			up()
		end
	end
end

function down(num) --Turtle
	if not turtle then return false end

	refuel()
	if num == nil or num <= 0 then num = 1 end
	for x = 1, num do
		if not turtle.down() then
			print("Obstruction")
			sleep(1)
			down()
		end
	end
end

function dropThings() --Turtle
	if not turtle then return false end

	for i=1,16 do
		turtle.select(i)
		turtle.drop()
	end
	turtle.select(1)
end

function parse(x)
	--Designed for arguments
	--Basicly change unknown/string type into proper type (bool, int, str)
	if x == nil then --its nothing
		return nil, nil
	elseif tonumber(x) ~= nil then --its a number
		return tonumber(x), "number"
	elseif string.lower(tostring(x)) == "true" then --its boolean true
		return true, "boolean"
	elseif string.lower(tostring(x)) == "false" then --its boolean false
		return false, "boolean"
	else --must be string
		return string.lower(tostring(x)), "string"
	end
end

function preventTermination(a)
	if a == false then --another way of disabling
		allowTermination()
	else
		os.pullEvent = os.pullEventRaw
	end
end

function allowTermination()
	os.pullEvent = osPullEvent
end

function getPeripherals(pType)
	local foundPs = {} --Contains number and side of peripheral
	local foundType = {} --Contains number and side of specific peripherals
	local sides = redstone.getSides() --Top, Right, Front, etc

	--Get peripherals on sides
	for s=1,#sides do
		if peripheral.isPresent(sides[s]) then
			foundPs[#foundPs+1] = sides[s]
		end
	end

	--Get peripherals on wired modems
	for p=1,#foundPs do
		if peripheral.getType(foundPs[p]) == "modem" then
			modem = peripheral.wrap(foundPs[p])
			if not modem.isWireless() then --Wireless modems do not have peripheral abilitys
				local modemPs = modem.getNamesRemote() --Get peripherals on modem
				for x=1, #modemPs do
					foundPs[#foundPs+1] = modemPs[x]
				end
			end
		end
	end

	if pType == nil then --Not looking for specific type
		return foundPs
	else
		for pNum, pName in ipairs(foundPs) do
			if peripheral.getType(foundPs[pNum]) == pType then
				foundType[#foundType + 1] = pName
			end
		end
		return foundType
	end
end

function password(pass)
	print("Enter Password to access controls.")
	t = read("*")
	if t == pass then
		print("Access Granted.")
		sleep(2)
		return true
	else
		print("WRONG!")
		sleep(2)
		return false
	end
end

function choose(t)
	return t[math.random(#t)]
end

local funMessages = {
	--Robot like
	"Greetings, human.",
	"Awaiting input.",
	"Ready for instructions.",
	"Your wish is my command, assuming it is within normal operational parameters.",
	"How can I help you?",
	"'A robot must obey the orders given to it by human beings'",
	"System Status: Fully functional",
	"System Status: Ok",
	"System Status: Unsure, check later",
	"System Status: Missing some startup messages",
	"System Status: N/A",
	"System Status: Redstone error detected",
	"CraftOS [Version number]",
	"No bootable device -- insert boot disk and press any key",
	"The SMART hard disk check has detected an imminent failure. To ensure not data loss, please backup the content immediately and run the Hard Disk Test in System Diagnostics.",
	"F2 - System Diagnostics",
	"ENTER - Continue Startup",
	"Current mode: Safe Mode with Command Prompt",
	"Startup message currently unavailable.",
	"Press 'I' to enter interactive startup.",
	"Done (0.110s)",
	"I/O Buffer error at logical block 6005782",
	"57 fps, 133 Chunk updates",
	"Press any key to continue.",
	"-----BEGIN PGP SIGNED MESSAGE-----",

	--Generic/Random
	"Hello.",
	"0110100001101001",
	"How are you today?",
	"The world time is currently " .. os.time(),
	"WARNING: Loss of some clever startup messages detected!",
	"...!",
	"I've been waiting for you",
	"Behind you!",
	"WARNING: Refrences unlikely to be recognized detected in startup messages.",
	"This is a startup message.",
	"Hoc est satus nuntiante.",
	"Este es un mensaje de inicio.",
	"'12345' is not a secure password.",
	"Ceci n'est pas une startup message!",
	"Cogito ergo sum",
	"Nice to meet you!",
	"We meet again.",
	"3.1415926535",
	math.random(),
	"Press Ctrl+R",
	"You were expecting a message here, wern't you?",
	"2==10",
	"Don't fall!",
	"Can you dig it?",
	"What would you do?",
	"Checkmate.",
	"Where?",
	"Deliquescence is cool!",
	"I'm tired.",

	--Latin
	"Ante meridiem",
	"Post meridiem",
	"In omnia paratus",
	"Corruptissima re publica plurimae leges",
	"Bono malum superate",
	"Barba non facit philosophum",
	"Quidquid Latine dictum sit altum videtur",
	"Quis custodiet ipsos custodes?",

	--References
	"Beam me up, scotty!",
	"WARNING - Missile inbound!",
	"Startup messages over 9000! (Not really)",
	"This is not the startup message you are looking for.",
	"Seeking Admin...",
	"0101000101110101011010010111001100100000011000110111010101110011011101000110111101100100011010010110010101110100001000000110100101110000011100110110111101110011001000000110001101110101011100110111010001101111011001000110010101110011",

	--Harry Potter
	"I will have order.",
	"I must not tell lies",
	"A lonely, winding road at twilight",

	--Song References
	--Beatles
	--
	"Could you read my book?",
	"It took me years!",
	"Could you take a look?",
	"Based on a novel!",
	"I need a job!",
	"I want to be a paperback writer!",
	"He wants to be a paperback writer!",
	"A thousand pages, give or take a few!",
	"I'll be writing more in a week or two!",
	"You can make a million overnight!",

	--
	"Picture yourself in a boat in a river!",
	"Tangerine trees!",
	"Marmalade skies!",
	"You hear someone call you!",
	"Answer quite slowly!",
	"Kaleidoscope eyes!",
	"Yellow and green!",
	"Towering over your head!",
	"Look for the girl!",
	"She's gone!",
	"In the sky!",
	"With diamonds!",
	"A bridge by a fountain!",
	"Rocking horse people!",

	--
	"Desmond has his barrow in the marketplace",
	"Molly is the singer in a band.",
	"I like your face!",
	"Take a trolley to the jewelry store!",
	"Buy a twenty-carat golden ring!",
	"Desmond lets the children lend a hand.",

	--
	"Sitting on a cornflake!",
	"Get a tan from standing in the english rain!",
	"See how they run!",
	"See how they fly!",
	"Like lucy in the sky!",
	"Don't you think the joker laughs at you?",

	--
	"Look at all the people!",
	"Where do they all come from?",
	"Where do they all belong?",
	"In a jar by the door!",
	"Who is it for?",
	"No one will hear!",
	"No one comes near!",
	"Look at him working!",
	"When there's nobody there!",
	"What does he care?",
	"Nobody came!",
	"No one was saved!",

	--
	"Get back!",
	"Where you once belonged!",
	"Thought he was a loner!",
	"He knew it couldn't last",
	"Left his home!",

	--
	"Let me tell you how it will be!",
	"There's one for you, nineteen for me!",
	"I'm the taxman!",
	"Does five percent appear too small?",
	"Be thankful I don't take it all!",
	"I'll tax the street!",
	"I'll tax your seat!",
	"I'll tax the heat!",
	"I'll tax your feet!",
	"Don't ask me what I want it for!",

	--
	"What would you think?",
	"I sang out of tune!",
	"Lend me your ears!",
	"I'll sing you a song!",

	--
	"The man of a thousand voices is talking perfectly loud!",
	"Nobody ever hears him!",
	"He never listens to them!",

	--
	"Here comes old flatop!",
	"He come groovin' up slowly!",

	--
	"It's coming to take you away!",

	--
	"Children at your feet!",

	--
	"Lets all get up and dance to a song!",

	--
	"Don't let me down!",



	--Pink Floyd
	--
	"Come in here!",
	"Dear boy!",
	"Have a cigar!",
	"You're gonna go far!",
	"You're gonna fly high!",
	"You're never gonna die!",
	"You're gonna make it if you try!",
	"They're gonna love you!",
	"I've always had a deep respect!",
	"Most sincerely!",
	"The band is just fantastic!",
	"That is really what I think!",
	"Oh, by the way...",
	"Which ones pink?",
	"The name of the game!",
	"Riding the gravy train!",

	--
	"Is there anybody in there?",
	"Just nod if you can hear me!",
	"Is there anyone home?",
	"Come on, now!",
	"I hear you're feeling down.",
	"I can ease your pain!",
	"On your feet again!",
	"Relax.",
	"I need some information first!",
	"Just the basic facts!",
	"Can you show me where it hurts?",
	"When I was a child!",

	--
	"Wish you were here!",
	"So...",
	"You think you can tell?",
	"Blue skys!",
	"A green field!",
	"A cold steel rail!",
	"Did you exchange?",
	"Two lost souls!",
	"Swimming in a fishbowl!",
	"Year after year!",
	"The same old ground!",
	"What have we found?",

	--
	"Ticking away!",
	"The moments!",
	"A dull day!",
	"Fritter and waste!",
	"The hours!",
	"An offhand way!",
	"Kicking around!",
	"A piece of ground!",
	"Your hometown!",
	"Ten years have gone behind you",
	"No one told you when to run",
	"You missed the starting gun!",
	"You run and you run!",
	"Catch up to the sun!",
	"It's sinking!",
	"The time is gone!",
	"The song is over!",
	"I like to be here when I can",
	"Beside the fire!",

	--
	"Us and them!",
	"We're only ordinary men!",
	"Me and you!",
	"Not what we would choose!",
	"Forward!",
	"The front rank died!",
	"The general sat!",
	"The lines on the map!",
	"From side to side!",
	"Black and blue!",
	"Who knows which is which?",
	"Who is who?",
	"Up and down!",
	"Round and round!",
	"Haven't you heard?",
	"Its a battle of words!",
	"Listen, son!",
	"There's room for you!",
	"Out of my way!",
	"Its a busy day!",
	"I've got things on my mind!",


	--
	"Money!",
	"It's a gas!",
	"Grab that cash!",
	"Make a stash!",
	"New car, caviar!",
	"Think I'll buy me a football team!",
	"So they say!",
	"I need a lear jet!",

	--
	"Welcome, my son!",
	"Welcome to the machine!",
	"Where have you been?",
	"It's alright!",
	"We know where you've been!",
	"You know you're nobody's fool!",

	--
	"Hey you",

	--
	"You! Yes, you!",
	"Stand still laddie!",

	--
	"Run to the bedroom!",
	"The suitcase on the left!",

	--
	"They must have taken my marbles away!",
	"Crazy!",
	"Toys in the attic!",



	--Talking Heads
	--
	"Face up to the facts!",
	"Can't relaz!",
	"Don't touch me!",
	"I'm a live wire!",
	"Qu'est-ce que c'est?",

	--
	"Nothing ever happens!",

	--
	"You can talk just like me!",

	--
	"What a bad picture!",
	"Don't get upset!",
	"It's not a major disaster!",
	"I don't know whats the matter!",
	"I don't know why you bother!",
	"The way it seems to me...",
	"Making up their own shows!",
	"Putting them on TV!",

	--
	"What's the matter with him?",

	--
	"Watch out!",
	"You might get what you're after!",
	"Cool babies!",
	"Strange but not a stranger!",
	"I'm an ordinary guy!",
	"Hold tight!",
	"Heres your ticker, pack your bag!",
	"Fighting fire with fire!",

	--
	"Packed up and ready to go!",
	"A place where nobody knows!",
	"I'm getting used to it now!",
	"This ain't no party!",
	"This ain't no disco!",
	"This ain't no foolin' around!",
	"Transmit the message!",
	"Everything's ready to roll!",

	--
	"Wait a minute!",
	"Everybody!",
	"Get in line!",
	"Nothing can come between us!",
	"Nothing gets you down!",
	"Nothing strikes your fancy!",
	"We have nothing in our pockets!",

	--
	"Let me tell you a story!",
	"Let's go!",

	--
	"I'm dressed up so nice!",
	"I'm doing my best!",
	"I'm starting over!",
	"Starting over in another place!",

	--
	"Home is where I want to be!",
	"I love the passing of time!",
	"Did I find you or you find me?",
	"You got a face with a view!",

	---
	"Letting the days go by!",
	"How do I work this?",
	"Same as it ever was!",

	--
	"I'm gonna have some fun!",

	--
	"Who took the money?",
	"Who took the money away?",
	"Wake up and wonder!",

	--
	"I don't know why you treat me so bad!",

	--
	"Lost my shape!",
	"Trying to act casual!",

	--
	"Hands of a government man!",
	"I'm a tumbler!",

	--
	"I wanna talk!",
	"I wanna talk as much as I want!",
	"It's a hard logic!",

	--
	"Chilly willy!",

	--
	"I need something to change your mind!",

	--
	"I'm wearking fur pajamas!",
	"Speak up!",

	
	
	
	
	
	--David Bowie
	--
	"It's no game!",

	--
	"Scary monsters!",
	"Super creeps!",

	--
	"Fashion!",
	"Beep Beep!",

	--
	"Take your protein pills!",
	"Put your helmet on!",
	"Commencing countdown!",
	"Engines on!",
	"You've really made the grade!",
	"Whose shirts do you wear?",
	"Far above the world!",

	--
	"I'm an alligator!",
	"I'm a moma-papa coming for you!",

	--
	"Hang on to yourself!",

	--
	"I look into your eyes and I know you won't kill me!",
	
	--
	"You remind me of the babe!",
	"What babe?",
	"The babe with the power!",
	"What power?",
	"The power of voodoo!",
	"Who do?",
	"You do!",
	"Do what?",
	"I saw my baby!",
	"Crying hard as babe could cry!",
	"What could I do?",
	"Nobody knew!",
	



	--Jethro Tull
	--
	"Palm tree apartments!",
	"Thats alright by me!",

	--
	"The shuffling madness!",

	--
	"Sitting on the park bench!",
	"Greasy fingers smearing shabby clothes!",
	"Drying in the cold sun!",
	"Feeling like a dead duck!",

	--
	"Really don't mind if you sit this one out!",
	"My words are a whisper!",
	"I may make you feel, but I can't make you think",
	"The youngest of the famliy!",
	"Moving with authority!",
	"Rings upon your fingers!",

	--
	"Nothing is easy!",


	--Elton John
	--
	"Hey, kids!",
	"Share the news together!",
	"Known to change the weather!",
	"Solid walls of sound!",
	"Have you seen them yet?",

	--
	"Can't lock me in your penthouse!",


	--Queen
	--
	"Is this the real life?",
	"Look up to the sky!",

	--
	"I want to ride my bicicle!",
	"Where I like!",

	--
	"Listen to the wise man!",

	--
	"Tonight!",
	"Im gonna have myself a real good time!",

	--
	"Do you feel good?",
	"Are you satisfied?",
	"Is your conscience all right?",
	"Does it plague you at night?",


	--ELO
	--
	"Mr. Blue Sky!",
	"Please tell us why!",
	"You had to hide away!",
	"For so long!",
	"Where did we go wrong!",
	"Hey you with the pretty face!",
	"Welcome to the human race!",

	--
	"She cried to the southern wind!",
	"Headin' for a Showdown!",
	"It's raining!",
	"All over the world!",



	--Black Sabbath
	--
	"What is this?",
	"Figure in black!",

	--
	"Misty morning, clouds in the sky!",

	--
	"Late last night!",
	"You gotta believe me!",



	--Billy Joel
	--
	"It's nine o' clock on a Saturday!",
	"The regular crowd shuffles in!",
	"He's quick with a joke!",


	--Other
	--
	"Kinghts in armor!",
	"Something about a queen!",

	--
	"A modern day warrior!",
	"Mean, mean stride!",
	"Mean, mean pride!",
	"His mind is not for rent!",
	"Don't put him down as arrogant!",

	--
	"I feel free!",

	--
	"You can checkout anytime you like!",
	"You can never leave!",

	--
	"Bird is the word!",

	--
	"The rain exploded with a mighty crash",
	"We fell into the sun!",

	--
	"Writing on the wall!",

	--
	"Could you go along with someone like me?",
	"I did before!"
}

function getFunMessages()
	return funMessages
end

function cleanMonitors(mons)
	for x=1, #mons do
		if peripheral.isPresent(mons[x]) then --dont crash if monitor was removed
			mon=peripheral.wrap(mons[x])
			local old = term.redirect(mon)

			cleanTerm()
			
			term.redirect(old)
		end
	end
end

function monitorsPrint(mons, text)
	for x=1, #mons do
		if peripheral.isPresent(mons[x]) then --dont crash if monitor was removed
			mon=peripheral.wrap(mons[x])
			monitorPrint(mon, text)
		end
	end
end

function monitorPrint(mon, text)
	local old = term.redirect(mon)

	print(text)
	term.redirect(old)
end

function pause()
	print("Press any key to continue.")
	os.pullEvent("key")
end
