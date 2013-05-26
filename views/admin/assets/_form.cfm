<cfoutput>
	#input(inputType="textField", objectName='asset', property='campaignid', label='Campaignid')#
	#input(inputType="textField", objectName='asset', property='publisherid', label='Publisherid')#
	#input(inputType="textField", objectName='asset', property='name', label='Name')#
	<cfif ! asset.isNew()>
		<!--- TODO: generate URLs in model.. --->
		#input(inputType="textFieldTag", name='_void', value="#generateURL(asset.key())#", label='#get('appName')# URL', disabled="true", class="span6")#
	</cfif>
	#input(inputType="textField", objectName='asset', property='destinationurl', label='Destination URL', class="span6")#
	#input(inputType="datePicker", objectName='asset', property='startat', label='Start')#
	#input(inputType="datePicker", objectName='asset', property='finishat', label='End')#
	#input(inputType="textArea", objectName='asset', property='notes', label='Notes')#
</cfoutput>