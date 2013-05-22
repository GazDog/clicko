<cfoutput>
	#input(inputType="textField", objectName='user', property='firstname', label='First Name')#
	#input(inputType="textField", objectName='user', property='lastname', label='Last Name')#
	#input(inputType="textField", objectName='user', property='phone', label='Phone')#
	#input(inputType="textField", objectName='user', property='email', label='Email')#
	<!--- #input(inputType="textField", objectName='user', property='accesslevel', label='Access Level')# --->
	<cfif user.isNew()>
		#input(inputType="passwordField", objectName='user', property='password', label='Password')#
		#input(inputType="passwordField", objectName='user', property='passwordConfirmation', label='Confirm Password')#
	</cfif>
</cfoutput>