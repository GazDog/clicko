<cfcomponent extends="wheelsMapping.Test">
    
	<!--- include helper functions --->
	<cfinclude template="../helpers.cfm">

	<!--- setup runs before every test --->
    <cffunction name="setup">
    	<!--- save the orginal environment --->
		<cfset loc.originalApplication = Duplicate(application)>
		<!--- set transaction mode to rollback, so no records are affected --->
		<cfset application.wheels.transactionMode = "rollback">
        <!--- create an instance of our Publisher --->
        <cfset loc.publisher = model("Publisher").new()>
        <!--- a struct used to set valid model property values --->
        <cfset loc.validProperties = {
        	customerid=1,
			name='name_string',
			website='website_string',
			contactname='contactname_string',
			phone='phone_string',
			email='email_string',
			statusid=1
        }>
        <!--- a struct used to set invalid model property values --->
        <cfset loc.invalidProperties = {
        	customerid='abcd',
			name='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
			website='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
			contactname='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
			phone='xxxxxxxxxxxxxxxxx',
			email='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
			statusid='abcd'
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
    <cffunction name="test_publisher_is_valid">
		<!--- set the properties of the model --->
		<cfset loc.publisher.setProperties(loc.validProperties)>
		<cfset loc.result = loc.publisher.valid()>
		<cfset assert("loc.result","loc.publisher.allErrors()")>
	</cffunction>

	<!--- assert the model is invalid when no properties are set --->
	<cffunction name="test_publisher_is_not_valid">
		<cfset loc.publisher.setProperties(loc.invalidProperties)>
        <cfset assert("! loc.publisher.valid()")>
	</cffunction>

	<!--- assert the model creates successfully --->
	<cffunction name="test_publisher_create">
		<!--- set the properties of the model --->
		<cfset loc.publisher.setProperties(loc.validProperties)>
		<cfset loc.result = loc.publisher.save()>
        <cfset assert("loc.result", "loc.publisher.allErrors()")>
	</cffunction>

	<!--- assert the model updates successfully --->
	<cffunction name="test_publisher_update">
		<cfset loc.publisher = model("publisher").findOne()>
		<cfset loc.publisher.setProperties(loc.validProperties)>
		<cfset loc.result = loc.publisher.update()>
        <cfset assert("loc.result", "loc.publisher.allErrors()")>
	</cffunction>

	<!--- assert the model deletes successfully --->
	<cffunction name="test_publisher_delete">
		<cfset loc.publisher = model("publisher").findOne()>
		<cfset loc.result = loc.publisher.delete()>
        <cfset assert("loc.result")>
	</cffunction>

</cfcomponent>
