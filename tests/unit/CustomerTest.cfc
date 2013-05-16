<cfcomponent extends="wheelsMapping.Test">
    
	<!--- include helper functions --->
	<cfinclude template="../helpers.cfm">

	<!--- setup runs before every test --->
    <cffunction name="setup">
    	<!--- save the orginal environment --->
		<cfset loc.originalApplication = Duplicate(application)>
		<!--- set transaction mode to rollback, so no records are affected --->
		<cfset application.wheels.transactionMode = "rollback">
        <!--- create an instance of our Customer --->
        <cfset loc.customer = model("Customer").new()>
        <!--- a struct used to set valid model property values --->
        <cfset loc.validProperties = {
        	agencyid=1,
			name='name_string',
			website='website_string',
			phone='phone_string',
			email='email_string',
			statusid=1,
			accesslevel=1
        }>
        <!--- a struct used to set invalid model property values --->
        <cfset loc.invalidProperties = {
        	agencyid='abcd',
			name='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
			website='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
			phone='xxxxxxxxxxxxxxxxx',
			email='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
			statusid='abcd',
			accesslevel='abcd'
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
    <cffunction name="test_customer_is_valid">
		<!--- set the properties of the model --->
		<cfset loc.customer.setProperties(loc.validProperties)>
		<cfset loc.result = loc.customer.valid()>
		<cfset assert("loc.result","loc.customer.allErrors()")>
	</cffunction>

	<!--- assert the model is invalid when no properties are set --->
	<cffunction name="test_customer_is_not_valid">
		<cfset loc.customer.setProperties(loc.invalidProperties)>
        <cfset assert("! loc.customer.valid()")>
	</cffunction>

	<!--- assert the model creates successfully --->
	<cffunction name="test_customer_create">
		<!--- set the properties of the model --->
		<cfset loc.customer.setProperties(loc.validProperties)>
		<cfset loc.result = loc.customer.save()>
        <cfset assert("loc.result", "loc.customer.allErrors()")>
	</cffunction>

	<!--- assert the model updates successfully --->
	<cffunction name="test_customer_update">
		<cfset loc.customer = model("customer").findOne()>
		<cfset loc.customer.setProperties(loc.validProperties)>
		<cfset loc.result = loc.customer.update()>
        <cfset assert("loc.result", "loc.customer.allErrors()")>
	</cffunction>

	<!--- assert the model deletes successfully --->
	<cffunction name="test_customer_delete">
		<cfset loc.customer = model("customer").findOne()>
		<cfset loc.result = loc.customer.delete()>
        <cfset assert("loc.result")>
	</cffunction>

</cfcomponent>
