<cfcomponent extends="Controller">
	
	<cffunction name="init">
		<cfset filters(through="safetyCatch,strings", only="resetDatabase")>
	</cffunction>
	
	<!--- 
	FILTERS
	--->
	<cffunction name="safetyCatch" access="private">
		<!--- dont allow resetting outside of design mode --->
		<cfif get("environment") neq "design">
			<cfabort showerror="Sorry.. these scripts are only for design mode">
		</cfif>
	</cffunction>
	
	<cffunction name="strings" access="private">
		<cfset loops = 10>
		<cfset alphabet = ListToArray("A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z")>
		<cfset phonetics = ListToArray("Alpha,Bravo,Charlie,Delta,Echo,Foxtrot,Golf,Hotel,India,Juliet,Kilo,Lima,Mike,November,Oscar,Papa,Quebec,Romeo,Sierra,Tango,Uniform,Victor,Whiskey,X-ray,Yankee,Zulu")>
		<cfset animals = ListToArray("Alligator,Badger,Crocodile,Dingo,Elephant,Fox,Giraffe,Hound,Insect,Jaguar,Kenya,Leopard,Marlin,Nail,Octopus,Porcupine,Quail,Rat,Snake,Turtle,Umberella,Viper,Werewolf,Xylophone,Yak,Zebra")>
		<cfset nouns = ListToArray("Apple,Beret,Cantelope,Dragster,Enchilada,Fairy,Guitar,Helicopter,Igloo,Jellybean,Kerosene,Lemon,Missile,Nectarine,Orange,Periscope,Queen,Retina,Stereo,Tram,Uranus,Violet,Wire,Xeon,Yakuza,Zoo")>
		<cfset things = ListToArray("Aura,Brick,Crayfish,Diesel,Empire,Finch,Gringo,Hammer,Iceberg,Jupiter,Kremlin,Loafer,Master,Nylon,Octagon,Propeller,Quack,Rope,Slayer,Triple,Underground,Vegetable,Wagon,Xtra,York,Zipper")>
		<cfset names = ListToArray("Alice,Beau,Cornelius,Daisy,Edward,Felicity,Gordon,Horace,Ita,June,Kerry,Lola,Maxwell,Nancy,Olivia,Percy,Quincy,Randall,Serena,Thomas,Uma,Vera,Willie,Xu,Yobbo,Zultan")>
		<cfset surnames = ListToArray("Adler,Baxter,Childers,D'Maire,Ellis,Frank,Gathwick,Harris,Ismail,Jones,Kelsey,Livingstone,Mattingley,Nelson,O'Rielly,Pavarotti,Quincy,Roberts,Sheen,Tran,Ulvers,Valencia,Williams,Xenophon,Yarra,Zimmerman")>	
		<cfset bands = ListToArray("All Shall Perish,Black Label Society,Cold Chisel,Dead Kennedys,Exhorder,Foo Fighters,Gojira,Huey Lewis & The News,Ice Cube,Jimi Hendrix,Kiss,Lamb of God,Machine Head,Nine Inch Nails,Ozzy Osbourne,Pantera,Queen,Red Hot Chilli Peppers,Sex Pistols,The Beatles,Unearth,Van Halen,Walls of Jericho,Xylophones from Hell,Yellow Submarine,Zakk Wylde")>
		<cfset standardPassword = "password123">
	</cffunction>
	
	<!--- 
	PUBLIC ACTIONS
	 --->

	<cffunction name="resetDatabase">
		
		<cfset var loc = {}>
		<cfset var crlf = Chr(13) & Chr(10)>
		<cfset loc.ret = "">

		<cfsetting requesttimeout="1200">
		<cfset application.wheels.transactionMode = "commit">
		<!--- 
		<cfsetting showdebugoutput="false">
		 --->
		<!--- Note: owners, addresses, contacts and people tables are shared between compass and valkyrie apps --->
		<cfset $truncateTable("actions,agencies,assets,campaigns,changes,clicks,customers,publishers,users")>

		<!--- administrators --->
		<cfset adam = model("User").new(firstname="Adam", lastname="Chapman", position="Developer", phone="0412 460 371", email="adam.p.chapman@gmail.com", password=standardPassword, passwordConfirmation=standardPassword, isadministrator=1)>
		<cfset adam.save()>
		<cfset gaz = model("User").new(firstname="Garry", lastname="Morrow", position="Manager", phone="0402 502 120", email="garry@fullnoise.com.au", password=standardPassword, passwordConfirmation=standardPassword, isadministrator=1)>
		<cfset gaz.save()>

<!--- 		<cfdump var="#adam.allErrors()#" abort="true">
 --->
		<!--- common object properties --->
		<cfset facebookStruct = {name="Facebook" ,website="http://www.facebook.com" ,contactname="John Doe" ,phone="(657) 9856 4543" ,email="joe@facebook.com"}>
		<cfset fullnoiseStruct = {name="Fullnoise" ,website="http://www.fullnoise.com.au" ,contactname="Garry Morrow" ,phone="(03) 9899 7687" ,email="garry@fullnoise.com"}>
		<cfset theageStruct = {name="The Age" ,website="http://www.theage.com.au" ,contactname="Bob Black" ,phone="(03) 9655 9872" ,email="bob@theage.com.au"}>

		<!--- 
			** ZOMBIE **
		 --->
		<!--- agency --->
		<cfset zombie = model("Agency").new(name="Zombie Management", accessLevel=2, streetnumber="666", streetname="Dragula Avenue", suburb="Jacksonville", phone="(02) 9876 4543", email="mail@zombie.com")>
		<cfset zombie.save()>

			<!--- users --->
			<cfloop from="1" to="3" index="i">
				<cfset user[i] = model("User").new(agencyid=zombie.key(), firstname=names[i], lastname=surnames[i], position="Dude", phone="0400 000 000", email="#names[i]#@zombie.com", password=standardPassword, passwordConfirmation=standardPassword)>
				<cfset user[i].save()>
			</cfloop>
			<!--- customers --->
			<cfset honda = model("Customer").new(agencyid=zombie.key(), name="Honda", website="http://www.honda.com.au", phone="(03) 9545 5434", email="mail@honda.com.au", statusid=1, accessLevel=1)>
			<cfset honda.save()>
				<!--- publishers --->
				<cfset facebookProperties = Duplicate(facebookStruct)>
				<cfset facebookProperties.customerid = honda.key()>
				<cfset facebook = model("Publisher").new(properties=facebookProperties)>
				<cfset facebook.save()>
				
				<cfset fullnoiseProperties = Duplicate(fullnoiseStruct)>
				<cfset fullnoiseProperties.customerid = honda.key()>
				<cfset fullnoise = model("Publisher").new(properties=fullnoiseProperties)>
				<cfset fullnoise.save()>
				
				<cfset theageProperties = Duplicate(theageStruct)>
				<cfset theageProperties.customerid = honda.key()>
				<cfset theage = model("Publisher").new(properties=theageProperties)>
				<cfset theage.save()>

				<!--- campaigns --->
				<cfset campaignNewThing = model("Campaign").new(name="Win a New Thing", customerid=honda.key(), creatoruserid=user[1].key())>
				<cfset campaignNewThing.save()>
					<cfset asset = model("Asset").new(campaignid=campaignNewThing.key(), publisherid=facebook.key(), name="FB - Win", destinationurl="http://www.honda.com.au/win-a-new-thing").save()>
					<cfset asset = model("Asset").new(campaignid=campaignNewThing.key(), publisherid=fullnoise.key(), name="Full - Win", destinationurl="http://www.fullnoise.com.au/win-a-new-thing").save()>
					<cfset asset = model("Asset").new(campaignid=campaignNewThing.key(), publisherid=theage.key(), name="Age - Win", destinationurl="http://www.theage.com.au/win-a-new-thing")>
					<cfset asset.save()>

				<cfset campaignCashBack = model("Campaign").new(name="$500 Cash Back", customerid=honda.key(), creatoruserid=user[2].key())>
				<cfset campaignCashBack.save()>
					<cfset asset = model("Asset").new(campaignid=campaignCashBack.key(), publisherid=facebook.key(), name="FB - Cash", destinationurl="http://www.honda.com.au/500-cashback").save()>
					<cfset asset = model("Asset").new(campaignid=campaignCashBack.key(), publisherid=fullnoise.key(), name="Full - Cash", destinationurl="http://www.fullnoise.com.au/500-cashback").save()>
					<cfset asset = model("Asset").new(campaignid=campaignCashBack.key(), publisherid=theage.key(), name="Age - Cash", destinationurl="http://www.theage.com.au/500-cashback").save()>

				<cfset campaignFreeStuff = model("Campaign").new(name="Get Free Stuff", customerid=honda.key(), creatoruserid=user[2].key())>
				<cfset campaignFreeStuff.save()>
					<cfset asset = model("Asset").new(campaignid=campaignFreeStuff.key(), publisherid=facebook.key(), name="FB - Free", destinationurl="http://www.honda.com.au/free-stuff").save()>
					<cfset asset = model("Asset").new(campaignid=campaignFreeStuff.key(), publisherid=fullnoise.key(), name="Full - Free", destinationurl="http://www.fullnoise.com.au/free-stuff").save()>
					<cfset asset = model("Asset").new(campaignid=campaignFreeStuff.key(), publisherid=theage.key(), name="Age - Free", destinationurl="http://www.theage.com.au/free-stuff").save()>


			<cfset yamaha = model("Customer").new(agencyid=zombie.key(), name="Yamaha", website="http://www.yamaha.com.au", phone="(03) 9834 9321", email="mail@yamaha.com.au", statusid=1, accessLevel=1)>
			<cfset yamaha.save()>
				<!--- publishers --->
				<cfset facebookProperties = Duplicate(facebookStruct)>
				<cfset facebookProperties.customerid = yamaha.key()>
				<cfset facebook = model("Publisher").new(properties=facebookProperties)>
				<cfset facebook.save()>
				
				<cfset fullnoiseProperties = Duplicate(fullnoiseStruct)>
				<cfset fullnoiseProperties.customerid = yamaha.key()>
				<cfset fullnoise = model("Publisher").new(properties=fullnoiseProperties)>
				<cfset fullnoise.save()>
				
				<cfset theageProperties = Duplicate(theageStruct)>
				<cfset theageProperties.customerid = yamaha.key()>
				<cfset theage = model("Publisher").new(properties=theageProperties)>
				<cfset theage.save()>

				<!--- campaigns --->
				<cfset campaignNewThing = model("Campaign").new(name="Win a New Thing", customerid=yamaha.key(), creatoruserid=user[1].key())>
				<cfset campaignNewThing.save()>
					<cfset asset = model("Asset").new(campaignid=campaignNewThing.key(), publisherid=facebook.key(), name="FB - Win", destinationurl="http://www.honda.com.au/win-a-new-thing").save()>
					<cfset asset = model("Asset").new(campaignid=campaignNewThing.key(), publisherid=fullnoise.key(), name="Full - Win", destinationurl="http://www.fullnoise.com.au/win-a-new-thing").save()>
					<cfset asset = model("Asset").new(campaignid=campaignNewThing.key(), publisherid=theage.key(), name="Age - Win", destinationurl="http://www.theage.com.au/win-a-new-thing").save()>

				<cfset campaignCashBack = model("Campaign").new(name="$500 Cash Back", customerid=yamaha.key(), creatoruserid=user[2].key())>
				<cfset campaignCashBack.save()>
					<cfset asset = model("Asset").new(campaignid=campaignCashBack.key(), publisherid=facebook.key(), name="FB - Cash", destinationurl="http://www.honda.com.au/500-cashback").save()>
					<cfset asset = model("Asset").new(campaignid=campaignCashBack.key(), publisherid=fullnoise.key(), name="Full - Cash", destinationurl="http://www.fullnoise.com.au/500-cashback").save()>
					<cfset asset = model("Asset").new(campaignid=campaignCashBack.key(), publisherid=theage.key(), name="Age - Cash", destinationurl="http://www.theage.com.au/500-cashback").save()>

				<cfset campaignFreeStuff = model("Campaign").new(name="Get Free Stuff", customerid=yamaha.key(), creatoruserid=user[2].key())>
				<cfset campaignFreeStuff.save()>
					<cfset asset = model("Asset").new(campaignid=campaignFreeStuff.key(), publisherid=facebook.key(), name="FB - Free", destinationurl="http://www.honda.com.au/free-stuff").save()>
					<cfset asset = model("Asset").new(campaignid=campaignFreeStuff.key(), publisherid=fullnoise.key(), name="Full - Free", destinationurl="http://www.fullnoise.com.au/free-stuff").save()>
					<cfset asset = model("Asset").new(campaignid=campaignFreeStuff.key(), publisherid=theage.key(), name="Age - Free", destinationurl="http://www.theage.com.au/free-stuff").save()>


			<cfset kawasaki = model("Customer").new(agencyid=zombie.key(), name="Kawasaki", website="http://www.kawasaki.com.au", phone="(03) 8788 9856", email="mail@kawasaki.com.au", statusid=1, accessLevel=1)>
			<cfset kawasaki.save()>
				<!--- publishers --->
				<cfset facebookProperties = Duplicate(facebookStruct)>
				<cfset facebookProperties.customerid = kawasaki.key()>
				<cfset facebook = model("Publisher").new(properties=facebookProperties)>
				<cfset facebook.save()>
				
				<cfset fullnoiseProperties = Duplicate(fullnoiseStruct)>
				<cfset fullnoiseProperties.customerid = kawasaki.key()>
				<cfset fullnoise = model("Publisher").new(properties=fullnoiseProperties)>
				<cfset fullnoise.save()>
				
				<cfset theageProperties = Duplicate(theageStruct)>
				<cfset theageProperties.customerid = kawasaki.key()>
				<cfset theage = model("Publisher").new(properties=theageProperties)>
				<cfset theage.save()>

				<!--- campaigns --->
				<cfset campaignNewThing = model("Campaign").new(name="Win a New Thing", customerid=kawasaki.key(), creatoruserid=user[1].key())>
				<cfset campaignNewThing.save()>
					<cfset asset = model("Asset").new(campaignid=campaignNewThing.key(), publisherid=facebook.key(), name="FB - Win", destinationurl="http://www.honda.com.au/win-a-new-thing").save()>
					<cfset asset = model("Asset").new(campaignid=campaignNewThing.key(), publisherid=fullnoise.key(), name="Full - Win", destinationurl="http://www.fullnoise.com.au/win-a-new-thing").save()>
					<cfset asset = model("Asset").new(campaignid=campaignNewThing.key(), publisherid=theage.key(), name="Age - Win", destinationurl="http://www.theage.com.au/win-a-new-thing").save()>

				<cfset campaignCashBack = model("Campaign").new(name="$500 Cash Back", customerid=kawasaki.key(), creatoruserid=user[2].key())>
				<cfset campaignCashBack.save()>
					<cfset asset = model("Asset").new(campaignid=campaignCashBack.key(), publisherid=facebook.key(), name="FB - Cash", destinationurl="http://www.honda.com.au/500-cashback").save()>
					<cfset asset = model("Asset").new(campaignid=campaignCashBack.key(), publisherid=fullnoise.key(), name="Full - Cash", destinationurl="http://www.fullnoise.com.au/500-cashback").save()>
					<cfset asset = model("Asset").new(campaignid=campaignCashBack.key(), publisherid=theage.key(), name="Age - Cash", destinationurl="http://www.theage.com.au/500-cashback").save()>

				<cfset campaignFreeStuff = model("Campaign").new(name="Get Free Stuff", customerid=kawasaki.key(), creatoruserid=user[2].key())>
				<cfset campaignFreeStuff.save()>
					<cfset asset = model("Asset").new(campaignid=campaignFreeStuff.key(), publisherid=facebook.key(), name="FB - Free", destinationurl="http://www.honda.com.au/free-stuff").save()>
					<cfset asset = model("Asset").new(campaignid=campaignFreeStuff.key(), publisherid=fullnoise.key(), name="Full - Free", destinationurl="http://www.fullnoise.com.au/free-stuff").save()>
					<cfset asset = model("Asset").new(campaignid=campaignFreeStuff.key(), publisherid=theage.key(), name="Age - Free", destinationurl="http://www.theage.com.au/free-stuff").save()>



		<!--- 
			** MR BURNS **
		 --->
		<cfset burns = model("Agency").new(name="Mr. Burns & Co", streetnumber="10", streetname="Plant Road", suburb="Springfield", phone="(088) 555 4543", email="burnsy@nuclearplant.com")>
		<cfset burns.save()>

		<!--- users --->
			<cfloop from="1" to="3" index="i">
				<cfset user[i] = model("User").new(agencyid=burns.key(), firstname=names[i+3], lastname=surnames[i+3], position="Dude", phone="0400 000 000", email="#names[i+3]#@nuclearplant.com", password=standardPassword, passwordConfirmation=standardPassword)>
				<cfset user[i].save()>
			</cfloop>
			<!--- customers --->
			<cfset honda = model("Customer").new(agencyid=burns.key(), name="Honda", website="http://www.honda.com.au", phone="(03) 9545 5434", email="mail@honda.com.au", statusid=1, accessLevel=1)>
			<cfset honda.save()>
				<!--- publishers --->
				<cfset facebookProperties = Duplicate(facebookStruct)>
				<cfset facebookProperties.customerid = honda.key()>
				<cfset facebook = model("Publisher").new(properties=facebookProperties)>
				<cfset facebook.save()>
				
				<cfset fullnoiseProperties = Duplicate(fullnoiseStruct)>
				<cfset fullnoiseProperties.customerid = honda.key()>
				<cfset fullnoise = model("Publisher").new(properties=fullnoiseProperties)>
				<cfset fullnoise.save()>
				
				<cfset theageProperties = Duplicate(theageStruct)>
				<cfset theageProperties.customerid = honda.key()>
				<cfset theage = model("Publisher").new(properties=theageProperties)>
				<cfset theage.save()>

				<!--- campaigns --->
				<cfset campaignNewThing = model("Campaign").new(name="Win a New Thing", campaignid=honda.key(), creatoruserid=user[1].key())>
				<cfset campaignNewThing.save()>
					<cfset asset = model("Asset").new(campaignid=campaignNewThing.key(), publisherid=facebook.key(), name="FB - Win", destinationurl="http://www.honda.com.au/win-a-new-thing").save()>
					<cfset asset = model("Asset").new(campaignid=campaignNewThing.key(), publisherid=fullnoise.key(), name="Full - Win", destinationurl="http://www.fullnoise.com.au/win-a-new-thing").save()>
					<cfset asset = model("Asset").new(campaignid=campaignNewThing.key(), publisherid=theage.key(), name="Age - Win", destinationurl="http://www.theage.com.au/win-a-new-thing").save()>

				<cfset campaignCashBack = model("Campaign").new(name="$500 Cash Back", campaignid=honda.key(), creatoruserid=user[2].key())>
				<cfset campaignCashBack.save()>
					<cfset asset = model("Asset").new(campaignid=campaignCashBack.key(), publisherid=facebook.key(), name="FB - Cash", destinationurl="http://www.honda.com.au/500-cashback").save()>
					<cfset asset = model("Asset").new(campaignid=campaignCashBack.key(), publisherid=fullnoise.key(), name="Full - Cash", destinationurl="http://www.fullnoise.com.au/500-cashback").save()>
					<cfset asset = model("Asset").new(campaignid=campaignCashBack.key(), publisherid=theage.key(), name="Age - Cash", destinationurl="http://www.theage.com.au/500-cashback").save()>

				<cfset campaignFreeStuff = model("Campaign").new(name="Get Free Stuff", campaignid=honda.key(), creatoruserid=user[2].key())>
				<cfset campaignFreeStuff.save()>
					<cfset asset = model("Asset").new(campaignid=campaignFreeStuff.key(), publisherid=facebook.key(), name="FB - Free", destinationurl="http://www.honda.com.au/free-stuff").save()>
					<cfset asset = model("Asset").new(campaignid=campaignFreeStuff.key(), publisherid=fullnoise.key(), name="Full - Free", destinationurl="http://www.fullnoise.com.au/free-stuff").save()>
					<cfset asset = model("Asset").new(campaignid=campaignFreeStuff.key(), publisherid=theage.key(), name="Age - Free", destinationurl="http://www.theage.com.au/free-stuff").save()>


			<cfset yamaha = model("Customer").new(agencyid=burns.key(), name="Yamaha", website="http://www.yamaha.com.au", phone="(03) 9834 9321", email="mail@yamaha.com.au", statusid=1, accessLevel=1)>
			<cfset yamaha.save()>
				<!--- publishers --->
				<cfset facebookProperties = Duplicate(facebookStruct)>
				<cfset facebookProperties.customerid = yamaha.key()>
				<cfset facebook = model("Publisher").new(properties=facebookProperties)>
				<cfset facebook.save()>
				
				<cfset fullnoiseProperties = Duplicate(fullnoiseStruct)>
				<cfset fullnoiseProperties.customerid = yamaha.key()>
				<cfset fullnoise = model("Publisher").new(properties=fullnoiseProperties)>
				<cfset fullnoise.save()>
				
				<cfset theageProperties = Duplicate(theageStruct)>
				<cfset theageProperties.customerid = yamaha.key()>
				<cfset theage = model("Publisher").new(properties=theageProperties)>
				<cfset theage.save()>

				<!--- campaigns --->
				<cfset campaignNewThing = model("Campaign").new(name="Win a New Thing", campaignid=yamaha.key(), creatoruserid=user[1].key())>
				<cfset campaignNewThing.save()>
					<cfset asset = model("Asset").new(campaignid=campaignNewThing.key(), publisherid=facebook.key(), name="FB - Win", destinationurl="http://www.honda.com.au/win-a-new-thing").save()>
					<cfset asset = model("Asset").new(campaignid=campaignNewThing.key(), publisherid=fullnoise.key(), name="Full - Win", destinationurl="http://www.fullnoise.com.au/win-a-new-thing").save()>
					<cfset asset = model("Asset").new(campaignid=campaignNewThing.key(), publisherid=theage.key(), name="Age - Win", destinationurl="http://www.theage.com.au/win-a-new-thing").save()>

				<cfset campaignCashBack = model("Campaign").new(name="$500 Cash Back", campaignid=yamaha.key(), creatoruserid=user[2].key())>
				<cfset campaignCashBack.save()>
					<cfset asset = model("Asset").new(campaignid=campaignCashBack.key(), publisherid=facebook.key(), name="FB - Cash", destinationurl="http://www.honda.com.au/500-cashback").save()>
					<cfset asset = model("Asset").new(campaignid=campaignCashBack.key(), publisherid=fullnoise.key(), name="Full - Cash", destinationurl="http://www.fullnoise.com.au/500-cashback").save()>
					<cfset asset = model("Asset").new(campaignid=campaignCashBack.key(), publisherid=theage.key(), name="Age - Cash", destinationurl="http://www.theage.com.au/500-cashback").save()>

				<cfset campaignFreeStuff = model("Campaign").new(name="Get Free Stuff", campaignid=yamaha.key(), creatoruserid=user[2].key())>
				<cfset campaignFreeStuff.save()>
					<cfset asset = model("Asset").new(campaignid=campaignFreeStuff.key(), publisherid=facebook.key(), name="FB - Free", destinationurl="http://www.honda.com.au/free-stuff").save()>
					<cfset asset = model("Asset").new(campaignid=campaignFreeStuff.key(), publisherid=fullnoise.key(), name="Full - Free", destinationurl="http://www.fullnoise.com.au/free-stuff").save()>
					<cfset asset = model("Asset").new(campaignid=campaignFreeStuff.key(), publisherid=theage.key(), name="Age - Free", destinationurl="http://www.theage.com.au/free-stuff").save()>


			<cfset kawasaki = model("Customer").new(agencyid=burns.key(), name="Kawasaki", website="http://www.kawasaki.com.au", phone="(03) 8788 9856", email="mail@kawasaki.com.au", statusid=1, accessLevel=1)>
			<cfset kawasaki.save()>
				<!--- publishers --->
				<cfset facebookProperties = Duplicate(facebookStruct)>
				<cfset facebookProperties.customerid = kawasaki.key()>
				<cfset facebook = model("Publisher").new(properties=facebookProperties)>
				<cfset facebook.save()>
				
				<cfset fullnoiseProperties = Duplicate(fullnoiseStruct)>
				<cfset fullnoiseProperties.customerid = kawasaki.key()>
				<cfset fullnoise = model("Publisher").new(properties=fullnoiseProperties)>
				<cfset fullnoise.save()>
				
				<cfset theageProperties = Duplicate(theageStruct)>
				<cfset theageProperties.customerid = kawasaki.key()>
				<cfset theage = model("Publisher").new(properties=theageProperties)>
				<cfset theage.save()>

				<!--- campaigns --->
				<cfset campaignNewThing = model("Campaign").new(name="Win a New Thing", campaignid=kawasaki.key(), creatoruserid=user[1].key())>
				<cfset campaignNewThing.save()>
					<cfset asset = model("Asset").new(campaignid=campaignNewThing.key(), publisherid=facebook.key(), name="FB - Win", destinationurl="http://www.honda.com.au/win-a-new-thing").save()>
					<cfset asset = model("Asset").new(campaignid=campaignNewThing.key(), publisherid=fullnoise.key(), name="Full - Win", destinationurl="http://www.fullnoise.com.au/win-a-new-thing").save()>
					<cfset asset = model("Asset").new(campaignid=campaignNewThing.key(), publisherid=theage.key(), name="Age - Win", destinationurl="http://www.theage.com.au/win-a-new-thing").save()>

				<cfset campaignCashBack = model("Campaign").new(name="$500 Cash Back", campaignid=kawasaki.key(), creatoruserid=user[2].key())>
				<cfset campaignCashBack.save()>
					<cfset asset = model("Asset").new(campaignid=campaignCashBack.key(), publisherid=facebook.key(), name="FB - Cash", destinationurl="http://www.honda.com.au/500-cashback").save()>
					<cfset asset = model("Asset").new(campaignid=campaignCashBack.key(), publisherid=fullnoise.key(), name="Full - Cash", destinationurl="http://www.fullnoise.com.au/500-cashback").save()>
					<cfset asset = model("Asset").new(campaignid=campaignCashBack.key(), publisherid=theage.key(), name="Age - Cash", destinationurl="http://www.theage.com.au/500-cashback").save()>

				<cfset campaignFreeStuff = model("Campaign").new(name="Get Free Stuff", campaignid=kawasaki.key(), creatoruserid=user[2].key())>
				<cfset campaignFreeStuff.save()>
					<cfset asset = model("Asset").new(campaignid=campaignFreeStuff.key(), publisherid=facebook.key(), name="FB - Free", destinationurl="http://www.honda.com.au/free-stuff").save()>
					<cfset asset = model("Asset").new(campaignid=campaignFreeStuff.key(), publisherid=fullnoise.key(), name="Full - Free", destinationurl="http://www.fullnoise.com.au/free-stuff").save()>
					<cfset asset = model("Asset").new(campaignid=campaignFreeStuff.key(), publisherid=theage.key(), name="Age - Free", destinationurl="http://www.theage.com.au/free-stuff").save()>


		<!--- 
			** SIX **
		 --->
		<cfset six = model("Agency").new(name="Six String Things", streetnumber="Level 3, 6", streetname="Fender Drive", suburb="Nashville", phone="(001) 554 4543", email="six@six.com")>
		<cfset six.save()>

		<!--- users --->
			<cfloop from="1" to="3" index="i">
				<cfset user[i] = model("User").new(agencyid=six.key(), firstname=names[i+6], lastname=surnames[i+6], position="Dude", phone="0400 000 000", email="#names[i]#@six.com", password=standardPassword, passwordConfirmation=standardPassword)>
				<cfset user[i].save()>
			</cfloop>
			<!--- customers --->
			<cfset honda = model("Customer").new(agencyid=six.key(), name="Honda", website="http://www.honda.com.au", phone="(03) 9545 5434", email="mail@honda.com.au", statusid=1, accessLevel=1)>
			<cfset honda.save()>
				<!--- publishers --->
				<cfset facebookProperties = Duplicate(facebookStruct)>
				<cfset facebookProperties.customerid = honda.key()>
				<cfset facebook = model("Publisher").new(properties=facebookProperties)>
				<cfset facebook.save()>
				
				<cfset fullnoiseProperties = Duplicate(fullnoiseStruct)>
				<cfset fullnoiseProperties.customerid = honda.key()>
				<cfset fullnoise = model("Publisher").new(properties=fullnoiseProperties)>
				<cfset fullnoise.save()>
				
				<cfset theageProperties = Duplicate(theageStruct)>
				<cfset theageProperties.customerid = honda.key()>
				<cfset theage = model("Publisher").new(properties=theageProperties)>
				<cfset theage.save()>

				<!--- campaigns --->
				<cfset campaignNewThing = model("Campaign").new(name="Win a New Thing", campaignid=honda.key(), creatoruserid=user[1].key())>
				<cfset campaignNewThing.save()>
					<cfset asset = model("Asset").new(campaignid=campaignNewThing.key(), publisherid=facebook.key(), name="FB - Win", destinationurl="http://www.honda.com.au/win-a-new-thing").save()>
					<cfset asset = model("Asset").new(campaignid=campaignNewThing.key(), publisherid=fullnoise.key(), name="Full - Win", destinationurl="http://www.fullnoise.com.au/win-a-new-thing").save()>
					<cfset asset = model("Asset").new(campaignid=campaignNewThing.key(), publisherid=theage.key(), name="Age - Win", destinationurl="http://www.theage.com.au/win-a-new-thing").save()>

				<cfset campaignCashBack = model("Campaign").new(name="$500 Cash Back", campaignid=honda.key(), creatoruserid=user[2].key())>
				<cfset campaignCashBack.save()>
					<cfset asset = model("Asset").new(campaignid=campaignCashBack.key(), publisherid=facebook.key(), name="FB - Cash", destinationurl="http://www.honda.com.au/500-cashback").save()>
					<cfset asset = model("Asset").new(campaignid=campaignCashBack.key(), publisherid=fullnoise.key(), name="Full - Cash", destinationurl="http://www.fullnoise.com.au/500-cashback").save()>
					<cfset asset = model("Asset").new(campaignid=campaignCashBack.key(), publisherid=theage.key(), name="Age - Cash", destinationurl="http://www.theage.com.au/500-cashback").save()>

				<cfset campaignFreeStuff = model("Campaign").new(name="Get Free Stuff", campaignid=honda.key(), creatoruserid=user[2].key())>
				<cfset campaignFreeStuff.save()>
					<cfset asset = model("Asset").new(campaignid=campaignFreeStuff.key(), publisherid=facebook.key(), name="FB - Free", destinationurl="http://www.honda.com.au/free-stuff").save()>
					<cfset asset = model("Asset").new(campaignid=campaignFreeStuff.key(), publisherid=fullnoise.key(), name="Full - Free", destinationurl="http://www.fullnoise.com.au/free-stuff").save()>
					<cfset asset = model("Asset").new(campaignid=campaignFreeStuff.key(), publisherid=theage.key(), name="Age - Free", destinationurl="http://www.theage.com.au/free-stuff").save()>


			<cfset yamaha = model("Customer").new(agencyid=six.key(), name="Yamaha", website="http://www.yamaha.com.au", phone="(03) 9834 9321", email="mail@yamaha.com.au", statusid=1, accessLevel=1)>
			<cfset yamaha.save()>
				<!--- publishers --->
				<cfset facebookProperties = Duplicate(facebookStruct)>
				<cfset facebookProperties.customerid = yamaha.key()>
				<cfset facebook = model("Publisher").new(properties=facebookProperties)>
				<cfset facebook.save()>
				
				<cfset fullnoiseProperties = Duplicate(fullnoiseStruct)>
				<cfset fullnoiseProperties.customerid = yamaha.key()>
				<cfset fullnoise = model("Publisher").new(properties=fullnoiseProperties)>
				<cfset fullnoise.save()>
				
				<cfset theageProperties = Duplicate(theageStruct)>
				<cfset theageProperties.customerid = yamaha.key()>
				<cfset theage = model("Publisher").new(properties=theageProperties)>
				<cfset theage.save()>

				<!--- campaigns --->
				<cfset campaignNewThing = model("Campaign").new(name="Win a New Thing", campaignid=yamaha.key(), creatoruserid=user[1].key())>
				<cfset campaignNewThing.save()>
					<cfset asset = model("Asset").new(campaignid=campaignNewThing.key(), publisherid=facebook.key(), name="FB - Win", destinationurl="http://www.honda.com.au/win-a-new-thing").save()>
					<cfset asset = model("Asset").new(campaignid=campaignNewThing.key(), publisherid=fullnoise.key(), name="Full - Win", destinationurl="http://www.fullnoise.com.au/win-a-new-thing").save()>
					<cfset asset = model("Asset").new(campaignid=campaignNewThing.key(), publisherid=theage.key(), name="Age - Win", destinationurl="http://www.theage.com.au/win-a-new-thing").save()>

				<cfset campaignCashBack = model("Campaign").new(name="$500 Cash Back", campaignid=yamaha.key(), creatoruserid=user[2].key())>
				<cfset campaignCashBack.save()>
					<cfset asset = model("Asset").new(campaignid=campaignCashBack.key(), publisherid=facebook.key(), name="FB - Cash", destinationurl="http://www.honda.com.au/500-cashback").save()>
					<cfset asset = model("Asset").new(campaignid=campaignCashBack.key(), publisherid=fullnoise.key(), name="Full - Cash", destinationurl="http://www.fullnoise.com.au/500-cashback").save()>
					<cfset asset = model("Asset").new(campaignid=campaignCashBack.key(), publisherid=theage.key(), name="Age - Cash", destinationurl="http://www.theage.com.au/500-cashback").save()>

				<cfset campaignFreeStuff = model("Campaign").new(name="Get Free Stuff", campaignid=yamaha.key(), creatoruserid=user[2].key())>
				<cfset campaignFreeStuff.save()>
					<cfset asset = model("Asset").new(campaignid=campaignFreeStuff.key(), publisherid=facebook.key(), name="FB - Free", destinationurl="http://www.honda.com.au/free-stuff").save()>
					<cfset asset = model("Asset").new(campaignid=campaignFreeStuff.key(), publisherid=fullnoise.key(), name="Full - Free", destinationurl="http://www.fullnoise.com.au/free-stuff").save()>
					<cfset asset = model("Asset").new(campaignid=campaignFreeStuff.key(), publisherid=theage.key(), name="Age - Free", destinationurl="http://www.theage.com.au/free-stuff").save()>


			<cfset kawasaki = model("Customer").new(agencyid=six.key(), name="Kawasaki", website="http://www.kawasaki.com.au", phone="(03) 8788 9856", email="mail@kawasaki.com.au", statusid=1, accessLevel=1)>
			<cfset kawasaki.save()>
				<!--- publishers --->
				<cfset facebookProperties = Duplicate(facebookStruct)>
				<cfset facebookProperties.customerid = kawasaki.key()>
				<cfset facebook = model("Publisher").new(properties=facebookProperties)>
				<cfset facebook.save()>
				
				<cfset fullnoiseProperties = Duplicate(fullnoiseStruct)>
				<cfset fullnoiseProperties.customerid = kawasaki.key()>
				<cfset fullnoise = model("Publisher").new(properties=fullnoiseProperties)>
				<cfset fullnoise.save()>
				
				<cfset theageProperties = Duplicate(theageStruct)>
				<cfset theageProperties.customerid = kawasaki.key()>
				<cfset theage = model("Publisher").new(properties=theageProperties)>
				<cfset theage.save()>

				<!--- campaigns --->
				<cfset campaignNewThing = model("Campaign").new(name="Win a New Thing", campaignid=kawasaki.key(), creatoruserid=user[1].key())>
				<cfset campaignNewThing.save()>
					<cfset asset = model("Asset").new(campaignid=campaignNewThing.key(), publisherid=facebook.key(), name="FB - Win", destinationurl="http://www.honda.com.au/win-a-new-thing").save()>
					<cfset asset = model("Asset").new(campaignid=campaignNewThing.key(), publisherid=fullnoise.key(), name="Full - Win", destinationurl="http://www.fullnoise.com.au/win-a-new-thing").save()>
					<cfset asset = model("Asset").new(campaignid=campaignNewThing.key(), publisherid=theage.key(), name="Age - Win", destinationurl="http://www.theage.com.au/win-a-new-thing").save()>

				<cfset campaignCashBack = model("Campaign").new(name="$500 Cash Back", campaignid=kawasaki.key(), creatoruserid=user[2].key())>
				<cfset campaignCashBack.save()>
					<cfset asset = model("Asset").new(campaignid=campaignCashBack.key(), publisherid=facebook.key(), name="FB - Cash", destinationurl="http://www.honda.com.au/500-cashback").save()>
					<cfset asset = model("Asset").new(campaignid=campaignCashBack.key(), publisherid=fullnoise.key(), name="Full - Cash", destinationurl="http://www.fullnoise.com.au/500-cashback").save()>
					<cfset asset = model("Asset").new(campaignid=campaignCashBack.key(), publisherid=theage.key(), name="Age - Cash", destinationurl="http://www.theage.com.au/500-cashback").save()>

				<cfset campaignFreeStuff = model("Campaign").new(name="Get Free Stuff", campaignid=kawasaki.key(), creatoruserid=user[2].key())>
				<cfset campaignFreeStuff.save()>
					<cfset asset = model("Asset").new(campaignid=campaignFreeStuff.key(), publisherid=facebook.key(), name="FB - Free", destinationurl="http://www.honda.com.au/free-stuff").save()>
					<cfset asset = model("Asset").new(campaignid=campaignFreeStuff.key(), publisherid=fullnoise.key(), name="Full - Free", destinationurl="http://www.fullnoise.com.au/free-stuff").save()>
					<cfset asset = model("Asset").new(campaignid=campaignFreeStuff.key(), publisherid=theage.key(), name="Age - Free", destinationurl="http://www.theage.com.au/free-stuff").save()>


		<!--- more agencies..  --->
		<cfloop from="4" to="10" index="i">
			<cfset agency = model("Agency").new(name="#names[i]# #alphabet[i]#. #phonetics[i]# Advertising", streetnumber=i * 6, streetname="#surnames[i]# Drive", suburb="#animals[i]# Flats", phone="(00#i#) 55#i# 4543", email="#names[i]#@hotmail.com")>
			<cfset agency.save()>
			<cfset model("User").new(agencyid=agency.key(), firstname=names[i+10], lastname=surnames[i+10], position="Dude", phone="0400 000 000", email="#names[i+10]#@hotmail.com", password=standardPassword, passwordConfirmation=standardPassword).save()>
		</cfloop>

		<cfif cgi.HTTP_REFERER IS "">
			<cfset renderText(linkTo(route="admin"))>
		<cfelse>
			<cfset flashInsert(message="The database was reset", messageType="success")>
			<cfset redirectTo(back=true)>
		</cfif>

	</cffunction>

	<cffunction name="$truncateTable" access="private">
		<cfargument name="table" type="string" required="true">
		<cfset var loc = {} />
		<cfset loc.return = true>
		<cfloop list="#arguments.table#" index="loc.i">
			<cftry>
			<cfquery name="truncate_compass_cms_tables" datasource="#get('dataSourceName')#">TRUNCATE TABLE #loc.i#;</cfquery>
				<cfcatch type="database">
					<cfset loc.return = false>
				</cfcatch>
			</cftry>
		</cfloop>
		<cfreturn loc.return>
	</cffunction>
	
</cfcomponent>
