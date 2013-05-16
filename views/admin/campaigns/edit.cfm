<h1>Editing campaign</h1>

<cfoutput>#includePartial("showFlash")#</cfoutput>

<cfoutput>

			
			#errorMessagesFor("campaign")#
	
			#startFormTag(action="update", key=params.key)#
		
				
															
				
					
						#textField(objectName='campaign', property='customerid', label='Customerid')#
															
				
					
						#textField(objectName='campaign', property='name', label='Name')#
															
				
					
						#dateTimeSelect(objectName='campaign', property='startat', dateOrder='year,month,day', monthDisplay='abbreviations', label='Startat')#
															
				
					
						#dateTimeSelect(objectName='campaign', property='finishat', dateOrder='year,month,day', monthDisplay='abbreviations', label='Finishat')#
															
				
					
						#textField(objectName='campaign', property='creatoruserid', label='Creatoruserid')#
															
				
															
				
															
				
															
				
				
				#submitTag()#
				
			#endFormTag()#
			
		

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
