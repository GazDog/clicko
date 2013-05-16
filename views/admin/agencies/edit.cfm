<h1>Editing agency</h1>

<cfoutput>#includePartial("showFlash")#</cfoutput>

<cfoutput>

			
			#errorMessagesFor("agency")#
	
			#startFormTag(action="update", key=params.key)#
		
				
															
				
					
						#textField(objectName='agency', property='name', label='Name')#
															
				
					
						#textField(objectName='agency', property='streetnumber', label='Streetnumber')#
															
				
					
						#textField(objectName='agency', property='streetname', label='Streetname')#
															
				
					
						#textField(objectName='agency', property='suburb', label='Suburb')#
															
				
					
						#textField(objectName='agency', property='phone', label='Phone')#
															
				
					
						#textField(objectName='agency', property='email', label='Email')#
															
				
					
						#textField(objectName='agency', property='statusid', label='Statusid')#
															
				
					
						#textField(objectName='agency', property='accesslevel', label='Accesslevel')#
															
				
															
				
															
				
															
				
				
				#submitTag()#
				
			#endFormTag()#
			
		

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
