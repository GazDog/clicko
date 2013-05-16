<h1>Create a New click</h1>

<cfoutput>#includePartial("showFlash")#</cfoutput>

<cfoutput>

			
			
			#errorMessagesFor("click")#
	
			#startFormTag(action="create")#
		
				
																
				
					
						#textField(objectName='click', property='assetid', label='Assetid')#
																
				
					
						#textField(objectName='click', property='ipaddress', label='Ipaddress')#
																
				
					
						#textField(objectName='click', property='browser', label='Browser')#
																
				
					
						#textField(objectName='click', property='browserversion', label='Browserversion')#
																
				
																
				

				#submitTag()#
				
			#endFormTag()#
			
		

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
