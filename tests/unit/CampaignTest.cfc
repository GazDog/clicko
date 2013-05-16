<cfcomponent extends="wheelsMapping.Test">
    
	<!--- include helper functions --->
	<cfinclude template="../helpers.cfm">

	<!--- setup runs before every test --->
    <cffunction name="setup">
    	<!--- save the orginal environment --->
		<cfset loc.originalApplication = Duplicate(application)>
		<!--- set transaction mode to rollback, so no records are affected --->
		<cfset application.wheels.transactionMode = "rollback">
        <!--- create an instance of our Campaign --->
        <cfset loc.campaign = model("Campaign").new()>
        <!--- a struct used to set valid model property values --->
        <cfset loc.validProperties = {
        	customerid=1,
			name='name_string',
			startat=createDateTime(2000,1,1,0,0,0),
			finishat=createDateTime(2000,1,1,0,0,0),
			creatoruserid=1
        }>
        <!--- a struct used to set invalid model property values --->
        <cfset loc.invalidProperties = {
        	customerid='abcd',
			name='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
			startat='efgh',
			finishat='efgh',
			creatoruserid='abcd'
        }>
    </cffunction>
    
    <!--- teardown runs after every test --->
    <cffunction name="teardown">
    	 <!--- re-instate the original application scope --->
        <cfset application = loc.originalApplication />
    </cffunction>

    <!--- assert that setup and teardown pass --->
    <cffunction name="test_setup_and_teardown">  
		<cfset assert("true")>
	</cffunction>

	<!--- assert that because the properties are set correct and meet validation, the model is valid --->
    <cffunction name="test_campaign_is_valid">
		<!--- set the properties of the model --->
		<cfset loc.campaign.setProperties(loc.validProperties)>
		<cfset loc.result = loc.campaign.valid()>
		<cfset assert("loc.result","loc.campaign.allErrors()")>
	</cffunction>

	<!--- assert the model is invalid when no properties are set --->
	<cffunction name="test_campaign_is_not_valid">
		<cfset loc.campaign.setProperties(loc.invalidProperties)>
        <cfset assert("! loc.campaign.valid()")>
	</cffunction>

	<!--- assert the model creates successfully --->
	<cffunction name="test_campaign_create">
		<!--- set the properties of the model --->
		<cfset loc.campaign.setProperties(loc.validProperties)>
		<cfset loc.result = loc.campaign.save()>
        <cfset assert("loc.result", "loc.campaign.allErrors()")>
	</cffunction>

	<!--- assert the model updates successfully --->
	<cffunction name="test_campaign_update">
		<cfset loc.campaign = model("campaign").findOne()>
		<cfset loc.campaign.setProperties(loc.validProperties)>
		<cfset loc.result = loc.campaign.update()>
        <cfset assert("loc.result", "loc.campaign.allErrors()")>
	</cffunction>

	<!--- assert the model deletes successfully --->
	<cffunction name="test_campaign_delete">
		<cfset loc.campaign = model("campaign").findOne()>
		<cfset loc.result = loc.campaign.delete()>
        <cfset assert("loc.result")>
	</cffunction>

</cfcomponent>
