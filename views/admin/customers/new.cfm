<h1>Create a New customer</h1>

<cfoutput>#includePartial("showFlash")#</cfoutput>

<cfoutput>

			
			
			#errorMessagesFor("customer")#
	
			#startFormTag(action="create")#
		
				
																
				
					
						#textField(objectName='customer', property='agencyid', label='Agencyid')#
																
				
					
						#textField(objectName='customer', property='name', label='Name')#
																
				
					
						#textField(objectName='customer', property='website', label='Website')#
																
				
					
						#textField(objectName='customer', property='phone', label='Phone')#
																
				
					
						#textField(objectName='customer', property='email', label='Email')#
																
				
					
						#textField(objectName='customer', property='statusid', label='Statusid')#
																
				
					
						#textField(objectName='customer', property='accesslevel', label='Accesslevel')#
																
				
																
				
																
				
																
				

				#submitTag()#
				
			#endFormTag()#
			
		

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
