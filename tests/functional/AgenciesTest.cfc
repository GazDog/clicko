<cfcomponent extends="wheelsMapping.Test">

    <!---
    # SETUP & TEARDOWN
    --->

    <!--- include helper functions --->
    <cfinclude template="../helpers.cfm">
    
    <!--- setup runs before every test --->
    <cffunction name="setup">
        <!--- save the orginal environment --->
        <cfset loc.originalApplication = Duplicate(application)>
        <!--- set transaction mode to rollback, so no records are affected --->
        <cfset application.wheels.transactionMode = "rollback">
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

    <!---
    # INDEX
    --->

    <cffunction name="test_index_displays_agency_listing">
        <!--- setup some params for the tests --->
        <cfset loc.params = {controller="Agencies", action="index"}>
        <!--- create an instance of the controller --->
        <cfset loc.controller = controller("Agencies", loc.params)>
        <!--- process the action of the controller --->
        <cfset loc.controller.$processAction()>
        <!--- get copy of the code the view generated --->
        <cfset loc.response = loc.controller.response()>
        <!--- make sure this string is displayed  --->
        <cfset loc.string = '<h1>Listing Agencies</h1>'>
        <cfset assert('loc.response contains loc.string')>
        <!--- check additional strings --->

    </cffunction>

    <!---
    # SHOW
    --->

    <cffunction name="test_show_displays_agency">
        <!--- find a agency object --->
        <cfset loc.agency = model("Agency").findOne()>
        <!--- define the key param --->
        <cfset loc.params = {controller="Agencies", action="show", key=loc.agency.key()}>
        <cfset loc.controller = controller("Agencies", loc.params)>
        <cfset loc.controller.$processAction()>
        <cfset loc.response = loc.controller.response()>
        <cfset loc.string = '<h1>Showing Agency</h1>'>
        <cfset assert('loc.response contains loc.string')>
        <!--- check additional strings --->

    </cffunction>

    <cffunction name="test_show_redirects_to_index_if_a_agency_is_not_found">
        <!--- provide a key that doesn't exist --->
        <cfset loc.params = {controller="Agencies", action="show", key=-1}>
        <cfset loc.controller = controller(name="Agencies", params=loc.params)>
        <cfset loc.controller.$processAction()>
        <cfset loc.redirect = loc.controller.$getRedirect()>
        <cfset assert('StructKeyExists(loc.redirect, "$args")')>
        <cfset assert('loc.redirect.$args.action eq "index"')>
    </cffunction>

    <!---
    # NEW
    --->

    <cffunction name="test_new_displays_agency_form">
        <cfset loc.params = {controller="Agencies", action="new"}>
        <!--- create a new agency object for the form --->
        <cfset loc.params.agency = model("Agency").new()>
        <cfset loc.controller = controller("Agencies", loc.params)>
        <cfset loc.controller.$processAction()>
        <cfset loc.response = loc.controller.response()>
        <cfset loc.string = '<h1>Create a New Agency</h1>'>
        <cfset assert('loc.response contains loc.string')>
        <!--- check additional strings --->

    </cffunction>

    <!---
    # EDIT
    --->

    <cffunction name="test_edit_displays_agency_form">
        <cfset loc.agency = model("Agency").findOne()>
        <cfset loc.params = {controller="Agencies", action="edit", key=loc.agency.key()}>
        <cfset loc.controller = controller("Agencies", loc.params)>
        <cfset loc.controller.$processAction()>
        <cfset loc.response = loc.controller.response()>
        <cfset loc.string = '<h1>Editing Agency</h1>'>
        <cfset assert('loc.response contains loc.string')>
        <!--- check additional strings --->

    </cffunction>

    <cffunction name="test_edit_redirects_to_index_if_a_agency_is_not_found">
        <cfset loc.params = {controller="Agencies", action="edit", key=-1}>
        <cfset loc.controller = controller(name="Agencies", params=loc.params)>
        <cfset loc.controller.$processAction()>
        <cfset loc.redirect = loc.controller.$getRedirect()>
        <cfset assert('StructKeyExists(loc.redirect, "$args")')>
        <cfset assert('loc.redirect.$args.action eq "index"')>
    </cffunction>

    <!---
    # CREATE
    --->

    <cffunction name="test_create_redirects_to_index_after_a_agency_is_created">
        <cfset loc.params = {controller="Agencies", action="create"}>
        <!--- set valid properties for creating a agency --->
        <cfset loc.params.agency = loc.validProperties>
        <cfset loc.controller = controller(name="Agencies", params=loc.params)>
        <cfset loc.controller.$processAction()>
        <cfset loc.redirect = loc.controller.$getRedirect()>
        <cfset assert('StructKeyExists(loc.redirect, "$args")')>
        <cfset assert('loc.redirect.$args.action eq "index"')>
    </cffunction>

    <cffunction name="test_create_errors_display_when_agency_is_invalid">
        <cfset loc.params = {controller="Agencies", action="create"}>
        <!--- set invalid properties for creating a agency --->
        <cfset loc.params.agency = loc.invalidProperties>
        <cfset loc.controller = controller("Agencies", loc.params)>
        <cfset loc.controller.$processAction()>
        <cfset loc.response = loc.controller.response()>
        <cfset loc.message = 'There was an error creating the agency'>
        <cfset assert('loc.response contains loc.message')>
    </cffunction>

    <!---
    # UPDATE
    --->

    <cffunction name="test_update_redirects_to_index_after_a_agency_is_updated">
        <cfset loc.agency = model("Agency").findOne()>
        <cfset loc.params = {controller="Agencies", action="update", key=loc.agency.key()}>
        <cfset loc.params.agency = loc.agency.properties()>
        <cfset loc.controller = controller(name="Agencies", params=loc.params)>
        <cfset loc.controller.$processAction()>
        <cfset loc.redirect = loc.controller.$getRedirect()>
        <cfset assert('StructKeyExists(loc.redirect, "$args")')>
        <cfset assert('loc.redirect.$args.action eq "index"')>
    </cffunction>

    <cffunction name="test_update_errors_display_when_agency_is_invalid">
        <cfset loc.agency = model("Agency").findOne()>
        <cfset loc.params = {controller="Agencies", action="update", key=loc.agency.key()}>
        <cfset loc.params.agency = loc.invalidProperties>
        <cfset loc.controller = controller("Agencies", loc.params)>
        <cfset loc.controller.$processAction()>
        <cfset loc.response = loc.controller.response()>
        <cfset loc.message = 'There was an error updating the agency'>
        <cfset assert('loc.response contains loc.message')>
    </cffunction>

    <!---
    # DELETE
    --->

    <cffunction name="test_delete_redirects_to_index_after_a_agency_is_deleted">
        <cfset loc.agency = model("Agency").findOne()>
        <cfset loc.params = {controller="Agencies", action="delete", key=loc.agency.key()}>
        <cfset loc.controller = controller(name="Agencies", params=loc.params)>
        <cfset loc.controller.$processAction()>
        <cfset loc.redirect = loc.controller.$getRedirect()>
        <cfset assert('StructKeyExists(loc.redirect, "$args")')>
        <cfset assert('loc.redirect.$args.action eq "index"')>
    </cffunction>

</cfcomponent>
