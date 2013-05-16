<h1>Create a New publisher</h1>

<cfoutput>#includePartial("showFlash")#</cfoutput>

<cfoutput>

			
			
			#errorMessagesFor("publisher")#
	
			#startFormTag(action="create")#
		
				
																
				
					
						#textField(objectName='publisher', property='customerid', label='Customerid')#
																
				
					
						#textField(objectName='publisher', property='name', label='Name')#
																
				
					
						#textField(objectName='publisher', property='website', label='Website')#
																
				
					
						#textField(objectName='publisher', property='contactname', label='Contactname')#
																
				
					
						#textField(objectName='publisher', property='phone', label='Phone')#
																
				
					
						#textField(objectName='publisher', property='email', label='Email')#
																
				
					
						#textField(objectName='publisher', property='statusid', label='Statusid')#
																
				
																
				
																
				
																
				

				#submitTag()#
				
			#endFormTag()#
			
		

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
