<cfcomponent extends="wheelsMapping.Test">
    
	<!--- include helper functions --->
	<cfinclude template="../helpers.cfm">

	<!--- setup runs before every test --->
    <cffunction name="setup">
    	<!--- save the orginal environment --->
		<cfset loc.originalApplication = Duplicate(application)>
		<!--- set transaction mode to rollback, so no records are affected --->
		<cfset application.wheels.transactionMode = "rollback">
        <!--- create an instance of our User --->
        <cfset loc.user = model("User").new()>
        <!--- a struct used to set valid model property values --->
        <cfset loc.validProperties = {
        	agencyid=1,
			isadministrator=1,
			firstname='firstname_string',
			lastname='lastname_string',
			phone='phone_string',
			email='email_string',
			accesslevel=1,
			statusid=1,
			password='password_string',
			salt='salt_string',
			passwordresettoken='passwordresettoken_string',
			passwordresetat=createDateTime(2000,1,1,0,0,0),
			isconfirmed=1,
			emailconfirmationtoken='emailconfirmationtoken_string',
			lastloginat=createDateTime(2000,1,1,0,0,0),
			logincount=1
        }>
        <!--- a struct used to set invalid model property values --->
        <cfset loc.invalidProperties = {
        	agencyid='abcd',
			isadministrator='abcd',
			firstname='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
			lastname='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
			phone='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
			email='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
			accesslevel='abcd',
			statusid='abcd',
			password='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
			salt='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
			passwordresettoken='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
			passwordresetat='efgh',
			isconfirmed='abcd',
			emailconfirmationtoken='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
			lastloginat='efgh',
			logincount='abcd'
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
    <cffunction name="test_user_is_valid">
		<!--- set the properties of the model --->
		<cfset loc.user.setProperties(loc.validProperties)>
		<cfset loc.result = loc.user.valid()>
		<cfset assert("loc.result","loc.user.allErrors()")>
	</cffunction>

	<!--- assert the model is invalid when no properties are set --->
	<cffunction name="test_user_is_not_valid">
		<cfset loc.user.setProperties(loc.invalidProperties)>
        <cfset assert("! loc.user.valid()")>
	</cffunction>

	<!--- assert the model creates successfully --->
	<cffunction name="test_user_create">
		<!--- set the properties of the model --->
		<cfset loc.user.setProperties(loc.validProperties)>
		<cfset loc.result = loc.user.save()>
        <cfset assert("loc.result", "loc.user.allErrors()")>
	</cffunction>

	<!--- assert the model updates successfully --->
	<cffunction name="test_user_update">
		<cfset loc.user = model("user").findOne()>
		<cfset loc.user.setProperties(loc.validProperties)>
		<cfset loc.result = loc.user.update()>
        <cfset assert("loc.result", "loc.user.allErrors()")>
	</cffunction>

	<!--- assert the model deletes successfully --->
	<cffunction name="test_user_delete">
		<cfset loc.user = model("user").findOne()>
		<cfset loc.result = loc.user.delete()>
        <cfset assert("loc.result")>
	</cffunction>

</cfcomponent>
