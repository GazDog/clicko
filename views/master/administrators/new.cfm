<h1>Create a New user</h1>

<cfoutput>#includePartial("showFlash")#</cfoutput>

<cfoutput>

			
			
			#errorMessagesFor("user")#
	
			#startFormTag(action="create")#
		
				
																
				
					
						#textField(objectName='user', property='agencyid', label='Agencyid')#
																
				
					
						#checkBox(objectName='user', property='isadministrator', label='Isadministrator')#
																
				
					
						#textField(objectName='user', property='firstname', label='Firstname')#
																
				
					
						#textField(objectName='user', property='lastname', label='Lastname')#
																
				
					
						#textField(objectName='user', property='phone', label='Phone')#
																
				
					
						#textField(objectName='user', property='email', label='Email')#
																
				
					
						#textField(objectName='user', property='accesslevel', label='Accesslevel')#
																
				
					
						#textField(objectName='user', property='statusid', label='Statusid')#
																
				
					
						#textField(objectName='user', property='password', label='Password')#
																
				
					
						#textField(objectName='user', property='salt', label='Salt')#
																
				
					
						#textField(objectName='user', property='passwordresettoken', label='Passwordresettoken')#
																
				
					
						#dateTimeSelect(objectName='user', property='passwordresetat', dateOrder='year,month,day', monthDisplay='abbreviations', label='Passwordresetat')#
																
				
					
						#checkBox(objectName='user', property='isconfirmed', label='Isconfirmed')#
																
				
					
						#textField(objectName='user', property='emailconfirmationtoken', label='Emailconfirmationtoken')#
																
				
					
						#dateTimeSelect(objectName='user', property='lastloginat', dateOrder='year,month,day', monthDisplay='abbreviations', label='Lastloginat')#
																
				
					
						#textField(objectName='user', property='logincount', label='Logincount')#
																
				
																
				
																
				
																
				

				#submitTag()#
				
			#endFormTag()#
			
		

#linkTo(text="Return to the listing", action="index")#
</cfoutput>
