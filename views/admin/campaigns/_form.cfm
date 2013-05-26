<cfoutput>
	<cfif campaign.isNew()>
		#input(inputType="select", objectName='campaign', property='customerid', options=customers, label='Customer')#
	<cfelse>
		<!--- TODO: maybe show the customer --->
	</cfif>
	#input(inputType="textField", objectName='campaign', property='name', label='Name')#
	#input(inputType="datePicker", objectName='campaign', property='startat', label='Start Date')#
	#input(inputType="datePicker", objectName='campaign', property='finishat', label='End Date')#
</cfoutput>