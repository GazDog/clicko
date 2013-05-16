<cfcomponent extends="wheelsMapping.Test">
    
	<!--- include helper functions --->
	<cfinclude template="../helpers.cfm">

	<!--- setup runs before every test --->
    <cffunction name="setup">
    	<!--- save the orginal environment --->
		<cfset loc.originalApplication = Duplicate(application)>
		<!--- set transaction mode to rollback, so no records are affected --->
		<cfset application.wheels.transactionMode = "rollback">
        <!--- create an instance of our Click --->
        <cfset loc.click = model("Click").new()>
        <!--- a struct used to set valid model property values --->
        <cfset loc.validProperties = {
        	assetid=1,
			ipaddress='ipaddress_string',
			browser='browser_string',
			browserversion='browserversion_s'
        }>
        <!--- a struct used to set invalid model property values --->
        <cfset loc.invalidProperties = {
        	assetid='abcd',
			ipaddress='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
			browser='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
			browserversion='xxxxxxxxxxxxxxxxx'
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
    <cffunction name="test_click_is_valid">
		<!--- set the properties of the model --->
		<cfset loc.click.setProperties(loc.validProperties)>
		<cfset loc.result = loc.click.valid()>
		<cfset assert("loc.result","loc.click.allErrors()")>
	</cffunction>

	<!--- assert the model is invalid when no properties are set --->
	<cffunction name="test_click_is_not_valid">
		<cfset loc.click.setProperties(loc.invalidProperties)>
        <cfset assert("! loc.click.valid()")>
	</cffunction>

	<!--- assert the model creates successfully --->
	<cffunction name="test_click_create">
		<!--- set the properties of the model --->
		<cfset loc.click.setProperties(loc.validProperties)>
		<cfset loc.result = loc.click.save()>
        <cfset assert("loc.result", "loc.click.allErrors()")>
	</cffunction>

	<!--- assert the model updates successfully --->
	<cffunction name="test_click_update">
		<cfset loc.click = model("click").findOne()>
		<cfset loc.click.setProperties(loc.validProperties)>
		<cfset loc.result = loc.click.update()>
        <cfset assert("loc.result", "loc.click.allErrors()")>
	</cffunction>

	<!--- assert the model deletes successfully --->
	<cffunction name="test_click_delete">
		<cfset loc.click = model("click").findOne()>
		<cfset loc.result = loc.click.delete()>
        <cfset assert("loc.result")>
	</cffunction>

</cfcomponent>
