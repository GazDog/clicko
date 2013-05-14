<cfcomponent extends="Controller">
	
	<cffunction name="init">
		<cfset filters(through="safetyCatch,strings", only="reset")>
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

	<cffunction name="reset">
		
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
		<cfset adam = model("User").new(firstname="Adam", lastname="Chapman", position="Developer", email="adam.p.chapman@gmail.com", password=standardPassword, passwordConfirmation=standardPassword, isadministrator=1)>
		<cfset adam.save()>
		<cfset gaz = model("User").new(firstname="Garry", lastname="Morrow", position="Manager", email="garry@fullnoise.com.au", password=standardPassword, passwordConfirmation=standardPassword, isadministrator=1)>
		<cfset gaz.save()>

		<cfdump var="#adam.allErrors()#">

		<!--- common object properties --->
		<cfset facebookStruct = {name="Facebook" ,website="www.facebook.com" ,contactname="John Doe" ,phone="(657) 9856 4543" ,email="joe@facebook.com"}>
		<cfset fullnoiseStruct = {name="Fullnoise" ,website="www.fullnoise.com.au" ,contactname="Garry Morrow" ,phone="(03) 9899 7687" ,email="garry@fullnoise.com"}>
		<cfset theageStruct = {name="The Age" ,website="www.theage.com.au" ,contactname="Bob Black" ,phone="(03) 9655 9872" ,email="bob@theage.com.au"}>

		<!--- 
			** ZOMBIE **
		 --->
		<!--- agency --->
		<cfset zombie = model("Agency").new(name="Zombie Management", streetnumber="666", streetname="Dragula Avenue", suburb="Jacksonville", phone="(02) 9876 4543", email="mail@zombie.com")>
		<cfset zombie.save()>

			<!--- users --->
			<cfloop from="1" to="3" index="i">
				<cfset user[i] = model("User").new(agencyid=zombie.key(), firstname=names[i], lastname=surnames[i], position="Dude", email="#names[i]#@zombie.com", password=standardPassword, passwordConfirmation=standardPassword)>
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
				<cfset campaignNewThing = model("Campaign").new(name="Win a New Thing", creatoruserid=user[1].key())>
				<cfset campaignNewThing.save()>
					<cfset model("Asset").new(campaignid=campaignNewThing.key(), publisherid=facebook.key(), name="FB - Win", destinationurl="www.honda.com.au/win-a-new-thing").save()>
					<cfset model("Asset").new(campaignid=campaignNewThing.key(), publisherid=fullnoise.key(), name="Full - Win", destinationurl="www.fullnoise.com.au/win-a-new-thing").save()>
					<cfset model("Asset").new(campaignid=campaignNewThing.key(), publisherid=theage.key(), name="Age - Win", destinationurl="www.theage.com.au/win-a-new-thing").save()>

				<cfset campaignCashBack = model("Campaign").new(name="$500 Cash Back", creatoruserid=user[2].key())>
				<cfset campaignCashBack.save()>
					<cfset model("Asset").new(campaignid=campaignCashBack.key(), publisherid=facebook.key(), name="FB - Cash", destinationurl="www.honda.com.au/500-cashback").save()>
					<cfset model("Asset").new(campaignid=campaignCashBack.key(), publisherid=fullnoise.key(), name="Full - Cash", destinationurl="www.fullnoise.com.au/500-cashback").save()>
					<cfset model("Asset").new(campaignid=campaignCashBack.key(), publisherid=theage.key(), name="Age - Cash", destinationurl="www.theage.com.au/500-cashback").save()>

				<cfset campaignFreeStuff = model("Campaign").new(name="Get Free Stuff", creatoruserid=user[2].key())>
				<cfset campaignFreeStuff.save()>
					<cfset model("Asset").new(campaignid=campaignFreeStuff.key(), publisherid=facebook.key(), name="FB - Free", destinationurl="www.honda.com.au/free-stuff").save()>
					<cfset model("Asset").new(campaignid=campaignFreeStuff.key(), publisherid=fullnoise.key(), name="Full - Free", destinationurl="www.fullnoise.com.au/free-stuff").save()>
					<cfset model("Asset").new(campaignid=campaignFreeStuff.key(), publisherid=theage.key(), name="Age - Free", destinationurl="www.theage.com.au/free-stuff").save()>


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


		<!--- assets --->


		<!--- 
			** MR BURNS **
		 --->
		<cfset burns = model("Agency").new(name="Mr. Burns & Co", streetnumber="10", streetname="Plant Road", suburb="Springfield", phone="(088) 555 4543", email="burnsy@nuclearplant.com").save()>
		

		<!--- 
			** SIX **
		 --->
		<cfset six = model("Agency").new(name="Six String Things", streetnumber="Level 3, 6", streetname="Fender Drive", suburb="Nashville", phone="(001) 554 4543", email="six@six.com").save()>


		<cfabort>

		<!--- system scheduled tasks --->
		<cfset model("AutomatedTask").create(name="Get owners @ PortPlus", controller="PortplusAPIProxy", action="getOwners", params="apiid=1", intervalMinutes=10, startat=0, finishat=0)>
		<cfset model("AutomatedTask").create(name="Get buyers @ PortPlus", controller="PortplusAPIProxy", action="getBuyers", params="apiid=1&type=buyer", intervalMinutes=2, startat=0, finishat=0)>
		<cfset model("AutomatedTask").create(name="Get tenants @ PortPlus", controller="PortplusAPIProxy", action="getTenants", params="apiid=1&type=tenant", intervalMinutes=2, startat=0, finishat=0)>
		<cfset model("AutomatedTask").create(name="Get sold listings @ PortPlus", controller="PortplusAPIProxy", action="getSold", params="apiid=1&type=sold", intervalMinutes=2, startat=0, finishat=0)>
		<cfset model("AutomatedTask").create(name="Get leased listings @ PortPlus", controller="PortplusAPIProxy", action="getLeased", params="apiid=1&type=leased", intervalMinutes=2, startat=0, finishat=0)>

		<!--- create some system categories --->
		<cfset model("Category").create(entitytypeid=10, name="Something to do")>
		<cfset model("Category").create(entitytypeid=10, name="Someone to call")>
		<cfset model("Category").create(entitytypeid=10, name="Something else")>

		<!--- create some administrator tasks --->
		<cfset admins = model("Administrator").findAll(where="lastname != 'Admin'")>
		<cfloop query="admins">
			<cfloop from="1" to="26" index="t">
				<cfset model("Task").create(administratorid=admins.id, taskdate=DateAdd("h", t*10, Now()), reminderDate=DateAdd("h", (t*10)-1, Now()), subject="Find a #nouns[t]#", body="#nouns[t]#s are really handy to have.")>
				<cfset model("Task").create(administratorid=admins.id, taskdate=DateAdd("h", t*11, Now()), reminderDate=DateAdd("h", (t*11)-1, Now()), subject="Catch up with #names[t]#", body="Find out about #nouns[t]#s")>
				<cfset model("Task").create(administratorid=admins.id, taskdate=DateAdd("h", t*15, Now()), reminderDate=DateAdd("h", (t*15)-1, Now()), subject="Buy tickets to #bands[t]# concert", body="I think we should see the #DateFormat(Now(), "dddd")# show")>
			</cfloop>
		</cfloop>

		<!--- force/insert an error/s --->
		<cftry>
			<cfset _void = i_am_null>
			<cfcatch type="any">
				<cfset model("Error").create(
					server=get("environment"),
					domain=cgi.server_name,
					remoteip=cgi.remote_addr,
					filepath=getCurrentTemplatePath(),
					controller=params.controller,
					action=params.action,
					scriptname=cgi.script_name,
					querystring=cgi.query_string,
					diagnostics=cfcatch.message,
					rawtrace=cfcatch.TagContext[1].raw_trace,
					browser=cgi.http_user_agent,
					referrer=cgi.http_referer,
					post=isPost()
				)>
			</cfcatch>
		</cftry>

		<cfset createCoreSite() />
		<cfset createCorePropertySite()>

		<!--- create system introductions --->
		<cfset model("Introduction").create(
			entitytypeid=4
			,statustypeid=0
			,body="Hello {customer-firstname}, I am {administrator-firstname} from {owner-tradingname} VS.. This is the system introduction.. See the standard text?! Would you like us to take care of your utilities."
		)>
		<cfset model("Introduction").create(
			entitytypeid=9
			,statustypeid=0
			,body="Hello {customer-firstname}! I'm {administrator-firstname} from {owner-tradingname} VS Would you care to answer a few quick questions regarding our service?"
		)>

		<!--- owners --->
		<cfloop from="1" to="#loops#" index="i">
			
			<cfset owner = model("Owner").new(
					name="#surnames[i]# Pty Ltd"
					,tradingname="#surnames[i]# Real Estate"
					,phone="0987 65#NumberFormat(i,00)#"
					,email="mail@#LCase(surnames[i])#.com"
					,website="www.#LCase(surnames[i])#.com"
					,statustypeid=0
					)>

			<cfif i eq 2>
				<!--- make this a franchisor --->
				<cfset owner.isfranchisor = 1>
				<cfset owner.tradingname="Worldwide Franchise">
				<cfset owner.name="Worldwide Franchise Pty Ltd">
				<cfset owner.email="mail@wwfranchise.com">
				<cfset owner.website="www.wwfranchise.com">
			<cfelseif ListFind("3,4,5",i) gt 0>
				<!--- make these a franchisees --->
				<cfset owner.franchiseid = franchiseid>
				<cfset owner.tradingname="Worldwide Franchise #surnames_b[i]#">
				<cfset owner.name="Worldwide Franchise #surnames_b[i]# Pty Ltd">
				<cfset owner.email="#LCase(surnames_b[i])#@wwfranchise.com">
				<cfset owner.website="#LCase(surnames_b[i])#.wwfranchise.com">
			</cfif>

			<cfset owner.save()>

			<cfset addresses = [
				model("address").create(
					ownerid=owner.key()
					,addresstypeid=1
					,entitytypeid=get("entityTypeStruct").owner
					,streetnumber=i
					,streetname='#phonetics[i]# Street'
					,town="#nouns[i]#ville"
					,postcode=3000-i
					,state="VIC"
					,country="Australia"
					)
				,model("address").create(
					ownerid=owner.key()
					,addresstypeid=2
					,entitytypeid=get("entityTypeStruct").owner
					,streetnumber=i
					,streetname='#surnames[i]# Street'
					,town="#things[i]#town"
					,postcode=2000-i
					,state="VIC"
					,country="Australia"
					)
			]>
			<cfset people = [
				model("person").create(ownerid=owner.key(), entitytypeid=get("entityTypeStruct").owner, firstname="#names_b[1]#", lastname="#nouns[$complementary(i)]#")
				,model("person").create(ownerid=owner.key(), entitytypeid=get("entityTypeStruct").owner, firstname="#names_b[2]#", lastname="#nouns[$complementary(i)]#")
			]>
			<cfset apiOwner = [
					model("apiOwner").create(ownerid=owner.key(), apiid=1, apientityid=0)
			]>
			<cfset administratorOwner = [
					model("AdministratorOwner").create(ownerid=owner.key(), administratorid=i mod 2 eq 0 ? 1 : 2)
			]>


			<!--- insert custom introductions for every 2nd owner --->
			<cfif i MOD 2 eq 0>
				<cfset model("Introduction").create(
					ownerid=owner.key()
					,entitytypeid=4
					,statustypeid=0
					,body="Greetings {customer-firstname}, this is {administrator-firstname} from {owner-tradingname} VS.. How would you like us to take care of your utilities."
				)>
				<cfset model("Introduction").create(
					ownerid=owner.key()
					,entitytypeid=9
					,statustypeid=0
					,body="Howdy ho {customer-firstname}! I'm {administrator-firstname} from {owner-tradingname} VS and I want to do a survey!!!"
				)>
			</cfif>

			<cfif i eq 1>			
				<!--- create custom fields for owner --->	
				<cfset model("customfield").new(ownerid="", displayname="Settlement date", fieldname="settlementdate", fieldtype="date").save()>
				<cfset model("customfield").new(ownerid="", displayname="Happy special day", fieldname="specialday", fieldtype="date").save()>
	
				<!--- create custom milestones --->	
				<cfset model("milestone").new(ownerid=owner.key(), name="Settlement date", customfieldid=1).save()>
				<cfset model("milestone").new(ownerid=owner.key(), name="Special date", customfieldid=2).save()>
				
				<!--- create custom rule for owner --->
				<cfset model("rule").new(ownerid=owner.key(), name="Congrats on Settlement", milestoneid=1, isoccuratevent=1, periodid="1", cycle=1, iterations=1, methodid=1, subject="Congrats", body="Congrats on your settlement!", notifyid=1).save()>
				<cfset model("rule").new(ownerid=owner.key(), name="How is your home next 5 months?", milestoneid=1, isoccuratevent=0, periodid="3", cycle=1, iterations=5, methodid=1, subject="How is ya home?", body="Hope you enjoying your new house!", notifyid=1).save()>
			<cfelseif i eq 2>
				<!--- set the franchiseid for when i eq 3,4,5 --->
				<cfset franchiseid = owner.key()>
			</cfif>			
			
		</cfloop>
		
		<!--- providers --->
		<cfloop from="1" to="#ArrayLen(providers)#" index="i">
			
			<cfset providerName = providers[i]>
			<cfset providerDomain = LCase(Replace(providerName, " ", "", "all"))>

			<cfset provider = model("Provider").create(
					name=providerName
					,tradingname=providerName
					,phone="#NumberFormat(i,00)#87 4567"
					,email="mail@#providerDomain#.com.au" 
					,website="www.#providerDomain#.com.au"
					,statustypeid=0
					)>
			

			<cfset addresses = [
				model("address").create(
					providerid=provider.key()
					,addresstypeid=1
					,entitytypeid=get("entityTypeStruct").provider
					,streetnumber=i
					,streetname='#nouns[i]# Road'
					,town="#animals[i]#ville"
					,postcode=3000-i
					,state="VIC"
					,country="Australia"
					)
				,model("address").create(
					providerid=provider.key()
					,addresstypeid=2
					,entitytypeid=get("entityTypeStruct").provider
					,streetnumber=i
					,streetname='#phonetics[i]# Boulevard'
					,town="#nouns[$complementary(i)]#town"
					,postcode=3000-i
					,state="VIC"	
					,country="Australia"
					)
			]>
			<cfset people = [
				model("person").create(providerid=provider.key(), entitytypeid=get("entityTypeStruct").provider, firstname="#names['20']#", lastname="#surnames[i]#")
				,model("person").create(providerid=provider.key(), entitytypeid=get("entityTypeStruct").provider, firstname="#names['25']#", lastname="#surnames[$complementary(i)]#")
			]>
			
			<cfset powerService = model("service").new(providerid=provider.key(), servicetypeid=1, name="Power", price=200+i, commission=100+i)>
			<cfset gasService = model("service").new(providerid=provider.key(), servicetypeid=2, name="Gas", price=100+i, commission=50+i)>
			<cfset phoneService = model("service").new(providerid=provider.key(), servicetypeid=3, name="Phone", price=300+i, commission=150+i)>
			<cfset internetService = model("service").new(providerid=provider.key(), servicetypeid=4, name="Internet", price=150+i, commission=75+i)>
			<cfset waterService = model("service").new(providerid=provider.key(), servicetypeid=5, name="Water", price=150+i, commission=60+i)>
			<cfset paytvService = model("service").new(providerid=provider.key(), servicetypeid=6, name="Pay TV", price=80+i, commission=30+i)>
			<cfset lawnService = model("service").new(providerid=provider.key(), servicetypeid=7, name="Lawn Mowing", price=40+i, commission=15+i)>

			<cfswitch expression="#i#">
				<cfcase value="1"><!--- telstra --->
					<cfset newServices = [phoneService.save(),internetService.save()]>
				</cfcase>
				<cfcase value="2"><!--- optus --->
					<cfset newServices = [phoneService.save(),internetService.save(),paytvService.save()]>
				</cfcase>
				<cfcase value="3"><!--- virgin --->
					<cfset newServices = [phoneService.save(),internetService.save()]>
				</cfcase>
				<cfcase value="4"><!--- tru --->
					<cfset newServices = [powerService.save(),gasService.save()]>
				</cfcase>
				<cfcase value="5"><!--- origin --->
					<cfset newServices = [powerService.save(),gasService.save()]>
				</cfcase>
				<cfcase value="6"><!--- SE Water --->
					<cfset newServices = [waterService.save()]>
				</cfcase>
				<cfcase value="7"><!--- Foxtel --->
					<cfset newServices = [paytvService.save()]>
				</cfcase>
				<cfcase value="8"><!--- Jims Mowing --->
					<cfset newServices = [lawnService.save()]>
				</cfcase>
				<cfdefaultcase>
					No provider found<cfabort>
				</cfdefaultcase>
			</cfswitch>
			


			

		</cfloop>
		
		<!--- customers --->
		<cfloop from="1" to="#loops#" index="i">
			<cfloop from="1" to="16" index="u">
				
				<cfset ai = u + i><!--- array index for getting names.. try to make them different per owner --->
				
				<cfset customer_firstname = "#names_b[ai]#">
				<cfset customer_lastname = "#surnames[ai]#">

				<cfset customer = model("Customer").create(
						ownerid=i
						,name="#customer_firstname# #customer_lastname#"
						,statustypeid=0
						)>

				<cfset addresses = [
					model("address").create(
						customerid=customer.key()
						,addresstypeid=4
						,entitytypeid=get("entityTypeStruct").customer
						,streetnumber=(i * 8) - 6
						,streetname='#nouns[u]# Crescent'
						,town="#phonetics[$complementary(u)]#town"
						,postcode=3000-(i * 3)
						,state="VIC"
						,country="Australia"
						)
					,model("address").create(
						customerid=customer.key()
						,addresstypeid=5
						,entitytypeid=get("entityTypeStruct").customer
						,streetnumber=(i * 8) - 4
						,streetname='#surnames[$complementary(u)]# Court'
						,town="#phonetics[u]#town"
						,postcode=3000-(i * 3)
						,state="VIC"
						,country="Australia"
						)
					,model("address").create(
						customerid=customer.key()
						,addresstypeid=6
						,entitytypeid=get("entityTypeStruct").customer
						,streetnumber=(i * 8) - 1
						,streetname='#animals[$complementary(u)]# Highway'
						,town="#phonetics[u]#town"
						,postcode=3000-(i * 3)
						,state="VIC"
						,country="Australia"
						,settleat=DateAdd("d", i+u, Now())
						)
					,model("address").create(
						customerid=customer.key()
						,addresstypeid=3
						,entitytypeid=get("entityTypeStruct").customer
						,streetnumber=(i * 8) - 2
						,streetname='#nouns[$complementary(u)]# Street'
						,town="#phonetics[u]#town"
						,postcode=3000-(i * 3)
						,state="VIC"
						,country="Australia"
						)
				]>
				
				<!--- TODO: hard code some of these randomised values for use with testing --->
				<cfset homephone = "9#RandRange(100,990)# #RandRange(1000,9999)#">
				<cfset person_one = model("person").new(
														customerid=customer.key()
														,entitytypeid=get("entityTypeStruct").customer
														,firstname="#names_b[ai]#"
														,lastname="#surnames[ai]#"
														,mobile="04#RandRange(10,99)# #RandRange(100,999)# #RandRange(100,999)#"
														,homephone=homephone
														,workphone="9#RandRange(100,990)# #RandRange(1000,9999)#"
														,email=LCase("#names_b[ai]#_#RandRange(100,990)#@#nouns[RandRange(1,26)]#mail.com.au")
														,iscontactperson=1
														,contactmethod=contactMethods[RandRange(1,5)]
														)>
				<cfset person_two = model("person").new(
														customerid=customer.key()
														,entitytypeid=get("entityTypeStruct").customer
														,firstname="#names_b[$complementary(ai)]#"
														,lastname="#surnames[ai]#"
														,mobile="04#RandRange(10,99)# #RandRange(100,999)# #RandRange(100,999)#"
														,homephone=homephone
														,workphone="9#RandRange(100,990)# #RandRange(1000,9999)#"
														,email="#names_b[$complementary(ai)]#.#surnames[ai]##RandRange(100,990)#@#nouns[RandRange(1,26)]#mail.com"
														)>
				<cfset newPeople = u MOD 2 eq 0 ? [person_one.save()] : [person_one.save(), person_two.save()]>
				
				<cfset customerType_tenant = model("customercustomertype").new(customerid=customer.key(), customertypeid=1)>
				<cfset customerType_buyer = model("customercustomertype").new(customerid=customer.key(), customertypeid=2)>
						
				<cfset newCustomerType = u MOD 2 eq 0 ? [customerType_buyer.save()] : [customerType_buyer.save(), customerType_tenant.save()]>

				<!--- create some orders for these customers --->
				<cfset addressid = model("address").findOne(where="customerid = #customer.key()# AND addresstypeid = 6").key()>
				
				<cfif i gt 16>
					
				<cfelseif i gt 8 AND i lte 16>
					<cfset $createOrder(addressid=addressid, customerid=customer.key(), serviceid=1, statustypeid=400, serviceCount=1)>
				<cfelse>
					<cfset $createOrder(addressid=addressid, customerid=customer.key(), serviceid=1, statustypeid=400, serviceCount=1)>
					<cfset $createOrder(addressid=addressid, customerid=customer.key(), serviceid=1, statustypeid=410, serviceCount=2)>
					<cfset $createOrder(addressid=addressid, customerid=customer.key(), serviceid=1, statustypeid=420, serviceCount=2)>
					<cfset $createOrder(addressid=addressid, customerid=customer.key(), serviceid=1, statustypeid=430, serviceCount=2)>
					<cfset $createOrder(addressid=addressid, customerid=customer.key(), serviceid=1, statustypeid=430, serviceCount=3)>
				</cfif>
			</cfloop>
		</cfloop>
		
		<!--- create jobs --->
		<cfloop from="1" to="2" index="a">
			<cfset ja = model("Address").findAll(select="administratorid, addresses.id AS addressid, owners.id AS ownerid", where="administratorid = #a#", include="Customer(Owner(AdministratorOwners))", order="ownerid", maxRows=10)>
			<!--- <cfdump var="#ja#" abort="true"> --->
			<cfoutput query="ja" group="ownerid">
				<cfset job = model("Job").create(administratorid=a)>
				<cfoutput>
					<cfset jobAddress = model("jobAddress").create(jobid=job.key(), addressid=ja.addressid)>
				</cfoutput>
			</cfoutput>
		</cfloop>

		<!--- 
		** COMPASS **
		 --->
		
		<!--- layouts --->
		<cfset tangoLayout = model("layout").create(name="Tango", slug="tango")>
		<cfset uniformLayout = model("layout").create(name="Uniform", slug="uniform")>
		<cfset victorLayout = model("layout").create(name="Victor", slug="victor")>
		<cfset whiskeyLayout = model("layout").create(name="Whiskey", slug="whiskey")>
		<cfset layouts = []>
		<cfset ArrayAppend(layouts,tangoLayout)>
		<cfset ArrayAppend(layouts,uniformLayout)>
		<cfset ArrayAppend(layouts,victorLayout)>
		<cfset ArrayAppend(layouts,whiskeyLayout)>
		
		<!--- widgets --->
		<cfset julietWidget = model("widget").create(name="#nouns[10]# Widget", slug=LCase(nouns[10]), iscategorywidget=true)>										<!--- category --->
		<cfset kiloWidget = model("widget").create(name="#nouns[11]# Widget", slug=LCase(nouns[11]), isitemwidget=true, minimumitemcount=1, maximumitemcount=1)>	<!--- items : one --->
		<cfset limaWidget = model("widget").create(name="#nouns[12]# Widget", slug=LCase(nouns[12]), isitemwidget=true, minimumitemcount=3, maximumitemcount=6)>	<!--- item : between 3 and 6 --->
		<cfset mikeWidget = model("widget").create(name="#nouns[13]# Widget", slug=LCase(nouns[13]), isitemwidget=true, minimumitemcount=3)>						<!--- item : min of 3 --->
		<cfset novemberWidget = model("widget").create(name="#nouns[14]# Widget", slug=LCase(nouns[14]), isitemwidget=true, maximumitemcount=6)>						<!--- item : max of 6 --->
		<cfset oscarWidget = model("widget").create(name="#nouns[15]# Widget", slug=LCase(nouns[15]))>																<!--- no data required : eg. weather widget, google ads --->
		
		<!--- templates & widget bridge nested properties --->
		<cfset template = model("template").create(name=phonetics[1], slug=LCase(phonetics[1]))>
		<cfset newTemplateWidgets = [
			model("templatewidget").create(templateid=template.key(), widgetid=1)
		]>
		
		<cfset template = model("template").create(name=phonetics[2], slug=LCase(phonetics[2]))>
		<cfset newTemplateWidgets = [
			model("templatewidget").create(templateid=template.key(), widgetid=1)
			,model("templatewidget").create(templateid=template.key(), widgetid=2)
		]>
		
		<cfset template = model("template").create(name=phonetics[3], slug=LCase(phonetics[3]))>
		<cfset newTemplateWidgets = [
			model("templatewidget").create(templateid=template.key(), widgetid=1)
			,model("templatewidget").create(templateid=template.key(), widgetid=2)
			,model("templatewidget").create(templateid=template.key(), widgetid=3)
		]>
		
		<cfset template = model("template").create(name=phonetics[4], slug=LCase(phonetics[4]))>
		<cfset newTemplateWidgets = [
			model("templatewidget").create(templateid=template.key(), widgetid=1)
			,model("templatewidget").create(templateid=template.key(), widgetid=2)
			,model("templatewidget").create(templateid=template.key(), widgetid=3)
			,model("templatewidget").create(templateid=template.key(), widgetid=4)
			,model("templatewidget").create(templateid=template.key(), widgetid=5)
			,model("templatewidget").create(templateid=template.key(), widgetid=6)
		]>
		
		<!--- rule --->
		<!--- create standard milestones --->	
		<cfset model("milestone").new(name="Christmas",fixeddate="25/12/2012").save()>
		<cfset model("milestone").new(name="New Year",fixeddate="01/01/2012").save()>
		<cfset model("milestone").new(name="Birthday",object="people",objectproperty="dateofbirth").save()>
	
		<!--- create standard rules --->	
		<cfset model("rule").new(name="Christmas greetings", milestoneid=3, isoccuratevent=1, periodid="5", cycle=1, iterations=3, methodid=3, subject="Ho ho ho", body="Merry Christmas!", notifyid=2).save()>
		<cfset model("rule").new(name="Happy New Year ", milestoneid=4, isoccuratevent=1, periodid="5", cycle=1, iterations=3, methodid=2, subject="Happy New Year", body="Wishing you a happy new year!!", notifyid=1).save()>
		<cfset model("rule").new(name="Happy Birthday", milestoneid=5, isoccuratevent=1, periodid="5", cycle=1, iterations=3, methodid=1, subject="Happy Birthday", body="Hey you, happy birthday!!", notifyid=1).save()>

		<!--- create standard surveys --->
		<cfset model("survey").new(name="Feedback", description="Feedback").save()>
		<cfset model("survey").new(name="General", description="General").save()>
	
		<!--- survey question types --->
		<cfset model("questiontypes").new(name="Multiple Choice", type="multiplechoice").save()>		
		<cfset model("questiontypes").new(name="Radio Button", type="radiobutton").save()>		
		<cfset model("questiontypes").new(name="Text", type="text").save()>		

		<!--- survey answer banks --->
		<cfset model("answerbankgroups").new(name="Ratings 1-10").save()>		
		<cfset model("answerbanks").new(answerbankgroupid=1,answer="1",answersequence="1").save()>		
		<cfset model("answerbanks").new(answerbankgroupid=1,answer="2",answersequence="2").save()>		
		<cfset model("answerbanks").new(answerbankgroupid=1,answer="3",answersequence="3").save()>		
		<cfset model("answerbanks").new(answerbankgroupid=1,answer="4",answersequence="4").save()>		
		<cfset model("answerbanks").new(answerbankgroupid=1,answer="5",answersequence="5").save()>		
		<cfset model("answerbanks").new(answerbankgroupid=1,answer="6",answersequence="6").save()>		
		<cfset model("answerbanks").new(answerbankgroupid=1,answer="7",answersequence="7").save()>		
		<cfset model("answerbanks").new(answerbankgroupid=1,answer="8",answersequence="8").save()>		
		<cfset model("answerbanks").new(answerbankgroupid=1,answer="9",answersequence="9").save()>		
		<cfset model("answerbanks").new(answerbankgroupid=1,answer="10",answersequence="10").save()>		

		<cfset model("answerbankgroups").new(name="Yes or No").save()>		
		<cfset model("answerbanks").new(answerbankgroupid=2,answer="Yes",answersequence="1").save()>		
		<cfset model("answerbanks").new(answerbankgroupid=2,answer="No",answersequence="2").save()>		

		<cfset model("answerbankgroups").new(name="Extremely well, Average and Terrible").save()>		
		<cfset model("answerbanks").new(answerbankgroupid=3,answer="Extremely well",answersequence="1").save()>		
		<cfset model("answerbanks").new(answerbankgroupid=3,answer="Average",answersequence="2").save()>		
		<cfset model("answerbanks").new(answerbankgroupid=3,answer="Terrible",answersequence="3").save()>		

		<!--- create standard question bank --->	
		<cfset model("questions").new(questiontypeid="1",question="What are you favourite Colours",sequence=1).save()>
		<cfset model("answers").new(questionid=1,answer="White",answersequence=1).save()>
		<cfset model("answers").new(questionid=1,answer="Green",answersequence=2).save()>
		<cfset model("answers").new(questionid=1,answer="Blue",answersequence=3).save()>
		<cfset model("answers").new(questionid=1,answer="Black",answersequence=4).save()>
		
		<cfset model("questions").new(questiontypeid="2",question="How would you rate our services",sequence=1).save()>
		<cfset model("answers").new(questionid=2,answer="1",answersequence=1).save()>
		<cfset model("answers").new(questionid=2,answer="2",answersequence=2).save()>
		<cfset model("answers").new(questionid=2,answer="3",answersequence=3).save()>
		<cfset model("answers").new(questionid=2,answer="4",answersequence=4).save()>
		<cfset model("answers").new(questionid=2,answer="5",sequence=5).save()>
		
		<cfset model("questions").new(questiontypeid="1",question="Your favourite car manufacturer/s",sequence=1).save()>
		<cfset model("answers").new(questionid=3,answer="Holden",answersequence=1).save()>
		<cfset model("answers").new(questionid=3,answer="Ford",answersequence=2).save()>
		<cfset model("answers").new(questionid=3,answer="Dodge",answersequence=3).save()>
		<cfset model("answers").new(questionid=3,answer="Nissan",answersequence=4).save()>
		<cfset model("answers").new(questionid=3,answer="Audi",answersequence=4).save()>
		<cfset model("answers").new(questionid=3,answer="BMW",answersequence=4).save()>
		
		<cfset model("questions").new(questiontypeid="2",question="How would you rate your customer service experience",sequence=1).save()>
		<cfset model("answers").new(questionid=4,answer="Extremely well",answersequence=1).save()>
		<cfset model("answers").new(questionid=4,answer="Very well",answersequence=2).save()>
		<cfset model("answers").new(questionid=4,answer="Moderately well",answersequence=3).save()>
		<cfset model("answers").new(questionid=4,answer="Slightly well",answersequence=4).save()>
		<cfset model("answers").new(questionid=4,answer="Terrible",answersequence=5).save()>

		<!--- for surveyid = 2 (general) --->
		<cfset model("questions").new(surveyid=2, questiontypeid="2",question="How would you rate our services",sequence=1).save()>
		<cfset model("answers").new(questionid=5,answer="1",answersequence=1).save()>
		<cfset model("answers").new(questionid=5,answer="2",answersequence=2).save()>
		<cfset model("answers").new(questionid=5,answer="3",answersequence=3).save()>
		<cfset model("answers").new(questionid=5,answer="4",answersequence=4).save()>
		<cfset model("answers").new(questionid=5,answer="5",sequence=5).save()>

		<cfset model("questions").new(surveyid=1, questiontypeid="2",question="How would you rate your customer service experience",sequence=1).save()>
		<cfset model("answers").new(questionid=6,answer="Extremely well",answersequence=1).save()>
		<cfset model("answers").new(questionid=6,answer="Very well",answersequence=2).save()>
		<cfset model("answers").new(questionid=6,answer="Moderately well",answersequence=3).save()>
		<cfset model("answers").new(questionid=6,answer="Slightly well",answersequence=4).save()>
		<cfset model("answers").new(questionid=6,answer="Terrible",answersequence=5).save()>

		<!--- create customer surveys & custom values (ONLY first 5 customers?) --->
		<cfloop from="1" to="5" index="i">
			<cfset model("customersurveys").new(surveyid=2,customerid=i,completedat=DateAdd("m",1,Now())).save()>
			<cfset model("customersurveyresults").new(customersurveyid=i,questionid=5,answerid=23).save()>

			<cfset model("customvalues").new(customerid=i, customfieldid=1,customdate=DateAdd("m",1,Now())).save()>
		</cfloop>

		<!--- owner --->
		<cfset inc = 0>
		<!--- <cfloop from="1" to="#loops#" index="i"> --->
		<cfloop from="2" to="5" index="i">
			
			<!--- increment a counter so we can do things every Xth loop --->
			<cfset inc++>
			
			<cfset prefs = {
				siteCount=1
				,siteTemplateCount=0
			}>
			<cfif i eq 1>
				
			<cfelseif i eq 2>
				<cfset prefs.siteCount = 2>
			<cfelseif i eq 3>
			
			</cfif>
			
			<!--- create owner --->
			<cfset owner = model("Owner").create(
					name="#animals[i]# World"
					,tradingname="#animals[i]# World Pty Ltd"
					,phone="0987 65#NumberFormat(i,00)#"
					,email="mail@#LCase(animals[i])#world.com"
					,statustypeid=0
					)>
			
			<!--- addresses --->
			<cfset model("address").create(ownerid=i, addresstypeid=1, entitytypeid=get("entityTypeStruct").owner, streetnumber=i, streetname='#animals[i]# Street', town="#phonetics[i]#tonia", postcode=3000-i, state="VIC", country="Australia")>
			<cfset model("address").create(ownerid=i, addresstypeid=2, entitytypeid=get("entityTypeStruct").owner, streetnumber=$complementary(i), streetname='#names[$complementary(i)]# Street', town="#surnames[$complementary(i)]#town", postcode=2000-i, state="NSW", country="Australia")>
			<!--- people --->
			<cfset model("person").new(ownerid=i, entitytypeid=get("entityTypeStruct").owner, firstname="#names[1]#", lastname="#phonetics[$complementary(i)]#", email=LCase("#names[1]#.#phonetics[$complementary(i)]#@#animals[i]#world.com"), password=standardPassword, passwordConfirmation=standardPassword, lastLoginAt=Now(), lastLoginAttemptAt=Now(), lastLoginAttemptIPAddress=CGI.remote_addr).save()>
			<cfset model("person").new(ownerid=i, entitytypeid=get("entityTypeStruct").owner, firstname="#names[2]#", lastname="#nouns[$complementary(i)]#", email=LCase("#names[2]#.#nouns[$complementary(i)]#@#animals[i]#world.com"), password=standardPassword, passwordConfirmation=standardPassword).save()>
			<!--- a pending person.. (hasn't logged in yet) --->
			<cfset model("person").new(ownerid=i, entitytypeid=get("entityTypeStruct").owner, firstname="#names[3]#", lastname="#animals[$complementary(i)]#", email=LCase("#names[3]#.#animals[$complementary(i)]#@#animals[i]#world.com"), password=standardPassword, passwordConfirmation=standardPassword, resetToken=CreateUUID(), tokenExpiresAt=Now()).save()>

			<!--- owner categories (for contacts) --->
			<cfset categories = []>
			<cfset categories[1] = model("category").create(ownerid=i, entitytypeid=get("entityTypeStruct").contact, name="Angels")>
			<cfset categories[2] = model("category").create(ownerid=i, entitytypeid=get("entityTypeStruct").contact, name="Criminals")>
			<cfset categories[3] = model("category").create(ownerid=i, entitytypeid=get("entityTypeStruct").contact, name="Supermodels")>
			<cfset categories[4] = model("category").create(ownerid=i, entitytypeid=get("entityTypeStruct").contact, name="Hippies")>
			<cfset categories[5] = model("category").create(ownerid=i, entitytypeid=get("entityTypeStruct").contact, name="Weirdos")>
			<cfset categories[6] = model("category").create(ownerid=i, entitytypeid=get("entityTypeStruct").contact, name="Other")>

			<!--- create some owner contacts (CRM) --->
			<cfloop from="1" to="6" index="c">
				<cfset newPerson = model("person").new(entitytypeid=get("entityTypeStruct").contact, firstname=names[$complementary(c)], lastname=phonetics[c], email=LCase("#names[$complementary(c)]#.#phonetics[c]#@mail-#i#-#c#.com"), password=standardPassword, passwordConfirmation=standardPassword)>
				<cfset contact = model("contact").new(ownerid=i, entitytypeid=get("entityTypeStruct").owner, person=newPerson)>
				<cfset contact.save()>
				<!--- put them in a category --->
				<cfloop from="1" to="6" index="d">
					<cfset model("contactcategory").create(contactid=contact.key(),categoryid=d)>
				</cfloop>
			</cfloop>

			<!--- create sites --->
			<cfloop from="1" to="#prefs.siteCount#" index="s">
				
				<cfset site = model("site").create(ownerid=i, layoutid=s, itemtemplatewidgetid=6, name="#animals[s]#'s #pluralize(nouns[i])# Website", liveat=DateAdd("m",-24,Now()))>
				
				<!--- domains --->
				<cfset model("domain").create(siteid=site.key(), name="#LCase(animals[i])#world.com")>
				<cfset model("domain").create(siteid=site.key(), name="#LCase(animals[i])#world.com.au")>
				<cfif i eq 1>
					<cfset model("domain").create(siteid=site.key(), name="#LCase(alphabet[i])#-is-for-#LCase(phonetics[i])#.com")>
					<cfset model("domain").create(siteid=site.key(), name="#LCase(alphabet[i])#-is-for-#LCase(phonetics[i])#.com.au")>
				</cfif>
				
				<!--- site contacts (CRM) --->
				<cfloop from="8" to="15" index="c">
					<cfset newPerson = model("person").new(entitytypeid=get("entityTypeStruct").contact, firstname=names[c], lastname=nouns[$complementary(c)], email=LCase("#names[c]#.#nouns[$complementary(c)]#.#i#@#c#mail.com"), password=standardPassword, passwordConfirmation=standardPassword)>
					<cfset contact = model("contact").new(ownerid=i, siteid=site.key(), entitytypeid=get("entityTypeStruct").site, person=newPerson).save()>
				</cfloop>

				<!--- attributes --->
				<cfset colour = model("attribute").create(siteid=site.key(), name="Colour")><!--- set options --->
					<cfset colourAttributeOptions = []>
					<cfset colourAttributeOptions[1] = model("attributeOption").create(attributeid=colour.key(), value="Red", sequence=1)>
					<cfset colourAttributeOptions[2] = model("attributeOption").create(attributeid=colour.key(), value="Orange", sequence=2)>
					<cfset colourAttributeOptions[3] = model("attributeOption").create(attributeid=colour.key(), value="Yellow", sequence=3)>
					<cfset colourAttributeOptions[4] = model("attributeOption").create(attributeid=colour.key(), value="Green", sequence=4)>
					<cfset colourAttributeOptions[5] = model("attributeOption").create(attributeid=colour.key(), value="Blue", sequence=5)>
					<cfset colourAttributeOptions[6] = model("attributeOption").create(attributeid=colour.key(), value="Satanic Purple", sequence=6)>
					<cfset colourAttributeOptions[7] = model("attributeOption").create(attributeid=colour.key(), value="Violet", sequence=7)>
				
				<cfset price = model("attribute").create(siteid=site.key(), name="Price")>			<!--- numeric free text --->
				
				<cfset size = model("attribute").create(siteid=site.key(), name="Size")>			<!--- set options --->	
					<cfset sizeAttributeOptions = []>
					<cfset sizeAttributeOptions[1] = model("attributeOption").create(attributeid=size.key(), value="Tiny", sequence=1)>
					<cfset sizeAttributeOptions[2] = model("attributeOption").create(attributeid=size.key(), value="Small", sequence=2)>
					<cfset sizeAttributeOptions[3] = model("attributeOption").create(attributeid=size.key(), value="Medium", sequence=3)>
					<cfset sizeAttributeOptions[4] = model("attributeOption").create(attributeid=size.key(), value="Large", sequence=4)>
					<cfset sizeAttributeOptions[5] = model("attributeOption").create(attributeid=size.key(), value="Fuge", sequence=5)>
				
				<cfset flavour = model("attribute").create(siteid=site.key(), name="Flavour")>		<!--- free text --->
				
				<cfset dayAttr = model("attribute").create(siteid=site.key(), name="Days of Week")>	<!--- multiple --->
					<cfset dayAttributeOptions = []>
					<cfloop from="1" to="7" index="d">
						<cfset dayAttributeOptions[d] = model("attributeOption").create(attributeid=dayAttr.key(), value=DayOfWeekAsString(d), sequence=d)>
					</cfloop>
				
				<!--- categories --->
				<cfset categories = []>
				<cfset categories[1] = model("category").create(siteid=site.key(), ownerid=i, entitytypeid=get("entityTypeStruct").site, name="Weird & Wacky")>
				<cfset categories[2] = model("category").create(siteid=site.key(), ownerid=i, entitytypeid=get("entityTypeStruct").site, name="Electric Powered")>
				<cfset categories[3] = model("category").create(siteid=site.key(), ownerid=i, entitytypeid=get("entityTypeStruct").site, name="Loud")>
				<cfset categories[4] = model("category").create(siteid=site.key(), ownerid=i, entitytypeid=get("entityTypeStruct").site, name="Super Fast")>
				<cfset categories[5] = model("category").create(siteid=site.key(), ownerid=i, entitytypeid=get("entityTypeStruct").site, name="Mega Happy Summer Fun")>
				
				<!--- items --->
				<cfset items = []>
				<cfloop from="1" to="#ArrayLen(content)#" index="c">
					<cfset contentArgs = Duplicate(content[c])>
					<cfset contentArgs.siteId = site.key()>
					<cfset contentArgs.publishedat = Now()>
					<cfset items[c] = model("item").create(contentArgs)>
				</cfloop>
				
				<!--- pages --->
				<cfset model("page").create(siteid=site.key(), templateid=1, name="Home Page", slug="home-page", ishome=1)>
				<cfset model("page").create(siteid=site.key(), templateid=2, name="About Valkyrie", slug="about-valkyrie")>
				<cfset model("page").create(siteid=site.key(), templateid=3, name="Contact Us", slug="contact")>
				
				<!--- menus --->
				<cfset menu = model("menu").create(siteid=site.key(), name="#animals[i]# Menu", isdefault=1)>
				<cfloop from="6" to="8" index="m">
					<cfset link = model("menuLink").create(menuid=menu.key(), text=phonetics[m], href=LCase("http://www.#names[m]##animals[m]#.com"))>
					<cfset parentLink = model("menuLink").create(menuid=menu.key(), text=phonetics[m+13])>
					<cfset childLink = model("menuLink").create(menuid=menu.key(), parentid=parentLink.key(), text=bands[m])>
					<cfset childLink = model("menuLink").create(menuid=menu.key(), parentid=parentLink.key(), text=bands[m+13])>
				</cfloop>
				
				<!--- create links to pages --->
				<cfset pages = model("page").findAllBySiteid(value=site.key(), returnAs="objects")>
				<cfloop array="#pages#" index="p">
					<cfset model("menuLink").create(menuid=menu.key(), pageid=p.key(), text=p.name)>
				</cfloop>
				
				<!--- insert to some bridge tables --->
				<cfset items = model("item").findAllBySiteid(value=site.key(), returnAs="objects")>
				<!--- itemcategories --->
				<!--- loop thru the items for this site and put them in categories --->
				<cfset cnt = 0>
				<cfloop array="#items#" index="item">
					<cfset cnt++>
					<cfif cnt eq 1>
						<cfset itemCategories = [
							model("itemCategories").new(categoryid=categories[1].key())
						]>
						<cfset itemAttributeOptions = [
							model("itemAttributeOptions").new(
								attributeid=$optionByValue(value=colourAttributeOptions[1].value, siteid=site.key()).attributeid
								,attributeoptionid=$optionByValue(value=colourAttributeOptions[1].value, siteid=site.key()).id
							)
							,model("itemAttributeOptions").new(
								attributeid=$optionByValue(value=colourAttributeOptions[7].value, siteid=site.key()).attributeid
								,attributeoptionid=$optionByValue(value=colourAttributeOptions[7].value, siteid=site.key()).id
							)
							
							,model("itemAttributeOptions").new(
								attributeid=$optionByValue(value=sizeAttributeOptions[1].value, siteid=site.key()).attributeid
								,attributeoptionid=$optionByValue(value=sizeAttributeOptions[1].value, siteid=site.key()).id
							)
							,model("itemAttributeOptions").new(
								attributeid=$optionByValue(value=sizeAttributeOptions[2].value, siteid=site.key()).attributeid
								,attributeoptionid=$optionByValue(value=sizeAttributeOptions[2].value, siteid=site.key()).id
							)
							,model("itemAttributeOptions").new(
								attributeid=$optionByValue(value=sizeAttributeOptions[3].value, siteid=site.key()).attributeid
								,attributeoptionid=$optionByValue(value=sizeAttributeOptions[3].value, siteid=site.key()).id
							)
								
							,model("itemAttributeOptions").new(
								attributeid=$optionByValue(value=dayAttributeOptions[2].value, siteid=site.key()).attributeid
								,attributeoptionid=$optionByValue(value=dayAttributeOptions[2].value, siteid=site.key()).id
							)
							,model("itemAttributeOptions").new(
								attributeid=$optionByValue(value=dayAttributeOptions[3].value, siteid=site.key()).attributeid
								,attributeoptionid=$optionByValue(value=dayAttributeOptions[3].value, siteid=site.key()).id
							)
							,model("itemAttributeOptions").new(
								attributeid=$optionByValue(value=dayAttributeOptions[4].value, siteid=site.key()).attributeid
								,attributeoptionid=$optionByValue(value=dayAttributeOptions[4].value, siteid=site.key()).id
							)
						]>
						
						<cfset itemAttributeValues = [
							model("itemAttributeValues").new(
								attributeid=$attributeidByName(name="Flavour", siteid=site.key())
								,value="Vanilla"
							)
								
							,model("itemAttributeValues").new(
								attributeid=$attributeidByName(name="Price", siteid=site.key())
								,value=(i*s) / 1.12
							)
						]>
						
					<cfelseif cnt eq 2>
						<cfset itemCategories = [
							model("itemCategories").new(categoryid=categories[1].key())
							,model("itemCategories").new(categoryid=categories[2].key())
						]>
						<cfset itemAttributeOptions = []>
					<cfelseif cnt eq 3>
						<cfset itemCategories = [
							model("itemCategories").new(categoryid=categories[1].key())
							,model("itemCategories").new(categoryid=categories[2].key())
							,model("itemCategories").new(categoryid=categories[3].key())
						]>
						<cfset itemAttributeOptions = []>
					<cfelseif cnt eq 4>
						<cfset itemCategories = [
							model("itemCategories").new(categoryid=categories[1].key())
							,model("itemCategories").new(categoryid=categories[2].key())
							,model("itemCategories").new(categoryid=categories[3].key())
							,model("itemCategories").new(categoryid=categories[4].key())
						]>
						<cfset itemAttributeOptions = []>
					<cfelseif cnt eq 5>
						<cfset itemCategories = [
							model("itemCategories").new(categoryid=categories[1].key())
							,model("itemCategories").new(categoryid=categories[2].key())
							,model("itemCategories").new(categoryid=categories[3].key())
							,model("itemCategories").new(categoryid=categories[4].key())
							,model("itemCategories").new(categoryid=categories[5].key())
						]>
						<cfset newItemAttributeOptions = []>
					<cfelse>
						<cfset itemCategories = []>
						<cfset itemAttributeOptions = []>
					</cfif>
					<cfset item.itemcategories = itemCategories>
					<cfset item.itemattributeoptions = itemAttributeOptions>
					<cfset item.itemattributeValues = itemattributeValues>
					<cfset item.save()>
				</cfloop>
				
				<!--- site specific stuff --->
				<cfif i eq 1 AND s eq 1>
					
				<cfelseif false><!--- add more sites here --->
					
				</cfif>
				
				<!--- page resources --->
				
				<!--- get pages, and widgets (via template) and populate with data --->
				<cfset pagewidgets = model("page").findAll(select="pages.id AS id, widgetid, iscategorywidget, isitemwidget, maximumitemcount, templatewidgets.id AS templatewidgetid", where="siteid = #site.key()#", include="template(templatewidgets(widget))", order="id,templateid,widgetid")>
				<cfloop query="pagewidgets">
					<cfset thisPageid = pagewidgets.id>
					<cfset thisWidgetid = pagewidgets.widgetid>
					<cfset thisTemplateWidgetid = pagewidgets.templatewidgetid>
					<cfif pagewidgets.iscategorywidget>
						<cfset resources = {}>
						<cfset resources.pageid = thisPageid>
						<cfset resources.widgetid = thisWidgetid>
						<cfset resources.categoryid = $categoryidByName(name="Super Fast", siteid=site.key())>				
						<cfset pageresource = model("pageresource").create(resources)>
					<cfelseif pagewidgets.isitemwidget>
						<cfset items = model("item").findAllBySiteid(value=site.key(), returnAs="query")>
						<cfset maxRows = maximumItemCount>
						<cfloop query="items" startrow="1" endrow="#pagewidgets.maximumItemCount is "" ? 1000 : pagewidgets.maximumItemCount#">
							<cfset resources = {}>
							<cfset resources.pageid = thisPageid>
							<cfset resources.widgetid = thisWidgetid>
							<cfset resources.itemid = items.id>
							<cfset pageresource = model("pageresource").create(resources)>
						</cfloop>
					</cfif>
				</cfloop>
				
				<!--- site specific widget content --->
				<cfif i eq 1 AND s eq 1>

				<cfelseif false><!--- add more sites here --->
					
				</cfif>
				
				
				
			</cfloop>
			
			<!--- reset every third loop --->
			<cfif inc eq 3>
				<cfset inc = 1>
			</cfif>
			
		</cfloop>

		<cfif cgi.HTTP_REFERER IS "">
			<cfset renderNothing()>
		<cfelse>
			<cfset flashInsert(message="The database was reset", messageType="success")>
			<cfset redirectTo(back=true)>
		</cfif>
		
	</cffunction>
	
	<!--- THE definitive site to test with.. add data to this site as first priority --->
	<cffunction name="createCoreSite">
		
		<!--- delete files folder --->
		<cfset filesDir = ExpandPath("/compass/" & get("filePath"))>
		<!--- <cfset batFile = ExpandPath("/compass/" & "delete.bat")> --->

		<cfif DirectoryExists(filesDir)>
			<!--- generate a .BAT file for later execution ---> 
			<!--- <cffile action="WRITE" file="#batFile#" output="RMDIR /S /Q #filesDir#"> --->
			<cfdirectory action="delete" directory="#filesDir#" recurse="true">
			<!--- Now execute the file to delete everything (Folder and all sub-folders and files)---> 
			<!--- <cfexecute name="#batFile#" timeout="60"></cfexecute>  --->
			<!--- now delete the bat file ---> 
			<!--- <cffile action="DELETE" file="#batFile#"> ---> 
		</cfif>
		<cfdirectory action="create" directory="#filesDir#">

		<cfset var loc = {}>
		<cfset loc.key = "automaniac">
		<cfset loc.domain = "automaniac.com.au">

		<!--- create owner --->
		<cfset owner = model("Owner").create(
				name=titleize(loc.key)
				,tradingname="#titleize(loc.key)# Pty Ltd"
				,phone="0987 0666"
				,email="mail@#loc.domain#"
				,statustypeid=0
				,website=loc.domain
				)>

		<!--- create api owner --->
		<cfset model("APIOwner").create(apiid=1, ownerid=owner.key(), apientityid=810, username="zUd1aPfhI1", password="OxRa2kRUsD")>
		
		<!--- addresses --->
		<cfset model("Address").create(ownerid=owner.key(), addresstypeid=1, entitytypeid=get("entityTypeStruct").owner, streetnumber=666, streetname='Brunswick Street', town="Fitzroy", postcode=3004, state="VIC", country="Australia")>
		<cfset model("Address").create(ownerid=owner.key(), addresstypeid=2, entitytypeid=get("entityTypeStruct").owner, streetnumber=546, streetname='Collins Street', town="Melbourne", postcode=3000, state="VIC", country="Australia")>
		<!--- people --->
		<cfset model("Person").new(ownerid=owner.key(), entitytypeid=get("entityTypeStruct").owner, firstname="Adam", lastname="Chapman", email="adam.chapman@#loc.domain#", password=standardPassword, passwordConfirmation=standardPassword, lastLoginAt=Now(), lastLoginAttemptAt=Now(), lastLoginAttemptIPAddress=CGI.remote_addr).save()>
		<cfset model("Person").new(ownerid=owner.key(), entitytypeid=get("entityTypeStruct").owner, firstname="Leroy", lastname="Mah", email="leroy.mah@#loc.domain#", password=standardPassword, passwordConfirmation=standardPassword).save()>
		<!--- a pending person.. (hasn't logged in yet) --->
		<cfset model("Person").new(ownerid=owner.key(), entitytypeid=get("entityTypeStruct").owner, firstname="Eddie", lastname="Lynch", email="eddie.lynch@#loc.domain#", password=standardPassword, passwordConfirmation=standardPassword, resetToken=CreateUUID(), tokenExpiresAt=Now()).save()>
		<!--- someone to test with --->
		<cfset model("Person").new(ownerid=owner.key(), entitytypeid=get("entityTypeStruct").owner, firstname="Lightning", lastname="McQueen", email="lightning@#loc.domain#", password=standardPassword, passwordConfirmation=standardPassword).save()>

		<!--- owner categories (for contacts) --->
		<cfset categories = []>
		<cfset categories[1] = model("Category").create(ownerid=owner.key(), entitytypeid=get("entityTypeStruct").contact, name="Suppliers")>
		<cfset categories[2] = model("Category").create(ownerid=owner.key(), entitytypeid=get("entityTypeStruct").contact, name="Importers")>
		<cfset categories[3] = model("Category").create(ownerid=owner.key(), entitytypeid=get("entityTypeStruct").contact, name="Muscle Car Owners")>
		<cfset categories[4] = model("Category").create(ownerid=owner.key(), entitytypeid=get("entityTypeStruct").contact, name="Turbo Owners")>
		<cfset categories[5] = model("Category").create(ownerid=owner.key(), entitytypeid=get("entityTypeStruct").contact, name="Hot Rodders")>
		<cfset categories[6] = model("Category").create(ownerid=owner.key(), entitytypeid=get("entityTypeStruct").contact, name="Other")>

		<!--- create some owner contacts (CRM) --->
		<cfloop from="1" to="6" index="c">
			
			<cfset contact = model("Contact").create(ownerid=owner.key(), entitytypeid=get("entityTypeStruct").owner)>
			<cfset person = model("Person").create(contactid=contact.key(), entitytypeid=get("entityTypeStruct").contact, firstname=names[$complementary(c)], lastname=phonetics[c], email=LCase("#names[$complementary(c)]#.#phonetics[c]#@mail-#i#-#c#.com"), password=standardPassword, passwordConfirmation=standardPassword)>
			
			<!--- put them in a category --->
			<cfloop from="1" to="6" index="d">
				<cfset model("ContactCategory").create(contactid=contact.key(),categoryid=d)>
			</cfloop>
		</cfloop>

		<!--- setup the API --->
		<cfset model("APIOwners").create(ownerid=owner.key(), apiid=1)>

		<!--- create sites --->
		<cfloop from="1" to="1" index="s">
			
			<cfset site = model("site").create(ownerid=owner.key(), layoutid=s, itemtemplatewidgetid=6, name="#titleize(loc.key)# Website", liveat=DateAdd("m",-24,Now()))>
			
			<!--- domains --->
			<cfset model("domain").create(siteid=site.key(), name="localhost")>
			<cfset model("domain").create(siteid=site.key(), name="compass")>
			<cfset model("domain").create(siteid=site.key(), name=loc.domain)>
			<cfset model("domain").create(siteid=site.key(), name="#loc.key#.com")>
			
			<!--- site contacts (CRM) --->
			<cfloop from="1" to="26" index="c">
				<cfset newPerson = model("person").new(entitytypeid=get("entityTypeStruct").contact, firstname=names[c], lastname=nouns[$complementary(c)], email=LCase("#names[c]#.#nouns[$complementary(c)]#.#i#@#c#mail.com"), password=standardPassword, passwordConfirmation=standardPassword)>
				<cfset contact = model("contact").new(ownerid=owner.key(), siteid=site.key(), entitytypeid=get("entityTypeStruct").site, person=newPerson).save()>
			</cfloop>

			<!--- attributes --->
			<cfset colour = model("attribute").create(siteid=site.key(), name="Colour", isSearchable=true)><!--- set options --->
			<cfset red = model("attributeOption").create(attributeid=colour.key(), value="Red", sequence=1)>
			<cfset Purple = model("attributeOption").create(attributeid=colour.key(), value="Purple", sequence=2)>
			<cfset Violet = model("attributeOption").create(attributeid=colour.key(), value="Violet", sequence=3)>
			<cfset Blue = model("attributeOption").create(attributeid=colour.key(), value="Blue", sequence=4)>
			<cfset Green = model("attributeOption").create(attributeid=colour.key(), value="Green", sequence=5)>
			<cfset Yellow = model("attributeOption").create(attributeid=colour.key(), value="Yellow", sequence=6)>
			<cfset Orange = model("attributeOption").create(attributeid=colour.key(), value="Orange", sequence=7)>
			<cfset Black = model("attributeOption").create(attributeid=colour.key(), value="Black", sequence=8)>
			<cfset White = model("attributeOption").create(attributeid=colour.key(), value="White", sequence=9)>
			<cfset Silver = model("attributeOption").create(attributeid=colour.key(), value="Silver", sequence=10)>

			<cfset price = model("attribute").create(siteid=site.key(), name="Price", isSearchable=true)>			<!--- numeric free text --->
			<cfset _year = model("attribute").create(siteid=site.key(), name="Year", isSearchable=true)>			<!--- numeric free text --->

			<cfset make = model("attribute").create(siteid=site.key(), name="Make", isSearchable=true)>			<!--- set options --->	
				<cfset holden = model("attributeOption").create(attributeid=make.key(), value="Holden", sequence=1)>
				<cfset ford = model("attributeOption").create(attributeid=make.key(), value="Ford", sequence=2)>
				<cfset chevrolet = model("attributeOption").create(attributeid=make.key(), value="Chevrolet", sequence=3)>
				<cfset nissan = model("attributeOption").create(attributeid=make.key(), value="Nissan", sequence=4)>
				<cfset dodge = model("attributeOption").create(attributeid=make.key(), value="Dodge", sequence=5)>
			
			<!--- TODO: nested attributes --->
			<cfset _model = model("attribute").create(siteid=site.key(), name="Model", isSearchable=false)>			<!--- set options --->	
				<cfset modelAttributeOptions = []>
				<cfset monaro = model("attributeOption").create(attributeid=_model.key(), value="Torana", sequence=1)>
				<cfset torana = model("attributeOption").create(attributeid=_model.key(), value="Monaro", sequence=2)>
				<cfset falcon = model("attributeOption").create(attributeid=_model.key(), value="Falcon", sequence=3)>
				<cfset mustang = model("attributeOption").create(attributeid=_model.key(), value="Mustang", sequence=4)>
				<cfset camaro = model("attributeOption").create(attributeid=_model.key(), value="Camaro", sequence=5)>
				<cfset corvette = model("attributeOption").create(attributeid=_model.key(), value="Corvette", sequence=6)>
				<cfset skyline = model("attributeOption").create(attributeid=_model.key(), value="Skyline", sequence=7)>
				<cfset superbee = model("attributeOption").create(attributeid=_model.key(), value="Super Bee", sequence=8)>
				<cfset viper = model("attributeOption").create(attributeid=_model.key(), value="Viper", sequence=9)>

			<cfset engine = model("attribute").create(siteid=site.key(), name="Engine", isSearchable=false)>		<!--- free text --->
			
			<cfset features = model("attribute").create(siteid=site.key(), name="Features", isSearchable=true)>	<!--- multiple --->
				<cfset powersteer = model("attributeOption").create(attributeid=features.key(), value="Power Steering", sequence=1)>
				<cfset aircon = model("attributeOption").create(attributeid=features.key(), value="Air Conditioning", sequence=2)>
				<cfset sunroof = model("attributeOption").create(attributeid=features.key(), value="Sunroof", sequence=3)>
				<cfset alloywheels = model("attributeOption").create(attributeid=features.key(), value="Alloy Wheels", sequence=4)>
				<cfset automatic = model("attributeOption").create(attributeid=features.key(), value="Automatic Transmisson", sequence=5)>
				<cfset manual = model("attributeOption").create(attributeid=features.key(), value="Manual Transmisson", sequence=6)>

			<!--- categories --->
			<cfset musclecar = model("category").create(siteid=site.key(), ownerid=owner.key(), entitytypeid=get("entityTypeStruct").site, name="Muscle Car")>
			<cfset turbo = model("category").create(siteid=site.key(), ownerid=owner.key(), entitytypeid=get("entityTypeStruct").site, name="Turbocharged")>
			<cfset hotrod = model("category").create(siteid=site.key(), ownerid=owner.key(), entitytypeid=get("entityTypeStruct").site, name="Hot Rod")>
			<cfset racing = model("category").create(siteid=site.key(), ownerid=owner.key(), entitytypeid=get("entityTypeStruct").site, name="Racing")>
			<cfset cruiser = model("category").create(siteid=site.key(), ownerid=owner.key(), entitytypeid=get("entityTypeStruct").site, name="Cruiser")>
			<cfset classic = model("category").create(siteid=site.key(), ownerid=owner.key(), entitytypeid=get("entityTypeStruct").site, name="Classic")>
			
			<!--- items & assets --->
			<cfinclude template="../squirrel/items/pages/home/create.cfm" />
			<cfinclude template="../squirrel/items/pages/about/create.cfm" />
			<cfinclude template="../squirrel/items/pages/contact/create.cfm" />
			<cfinclude template="../squirrel/items/chevrolet/Camaro1stGen/create.cfm" />
			<cfinclude template="../squirrel/items/chevrolet/Camaro5thGen/create.cfm" />
			<cfinclude template="../squirrel/items/chevrolet/c3Corvette/create.cfm" />
			<cfinclude template="../squirrel/items/chevrolet/c6Corvette/create.cfm" />
			<cfinclude template="../squirrel/items/dodge/superbee/create.cfm" />
			<cfinclude template="../squirrel/items/dodge/viper/create.cfm" />
			<cfinclude template="../squirrel/items/ford/boss/create.cfm" />
			<cfinclude template="../squirrel/items/ford/cobra/create.cfm" />
			<cfinclude template="../squirrel/items/ford/gtho/create.cfm" />
			<cfinclude template="../squirrel/items/ford/mach1/create.cfm" />
			<cfinclude template="../squirrel/items/holden/350Monaro/create.cfm" />
			<cfinclude template="../squirrel/items/holden/L34/create.cfm" />
			<cfinclude template="../squirrel/items/holden/MonaroCoupe/create.cfm" />
			<cfinclude template="../squirrel/items/holden/xu1/create.cfm" />
			<cfinclude template="../squirrel/items/nissan/gtr/create.cfm" />

			<!--- copy the logo --->
			<cffile action="copy" source="#ExpandPath('squirrel/logo.jpg')#" destination="#ExpandPath('/compass/files/#owner.key()#/#site.key()#/logo.jpg')#">

			<!--- custom layouts --->
			<cfset layout = model("layout").create(siteid=site.key(), name="#titleize(loc.key)# Layout", slug="#loc.key#")>
			<!--- widgets --->
			<cfset listWidget = model("widget").create(name="List Widget", slug="list-one", iscategorywidget=true)>										<!--- category --->
			<cfset featureWidget = model("widget").create(name="Feature Item Widget One", slug="feature-item-one", isitemwidget=true, minimumitemcount=1, maximumitemcount=1)>	<!--- items : one --->
			<cfset contentWidget = model("widget").create(name="Content Item Widget", slug="content-one", isitemwidget=true, minimumitemcount=1, maximumitemcount=1)>	<!--- items : one --->
			<cfset contactFormWidget = model("widget").create(name="Contact Form Widget", slug="contact-form")>																<!--- no data required : eg. weather widget, google ads --->
			<cfset registerFormWidget = model("widget").create(name="Register Form Widget", slug="register-one")>																<!--- no data required : eg. weather widget, google ads --->
			<cfset searchWidget = model("widget").create(name="Search Widget", slug="search-one")>															<!--- no data required : eg. weather widget, google ads --->
			<cfset galleryWidget = model("widget").create(name="Photo Gallery Widget", slug="photo-gallery", isitemwidget=true, minimumitemcount=3, maximumitemcount=6)>	<!--- item : between 3 and 6 --->
			<cfset promoWidget = model("widget").create(name="Promo Items Widget", slug="promo-items", isitemwidget=true, minimumitemcount=3)>						<!--- item : min of 3 --->
			<cfset popularWidget = model("widget").create(name="Popular Items Widget", slug="popular-items", isitemwidget=true, maximumitemcount=6)>						<!--- item : max of 6 --->
			<cfset weatherWidget = model("widget").create(name="Weather Widget", slug="weather")>															<!--- no data required : eg. weather widget, google ads --->

			<!--- standard templates & widget bridge records --->
			<cfset homePageTemplate = model("template").create(name="Home Page Template", slug="home-page-one")>
				<!--- TODO: do i need a homepage widget? --->
				<cfset home_contentTemplateWidget = model("templatewidget").create(templateid=homePageTemplate.key(), widgetid=contentWidget.key())>
				<cfset home_promoTemplateWidget = model("templatewidget").create(templateid=homePageTemplate.key(), widgetid=promoWidget.key())>
				<cfset home_weatherTemplateWidget = model("templatewidget").create(templateid=homePageTemplate.key(), widgetid=weatherWidget.key())>
				<!--- use the same widget twice --->
				<cfset home_galleryTemplateWidget_1 = model("templatewidget").create(templateid=homePageTemplate.key(), widgetid=galleryWidget.key())>
				<cfset home_galleryTemplateWidget_2 = model("templatewidget").create(templateid=homePageTemplate.key(), widgetid=galleryWidget.key())>

			<cfset itemTemplateOne = model("template").create(name="Item Template One", slug="item-one")>
				<cfset itemOne_featureTemplateWidget = model("templatewidget").create(templateid=itemTemplateOne.key(), widgetid=featureWidget.key())>
				<cfset itemOne_popularTemplateWidget = model("templatewidget").create(templateid=itemTemplateOne.key(), widgetid=popularWidget.key())>

			<cfset itemTemplateTwo = model("template").create(name="Item Template Two", slug="item-two")>
				<cfset itemTwo_contentTemplateWidget = model("templatewidget").create(templateid=itemTemplateTwo.key(), widgetid=contentWidget.key())>

			<cfset listTemplate = model("template").create(name="List Template", slug="list-one")>
				<cfset list_listTemplateWidget = model("templatewidget").create(templateid=listTemplate.key(), widgetid=listWidget.key())>

			<cfset searchTemplate = model("template").create(name="Search Template", slug="search-one")>
				<cfset search_searchTemplateWidget = model("templatewidget").create(templateid=searchTemplate.key(), widgetid=searchWidget.key())>

			<cfset registerTemplate = model("template").create(name="Register Template", slug="register-one")>
				<cfset register_registerTemplateWidget = model("templatewidget").create(templateid=registerTemplate.key(), widgetid=registerFormWidget.key())>

			<!--- custom templates --->
			<cfset showcaseTemplate = model("template").create(siteid=site.key(), name="Showcase Car (#loc.key#)", slug="item-#loc.key#-showcase-car")>
				<cfset showcase_contentTemplateWidget = model("templatewidget").create(templateid=showcaseTemplate.key(), widgetid=contentWidget.key())>
				<cfset showcase_galleryTemplateWidget = model("templatewidget").create(templateid=showcaseTemplate.key(), widgetid=galleryWidget.key())>
				<cfset showcase_weatherTemplateWidget = model("templatewidget").create(templateid=showcaseTemplate.key(), widgetid=weatherWidget.key())>

			<!--- pages --->
			<cfset homepage = model("page").create(siteid=site.key(), templateid=homePageTemplate.key(), name="Home Page", slug="home-page", ishome=1)>
				<cfset model("pageresource").create(pageid=homepage.key(), widgetid=contentWidget.key(), templatewidgetid=home_contentTemplateWidget.key(), itemid=item_home.key())>
				<cfset model("pageresource").create(pageid=homepage.key(), widgetid=promoWidget.key(), templatewidgetid=home_promoTemplateWidget.key(), itemid=item_mach1.key())>
				<cfset model("pageresource").create(pageid=homepage.key(), widgetid=promoWidget.key(), templatewidgetid=home_promoTemplateWidget.key(), itemid=item_boss.key())>
				<cfset model("pageresource").create(pageid=homepage.key(), widgetid=promoWidget.key(), templatewidgetid=home_promoTemplateWidget.key(), itemid=item_gtho.key())>

			<cfset aboutpage = model("page").create(siteid=site.key(), templateid=itemTemplateTwo.key(), name="About #titleize(loc.key)#", slug="about-#loc.key#")>
				<cfset model("pageresource").create(pageid=aboutpage.key(), widgetid=contentWidget.key(), templatewidgetid=itemTwo_contentTemplateWidget.key(), itemid=item_about.key())>

			<cfset contactpage = model("page").create(siteid=site.key(), templateid=itemTemplateTwo.key(), name="Contact Us", slug="contact")>
				<cfset model("pageresource").create(pageid=contactpage.key(), widgetid=contentWidget.key(), templatewidgetid=itemTwo_contentTemplateWidget.key(), itemid=item_contact.key())>

			<cfset registerpage = model("page").create(siteid=site.key(), templateid=registerTemplate.key(), name="Register", slug="register")>
				<cfset model("pageresource").create(pageid=registerpage.key(), widgetid=registerFormWidget.key(), templatewidgetid=register_registerTemplateWidget.key())>
 
			<cfset searchpage = model("page").create(siteid=site.key(), templateid=searchTemplate.key(), name="Search", slug="search")>

			<cfset racingpage = model("page").create(siteid=site.key(), templateid=listTemplate.key(), name="Racing", slug="racing")>
				<cfset model("pageresource").create(pageid=racingpage.key(), widgetid=listWidget.key(), templatewidgetid=list_listTemplateWidget.key(), categoryid=racing.key())>

			<!--- menus --->
			<cfset menu = model("menu").create(siteid=site.key(), name="Main Menu", isdefault=1)>

			<!--- create links to pages --->
			<cfset pages = model("page").findAllBySiteid(value=site.key())>
			<cfloop query="pages">
				<cfset model("menuLink").create(menuid=menu.key(), pageid=pages.id, text=pages.name)>
			</cfloop>
			<cfset makeLink = model("menuLink").create(menuid=menu.key(), text="Makes")>
			<cfset model("menuLink").create(menuid=menu.key(), parentid=makeLink.key(), text="Chevrolet", href="http://www.chevrolet.com")>
			<cfset model("menuLink").create(menuid=menu.key(), parentid=makeLink.key(), text="Dodge", href="http://www.dodge.com")>
			<cfset model("menuLink").create(menuid=menu.key(), parentid=makeLink.key(), text="Ford", href="http://www.ford.com")>
			<cfset model("menuLink").create(menuid=menu.key(), parentid=makeLink.key(), text="Holden", href="http://www.holden.com.au")>
			<cfset model("menuLink").create(menuid=menu.key(), parentid=makeLink.key(), text="Nissan", href="http://www.nissan.com")>

		</cfloop>
	</cffunction>


	<!--- THE definitive site to test with.. add data to this site as first priority --->
	<!--- TODO: this property website data is not complete.....!!!!! --->
	<cffunction name="createCorePropertySite">
		
		<cfset var loc = {}>
		<cfset loc.address = "19 Carrington Street, Hawthorn">
		<cfset loc.key = "nineteen-carrington-street-hawthorn">
		<cfset loc.domain = "19carrington.com">
		<cfset loc.ownerName = "Plus Real Estate">
		<cfset loc.ownerDomain = "plusrealestate.com">

		<!--- create owner --->
		<cfset owner = model("Owner").create(
				name=loc.ownerName
				,tradingname=loc.ownerName & " Pty Ltd"
				,phone="9876 1234"
				,email="mail@#loc.ownerDomain#"
				,statustypeid=0
				,website=loc.ownerDomain
				)>
		
		<!--- addresses --->
		<cfset model("address").create(ownerid=owner.key(), addresstypeid=1, entitytypeid=get("entityTypeStruct").owner, streetnumber=10, streetname='Brunswick Street', town="Fitzroy", postcode=3004, state="VIC", country="Australia")>
		<cfset model("address").create(ownerid=owner.key(), addresstypeid=2, entitytypeid=get("entityTypeStruct").owner, streetnumber=22, streetname='Collins Street', town="Melbourne", postcode=3000, state="VIC", country="Australia")>
		<!--- people --->
		<cfset model("person").new(ownerid=owner.key(), entitytypeid=get("entityTypeStruct").owner, firstname="Adam", lastname="Chapman", email="adam.chapman@#loc.ownerDomain#", password=standardPassword, passwordConfirmation=standardPassword, lastLoginAt=Now(), lastLoginAttemptAt=Now(), lastLoginAttemptIPAddress=CGI.remote_addr).save()>
		<cfset model("person").new(ownerid=owner.key(), entitytypeid=get("entityTypeStruct").owner, firstname="Leroy", lastname="Mah", email="leroy.mah@#loc.ownerDomain#", password=standardPassword, passwordConfirmation=standardPassword).save()>
		<!--- a pending person.. (hasn't logged in yet) --->
		<cfset model("person").new(ownerid=owner.key(), entitytypeid=get("entityTypeStruct").owner, firstname="Eddie", lastname="Lynch", email="eddie.lynch@#loc.ownerDomain#", password=standardPassword, passwordConfirmation=standardPassword, resetToken=CreateUUID(), tokenExpiresAt=Now()).save()>
		<!--- someone to test with --->
		<cfset model("person").new(ownerid=owner.key(), entitytypeid=get("entityTypeStruct").owner, firstname="Chick", lastname="Hicks", email="chick.hicks@#loc.ownerDomain#", password=standardPassword, passwordConfirmation=standardPassword).save()>

		<!--- owner categories (for contacts) --->
		<!--- <cfset categories = []>
		<cfset categories[1] = model("category").create(ownerid=owner.key(), entitytypeid=get("entityTypeStruct").contact, name="Suppliers")>
		<cfset categories[2] = model("category").create(ownerid=owner.key(), entitytypeid=get("entityTypeStruct").contact, name="Importers")>
		<cfset categories[3] = model("category").create(ownerid=owner.key(), entitytypeid=get("entityTypeStruct").contact, name="Muscle Car Owners")>
		<cfset categories[4] = model("category").create(ownerid=owner.key(), entitytypeid=get("entityTypeStruct").contact, name="Turbo Owners")>
		<cfset categories[5] = model("category").create(ownerid=owner.key(), entitytypeid=get("entityTypeStruct").contact, name="Hot Rodders")>
		<cfset categories[6] = model("category").create(ownerid=owner.key(), entitytypeid=get("entityTypeStruct").contact, name="Other")>
 --->
		<!--- create some owner contacts (CRM) --->
		<!--- <cfloop from="1" to="6" index="c">
			<cfset newPerson = model("person").new(entitytypeid=get("entityTypeStruct").contact, firstname=names[$complementary(c)], lastname=phonetics[c], email=LCase("#names[$complementary(c)]#.#phonetics[c]#@mail-#i#-#c#.com"), password=standardPassword, passwordConfirmation=standardPassword)>
			<cfset contact = model("contact").new(ownerid=owner.key(), entitytypeid=get("entityTypeStruct").owner, person=newPerson)>
			<cfset contact.save()>
			<!--- put them in a category --->
			<cfloop from="1" to="6" index="d">
				<cfset model("contactcategory").create(contactid=contact.key(),categoryid=d)>
			</cfloop>
		</cfloop> --->

		<!--- create sites --->
		<cfloop from="1" to="1" index="s">
			
			<cfset site = model("site").create(ownerid=owner.key(), layoutid=s, itemtemplatewidgetid=0, name="#loc.address# Property Website", liveat=DateAdd("m",-24,Now()))>
			
			<!--- domains --->
			<cfset model("domain").create(siteid=site.key(), name=loc.domain)>

			<!--- site contacts (CRM) --->
			<!--- <cfloop from="1" to="26" index="c">
				<cfset newPerson = model("person").new(entitytypeid=get("entityTypeStruct").contact, firstname=names[c], lastname=nouns[$complementary(c)], email=LCase("#names[c]#.#nouns[$complementary(c)]#.#i#@#c#mail.com"), password=standardPassword, passwordConfirmation=standardPassword)>
				<cfset contact = model("contact").new(ownerid=owner.key(), siteid=site.key(), entitytypeid=get("entityTypeStruct").site, person=newPerson).save()>
			</cfloop> --->

			<cfset bed = model("attribute").create(siteid=site.key(), name="Bedrooms", isSearchable=false)>
			<cfset bath = model("attribute").create(siteid=site.key(), name="Bathrooms", isSearchable=false)>
			<cfset carport = model("attribute").create(siteid=site.key(), name="Carports", isSearchable=false)>
			<cfset garage = model("attribute").create(siteid=site.key(), name="Garages", isSearchable=false)>
			<cfset price = model("attribute").create(siteid=site.key(), name="Price", isSearchable=false)>

			<!--- TODO: mutliple option entries.. eg: OFI --->
			<cfset features = model("attribute").create(siteid=site.key(), name="Features", isSearchable=false)>	<!--- multiple --->
			<cfset featureArray = []>
			<cfset arrayAppend(featureArray, model("attributeOption").create(attributeid=features.key(), value="Study", sequence=1))>
			<cfset arrayAppend(featureArray, model("attributeOption").create(attributeid=features.key(), value="Ensuite", sequence=2))>
			<cfset arrayAppend(featureArray, model("attributeOption").create(attributeid=features.key(), value="Air Conditioning", sequence=3))>
			<cfset arrayAppend(featureArray, model("attributeOption").create(attributeid=features.key(), value="Ducted Heating", sequence=4))>
			<cfset arrayAppend(featureArray, model("attributeOption").create(attributeid=features.key(), value="Walk-In Robe", sequence=5))>
			<cfset arrayAppend(featureArray, model("attributeOption").create(attributeid=features.key(), value="Open Fireplace", sequence=6))>
			<cfset arrayAppend(featureArray, model("attributeOption").create(attributeid=features.key(), value="Theatre Room", sequence=7))>

			<!--- items & assets --->
			<cfset carringtonPath = expandPath("squirrel/property/carrington/")>
			<cffile action="read" file="#carringtonPath#text.txt" variable="item_text" />
			<cfset item = model("Item").create(siteid=site.key(), headline=loc.address, blurb="Location! Location!! Location!!!", body=item_text)>
			<!--- attrs --->
			<cfloop array="#featureArray#" index="f">
				<cfset model("itemAttributeOptions").create(itemid=item.key(), attributeid=features.key(), attributeoptionid=f.key())>
			</cfloop>

			<!--- text attrs --->
			<cfset model("itemAttributeValues").create(itemid=item.key(), attributeid=price.key(), value="One MILLION Dollars!")>
			<cfset model("itemAttributeValues").create(itemid=item.key(), attributeid=bed.key(), value=5)>
			<cfset model("itemAttributeValues").create(itemid=item.key(), attributeid=bath.key(), value=2)>
			<cfset model("itemAttributeValues").create(itemid=item.key(), attributeid=carport.key(), value=1)>
			<cfset model("itemAttributeValues").create(itemid=item.key(), attributeid=garage.key(), value=2)>

			<!--- assets --->
			<cfdirectory action="list" directory="#carringtonPath#" name="files" />
			<cfset cnt=0>
			<cfloop query="files">
				<cfif ListFind("txt,cfm", listLast(files.name, ".")) eq 0>
					<cfset cnt++>
					<cfset loc.dirPath = "#$compassItemAssetsFolderRoot(owner.key(), site.key())##item.key()#/">
					<cfset loc.filePath = "#files.directory#\#files.name#">
					<cfset loc.fileName = "photo_#cnt#.#ListLast(loc.filePath,".")#">
					<cfset loc.filedesc = ListFirst(GetFileFromPath(loc.filePath), ".")>
					<cfset loc.filedesc = Replace(loc.filedesc,"-"," ","all")>
					<cfset loc.filedesc = Replace(loc.filedesc,"_"," ","all")>
					<cfset loc.mimetype = LCase(ListLast(loc.fileName, "."))>
					<cfset loc.file = ListDeleteAt(loc.fileName, ListLen(loc.fileName,"."), ".")>
					<cfif ! DirectoryExists(loc.dirPath)>
						<cfdirectory action="create" directory="#loc.dirPath#">
					</cfif>
					<cfset model("itemAsset").create(itemid=item.key(), name=loc.filedesc, filename=loc.fileName, mimetype=ListLast(loc.filePath,"."), publishedat=now(), sequence=cnt)>
					<cffile	action="copy" source="#loc.filePath#" destination="#loc.dirPath##loc.fileName#">

					<cfset loc.source = ImageNew("#loc.dirPath##loc.fileName#")>
					<cfloop list="600,400,200,100,50" index="i">
						<cfset loc.destination = loc.dirPath & "#loc.file#-x#i#.#loc.mimetype#">
						<cfset ImageSetAntialiasing(loc.source,"on")>  
						<cfset ImageScaleToFit(loc.source,i,i)>
						<cfset ImageWrite(loc.source, loc.destination)>
					</cfloop>

				</cfif>
			</cfloop>

			<!--- custom layouts --->
			<cfset layout = model("layout").create(name="Predator Layout", slug="predator")>
			
			<!--- widgets --->
			<cfset heroWidget = model("widget").create(name="Hero", slug="hero-one", isitemwidget=true, minimumitemcount=1, maximumitemcount=1)>
			<cfset slideShowWidget = model("widget").create(name="Slideshow", slug="slideshow-one", isitemwidget=true, minimumitemcount=1, maximumitemcount=1)>
			<cfset mapWidget = model("widget").create(name="Map", slug="map-one", isitemwidget=true, minimumitemcount=1, maximumitemcount=1)>
			<cfset multiAttributeValueWidget = model("widget").create(name="Multi Attribute Widget", slug="multi-one", isitemwidget=true, minimumitemcount=1, maximumitemcount=1)>
			<cfset contactFormWidget = model("widget").create(name="Contact Form", slug="contact-form-one", isitemwidget=true, minimumitemcount=1, maximumitemcount=1)>

			<!--- standard templates & widget bridge records --->
			<!--- home --->
			<cfset homeTemplate = model("template").create(name="Predator Home Page Template", slug="home-page-predator")>
				<cfset model("templatewidget").create(templateid=homeTemplate.key(), widgetid=contentWidget.key())>
				<cfset model("templatewidget").create(templateid=homeTemplate.key(), widgetid=slideShowWidget.key())>
			<!--- about --->
			<cfset aboutTemplate = model("template").create(name="Predator About Page Template", slug="item-about-predator")>
				<cfset model("templatewidget").create(templateid=aboutTemplate.key(), widgetid=contentWidget.key())>
				<cfset model("templatewidget").create(templateid=aboutTemplate.key(), widgetid=heroWidget.key())>
			<!--- gallery --->
			<cfset galleryTemplate = model("template").create(name="Predator Gallery Template", slug="item-gallery-predator")>
				<cfset model("templatewidget").create(templateid=galleryTemplate.key(), widgetid=galleryWidget.key())>
			<!--- location --->
			<cfset locationTemplate = model("template").create(name="Predator Location Template", slug="item-location-predator")>
				<cfset model("templatewidget").create(templateid=locationTemplate.key(), widgetid=mapWidget.key())>
			<!--- inspection --->
			<cfset inspectionTemplate = model("template").create(name="Predator Inspection Template", slug="item-inspection-predator")>
				<cfset model("templatewidget").create(templateid=inspectionTemplate.key(), widgetid=multiAttributeValueWidget.key())>
			<!--- contact --->
			<cfset contactTemplate = model("template").create(name="Predator Contact Template", slug="item-contact-predator")>
				<cfset model("templatewidget").create(templateid=contactTemplate.key(), widgetid=contactFormWidget.key())>

			<!--- pages --->
			<cfset homepage = model("page").create(siteid=site.key(), templateid=homeTemplate.key(), name="Home", slug="home", ishome=1)>
				<cfset model("pageresource").create(pageid=homepage.key(), widgetid=contentWidget.key(), itemid=item.key())>
				<cfset model("pageresource").create(pageid=homepage.key(), widgetid=slideShowWidget.key(), itemid=item.key())>

			<cfset aboutpage = model("page").create(siteid=site.key(), templateid=aboutTemplate.key(), name="About", slug="about")>
				<cfset model("pageresource").create(pageid=aboutpage.key(), widgetid=contentWidget.key(), itemid=item.key())>
				<cfset model("pageresource").create(pageid=aboutpage.key(), widgetid=heroWidget.key(), itemid=item.key())>

			<cfset gallerypage = model("page").create(siteid=site.key(), templateid=galleryTemplate.key(), name="Gallery", slug="gallery")>
				<cfset model("pageresource").create(pageid=gallerypage.key(), widgetid=galleryWidget.key(), itemid=item.key())>

			<cfset locationpage = model("page").create(siteid=site.key(), templateid=locationTemplate.key(), name="Location", slug="location")>
				<cfset model("pageresource").create(pageid=locationpage.key(), widgetid=mapWidget.key(), itemid=item.key())>

			<cfset inspectionpage = model("page").create(siteid=site.key(), templateid=inspectionTemplate.key(), name="Inspection", slug="inspection")>
				<cfset model("pageresource").create(pageid=inspectionpage.key(), widgetid=multiAttributeValueWidget.key(), itemid=item.key())>

			<cfset contactpage = model("page").create(siteid=site.key(), templateid=contactTemplate.key(), name="Contact", slug="contact")>
				<cfset model("pageresource").create(pageid=contactpage.key(), widgetid=contactFormWidget.key(), itemid=item.key())>

			<!--- menus --->
			<cfset menu = model("menu").create(siteid=site.key(), name="Main Menu", isdefault=1)>

			<!--- create links to pages --->
			<cfset pages = model("page").findAllBySiteid(value=site.key())>
			<cfloop query="pages">
				<cfset model("menuLink").create(menuid=menu.key(), pageid=pages.id, text=pages.name, sequence=pages.currentRow)>
			</cfloop>

		</cfloop>
	</cffunction>


	<!--- 
	PRIVATE
	--->
	
	<cffunction name="$compassItemAssetsFolderRoot" access="private">
		<cfargument name="ownerid" type="numeric" required="true">
		<cfargument name="siteid" type="numeric" required="true">
		<cfreturn ExpandPath("/compass/" & get("filePath") & "/#arguments.ownerid#/#arguments.siteid#/itemassets/")>
	</cffunction>

	<!--- gets a corresponding element.. consistent but differnt so names etc dont always start with the same letter --->
	<cffunction name="$complementary" access="private">
		<cfargument name="value" type="numeric" required="true">
		<cfset var loc = {} />
		<cfset loc.return = arguments.value - 10>
		<cfset loc.return = loc.return lt 1 ? 26 + loc.return : loc.return>
		<cfreturn loc.return>
	</cffunction>
	
	<!--- this is to work around the issue with nested properties --->
	<cffunction name="$createOrder" access="private">
		<cfargument name="addressid" type="numeric" required="true">
		<cfargument name="customerid" type="numeric" required="true">
		<cfargument name="serviceid" type="numeric" required="true">
		<cfargument name="statustypeid" type="numeric" required="true">
		<cfargument name="serviceCount" type="numeric" required="true">
		<cfset var loc = {} />
		
		<cfset loc.order = model("order").create(addressid=arguments.addressid, customerid=arguments.customerid, statustypeid=arguments.statustypeid)>
		<cfset loc.order.save()>
		
		<cfset loc.counter = 0>
		<cfloop list="1,6,7,12" index="loc.i">
			<cfset model("OrderService").create(orderid=loc.order.key(), serviceid=loc.i, statustypeid="4#loc.counter#0")>
			<cfset loc.counter++>
			<cfif loc.counter eq arguments.serviceCount>
				<cfbreak>
			</cfif>
		</cfloop>
		
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

	
	<cffunction name="$categoryidByName" access="private">
		<cfargument name="name" type="string" required="true">
		<cfargument name="siteid" type="numeric" required="true">
		<cfreturn model("category").findOne(where="name='#arguments.name#' AND siteid=#arguments.siteid#").key()>
	</cffunction>
	
	<cffunction name="$attributeidByName" access="private">
		<cfargument name="name" type="string" required="true">
		<cfargument name="siteid" type="numeric" required="true">
		<cfreturn model("attribute").findOne(where="name='#arguments.name#' AND siteid=#arguments.siteid#").key()>
	</cffunction>
	
	<cffunction name="$optionByValue" access="private">
		<cfargument name="value" type="string" required="true">
		<cfargument name="siteid" type="numeric" required="true">
		<cfreturn model("attributeOption").findOne(select="id, attributeid", where="value='#arguments.value#' AND siteid=#arguments.siteid#", include="attribute", returnAs="query")>
	</cffunction>
	
	<cffunction name="$itemIntoCategories" access="private">
		<cfargument name="itemid" type="numeric" required="true">
		<cfargument name="list" type="string" required="true">
		<cfset var loc = {}>
		<cfloop list="#arguments.list#" index="loc.i">
			<cfset model("itemCategories").create(itemid=arguments.itemid, variables[i].key())>
		</cfloop>
	</cffunction>

</cfcomponent>
