<h1>Create a New asset</h1>

<cfoutput>#includePartial("showFlash")#</cfoutput>

<cfoutput>

			
			
			#errorMessagesFor("asset")#
	
			#startFormTag(action="create")#
		
				
																
				
					
						#textField(objectName='asset', property='campaignid', label='Campaignid')#
																
				
					
						#textField(objectName='asset', property='publisherid', label='Publisherid')#
																
				
					
						#textField(objectName='asset', property='name', label='Name')#
																
				
					
						#textField(objectName='asset', property='sourceurl', label='Sourceurl')#
																
				
					
						#textField(objectName='asset', property='destinationurl', label='Destinationurl')#
																
				
					
						#dateTimeSelect(objectName='asset', property='startat', dateOrder='year,month,day', monthDisplay='abbreviations', label='Startat')#
																
				
					
						#dateTimeSelect(objectName='asset', property='finishat', dateOrder='year,month,day', monthDisplay='abbreviations', label='Finishat')#
																
				
					
						#textField(objectName='asset', property='notes', label='Notes')#
																
				
																
				
																
				
																
				

				#submitTag()#
				
			#endFormTag()#
			
		

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
