<cfcomponent extends="wheelsMapping.Test">
    
	<!--- include helper functions --->
	<cfinclude template="../helpers.cfm">

	<!--- setup runs before every test --->
    <cffunction name="setup">
    	<!--- save the orginal environment --->
		<cfset loc.originalApplication = Duplicate(application)>
		<!--- set transaction mode to rollback, so no records are affected --->
		<cfset application.wheels.transactionMode = "rollback">
        <!--- create an instance of our Agency --->
        <cfset loc.agency = model("Agency").new()>
        <!--- a struct used to set valid model property values --->
        <cfset loc.validProperties = {
        	name='name_string',
			streetnumber='streetnumber_str',
			streetname='streetname_string',
			suburb='suburb_string',
			phone='phone_string',
			email='email_string',
			statusid=1,
			accesslevel=1
        }>
        <!--- a struct used to set invalid model property values --->
        <cfset loc.invalidProperties = {
        	name='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
			streetnumber='xxxxxxxxxxxxxxxxx',
			streetname='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
			suburb='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
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
    <cffunction name="test_agency_is_valid">
		<!--- set the properties of the model --->
		<cfset loc.agency.setProperties(loc.validProperties)>
		<cfset loc.result = loc.agency.valid()>
		<cfset assert("loc.result","loc.agency.allErrors()")>
	</cffunction>

	<!--- assert the model is invalid when no properties are set --->
	<cffunction name="test_agency_is_not_valid">
		<cfset loc.agency.setProperties(loc.invalidProperties)>
        <cfset assert("! loc.agency.valid()")>
	</cffunction>

	<!--- assert the model creates successfully --->
	<cffunction name="test_agency_create">
		<!--- set the properties of the model --->
		<cfset loc.agency.setProperties(loc.validProperties)>
		<cfset loc.result = loc.agency.save()>
        <cfset assert("loc.result", "loc.agency.allErrors()")>
	</cffunction>

	<!--- assert the model updates successfully --->
	<cffunction name="test_agency_update">
		<cfset loc.agency = model("agency").findOne()>
		<cfset loc.agency.setProperties(loc.validProperties)>
		<cfset loc.result = loc.agency.update()>
        <cfset assert("loc.result", "loc.agency.allErrors()")>
	</cffunction>

	<!--- assert the model deletes successfully --->
	<cffunction name="test_agency_delete">
		<cfset loc.agency = model("agency").findOne()>
		<cfset loc.result = loc.agency.delete()>
        <cfset assert("loc.result")>
	</cffunction>

</cfcomponent>
