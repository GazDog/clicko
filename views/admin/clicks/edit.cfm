<h1>Editing click</h1>

<cfoutput>#includePartial("showFlash")#</cfoutput>

<cfoutput>

			
			#errorMessagesFor("click")#
	
			#startFormTag(action="update", key=params.key)#
		
				
															
				
					
						#textField(objectName='click', property='assetid', label='Assetid')#
															
				
					
						#textField(objectName='click', property='ipaddress', label='Ipaddress')#
															
				
					
						#textField(objectName='click', property='browser', label='Browser')#
															
				
					
						#textField(objectName='click', property='browserversion', label='Browserversion')#
															
				
															
				
				
				#submitTag()#
				
			#endFormTag()#
			
		

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
