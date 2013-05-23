<cfoutput>
	<!--- don't let the user change the owner of the publsiher.. --->
	<cfif publisher.isNew()>
		#input(inputType="select", objectName='publisher', property='customerid', options=customers, label='Customer')#
	</cfif>
	#input(inputType="textField", objectName='publisher', property='name', label='Name')#
	#input(inputType="textField", objectName='publisher', property='website', label='Website')#
	#input(inputType="textField", objectName='publisher', property='contactname', label='Contact Name')#
	#input(inputType="textField", objectName='publisher', property='phone', label='Phone')#
	#input(inputType="textField", objectName='publisher', property='email', label='Email')#
	<!--- #input(inputType="textField", objectName='publisher', property='statusid', label='Statusid')# --->
</cfoutput>