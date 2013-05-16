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

    <!---
    # INDEX
    --->

    <cffunction name="test_index_displays_publisher_listing">
        <!--- setup some params for the tests --->
        <cfset loc.params = {controller="Publishers", action="index"}>
        <!--- create an instance of the controller --->
        <cfset loc.controller = controller("Publishers", loc.params)>
        <!--- process the action of the controller --->
        <cfset loc.controller.$processAction()>
        <!--- get copy of the code the view generated --->
        <cfset loc.response = loc.controller.response()>
        <!--- make sure this string is displayed  --->
        <cfset loc.string = '<h1>Listing Publishers</h1>'>
        <cfset assert('loc.response contains loc.string')>
        <!--- check additional strings --->

    </cffunction>

    <!---
    # SHOW
    --->

    <cffunction name="test_show_displays_publisher">
        <!--- find a publisher object --->
        <cfset loc.publisher = model("Publisher").findOne()>
        <!--- define the key param --->
        <cfset loc.params = {controller="Publishers", action="show", key=loc.publisher.key()}>
        <cfset loc.controller = controller("Publishers", loc.params)>
        <cfset loc.controller.$processAction()>
        <cfset loc.response = loc.controller.response()>
        <cfset loc.string = '<h1>Showing Publisher</h1>'>
        <cfset assert('loc.response contains loc.string')>
        <!--- check additional strings --->

    </cffunction>

    <cffunction name="test_show_redirects_to_index_if_a_publisher_is_not_found">
        <!--- provide a key that doesn't exist --->
        <cfset loc.params = {controller="Publishers", action="show", key=-1}>
        <cfset loc.controller = controller(name="Publishers", params=loc.params)>
        <cfset loc.controller.$processAction()>
        <cfset loc.redirect = loc.controller.$getRedirect()>
        <cfset assert('StructKeyExists(loc.redirect, "$args")')>
        <cfset assert('loc.redirect.$args.action eq "index"')>
    </cffunction>

    <!---
    # NEW
    --->

    <cffunction name="test_new_displays_publisher_form">
        <cfset loc.params = {controller="Publishers", action="new"}>
        <!--- create a new publisher object for the form --->
        <cfset loc.params.publisher = model("Publisher").new()>
        <cfset loc.controller = controller("Publishers", loc.params)>
        <cfset loc.controller.$processAction()>
        <cfset loc.response = loc.controller.response()>
        <cfset loc.string = '<h1>Create a New Publisher</h1>'>
        <cfset assert('loc.response contains loc.string')>
        <!--- check additional strings --->

    </cffunction>

    <!---
    # EDIT
    --->

    <cffunction name="test_edit_displays_publisher_form">
        <cfset loc.publisher = model("Publisher").findOne()>
        <cfset loc.params = {controller="Publishers", action="edit", key=loc.publisher.key()}>
        <cfset loc.controller = controller("Publishers", loc.params)>
        <cfset loc.controller.$processAction()>
        <cfset loc.response = loc.controller.response()>
        <cfset loc.string = '<h1>Editing Publisher</h1>'>
        <cfset assert('loc.response contains loc.string')>
        <!--- check additional strings --->

    </cffunction>

    <cffunction name="test_edit_redirects_to_index_if_a_publisher_is_not_found">
        <cfset loc.params = {controller="Publishers", action="edit", key=-1}>
        <cfset loc.controller = controller(name="Publishers", params=loc.params)>
        <cfset loc.controller.$processAction()>
        <cfset loc.redirect = loc.controller.$getRedirect()>
        <cfset assert('StructKeyExists(loc.redirect, "$args")')>
        <cfset assert('loc.redirect.$args.action eq "index"')>
    </cffunction>

    <!---
    # CREATE
    --->

    <cffunction name="test_create_redirects_to_index_after_a_publisher_is_created">
        <cfset loc.params = {controller="Publishers", action="create"}>
        <!--- set valid properties for creating a publisher --->
        <cfset loc.params.publisher = loc.validProperties>
        <cfset loc.controller = controller(name="Publishers", params=loc.params)>
        <cfset loc.controller.$processAction()>
        <cfset loc.redirect = loc.controller.$getRedirect()>
        <cfset assert('StructKeyExists(loc.redirect, "$args")')>
        <cfset assert('loc.redirect.$args.action eq "index"')>
    </cffunction>

    <cffunction name="test_create_errors_display_when_publisher_is_invalid">
        <cfset loc.params = {controller="Publishers", action="create"}>
        <!--- set invalid properties for creating a publisher --->
        <cfset loc.params.publisher = loc.invalidProperties>
        <cfset loc.controller = controller("Publishers", loc.params)>
        <cfset loc.controller.$processAction()>
        <cfset loc.response = loc.controller.response()>
        <cfset loc.message = 'There was an error creating the publisher'>
        <cfset assert('loc.response contains loc.message')>
    </cffunction>

    <!---
    # UPDATE
    --->

    <cffunction name="test_update_redirects_to_index_after_a_publisher_is_updated">
        <cfset loc.publisher = model("Publisher").findOne()>
        <cfset loc.params = {controller="Publishers", action="update", key=loc.publisher.key()}>
        <cfset loc.params.publisher = loc.publisher.properties()>
        <cfset loc.controller = controller(name="Publishers", params=loc.params)>
        <cfset loc.controller.$processAction()>
        <cfset loc.redirect = loc.controller.$getRedirect()>
        <cfset assert('StructKeyExists(loc.redirect, "$args")')>
        <cfset assert('loc.redirect.$args.action eq "index"')>
    </cffunction>

    <cffunction name="test_update_errors_display_when_publisher_is_invalid">
        <cfset loc.publisher = model("Publisher").findOne()>
        <cfset loc.params = {controller="Publishers", action="update", key=loc.publisher.key()}>
        <cfset loc.params.publisher = loc.invalidProperties>
        <cfset loc.controller = controller("Publishers", loc.params)>
        <cfset loc.controller.$processAction()>
        <cfset loc.response = loc.controller.response()>
        <cfset loc.message = 'There was an error updating the publisher'>
        <cfset assert('loc.response contains loc.message')>
    </cffunction>

    <!---
    # DELETE
    --->

    <cffunction name="test_delete_redirects_to_index_after_a_publisher_is_deleted">
        <cfset loc.publisher = model("Publisher").findOne()>
        <cfset loc.params = {controller="Publishers", action="delete", key=loc.publisher.key()}>
        <cfset loc.controller = controller(name="Publishers", params=loc.params)>
        <cfset loc.controller.$processAction()>
        <cfset loc.redirect = loc.controller.$getRedirect()>
        <cfset assert('StructKeyExists(loc.redirect, "$args")')>
        <cfset assert('loc.redirect.$args.action eq "index"')>
    </cffunction>

</cfcomponent>
