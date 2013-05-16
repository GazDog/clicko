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

    <!---
    # INDEX
    --->

    <cffunction name="test_index_displays_click_listing">
        <!--- setup some params for the tests --->
        <cfset loc.params = {controller="Clicks", action="index"}>
        <!--- create an instance of the controller --->
        <cfset loc.controller = controller("Clicks", loc.params)>
        <!--- process the action of the controller --->
        <cfset loc.controller.$processAction()>
        <!--- get copy of the code the view generated --->
        <cfset loc.response = loc.controller.response()>
        <!--- make sure this string is displayed  --->
        <cfset loc.string = '<h1>Listing Clicks</h1>'>
        <cfset assert('loc.response contains loc.string')>
        <!--- check additional strings --->

    </cffunction>

    <!---
    # SHOW
    --->

    <cffunction name="test_show_displays_click">
        <!--- find a click object --->
        <cfset loc.click = model("Click").findOne()>
        <!--- define the key param --->
        <cfset loc.params = {controller="Clicks", action="show", key=loc.click.key()}>
        <cfset loc.controller = controller("Clicks", loc.params)>
        <cfset loc.controller.$processAction()>
        <cfset loc.response = loc.controller.response()>
        <cfset loc.string = '<h1>Showing Click</h1>'>
        <cfset assert('loc.response contains loc.string')>
        <!--- check additional strings --->

    </cffunction>

    <cffunction name="test_show_redirects_to_index_if_a_click_is_not_found">
        <!--- provide a key that doesn't exist --->
        <cfset loc.params = {controller="Clicks", action="show", key=-1}>
        <cfset loc.controller = controller(name="Clicks", params=loc.params)>
        <cfset loc.controller.$processAction()>
        <cfset loc.redirect = loc.controller.$getRedirect()>
        <cfset assert('StructKeyExists(loc.redirect, "$args")')>
        <cfset assert('loc.redirect.$args.action eq "index"')>
    </cffunction>

    <!---
    # NEW
    --->

    <cffunction name="test_new_displays_click_form">
        <cfset loc.params = {controller="Clicks", action="new"}>
        <!--- create a new click object for the form --->
        <cfset loc.params.click = model("Click").new()>
        <cfset loc.controller = controller("Clicks", loc.params)>
        <cfset loc.controller.$processAction()>
        <cfset loc.response = loc.controller.response()>
        <cfset loc.string = '<h1>Create a New Click</h1>'>
        <cfset assert('loc.response contains loc.string')>
        <!--- check additional strings --->

    </cffunction>

    <!---
    # EDIT
    --->

    <cffunction name="test_edit_displays_click_form">
        <cfset loc.click = model("Click").findOne()>
        <cfset loc.params = {controller="Clicks", action="edit", key=loc.click.key()}>
        <cfset loc.controller = controller("Clicks", loc.params)>
        <cfset loc.controller.$processAction()>
        <cfset loc.response = loc.controller.response()>
        <cfset loc.string = '<h1>Editing Click</h1>'>
        <cfset assert('loc.response contains loc.string')>
        <!--- check additional strings --->

    </cffunction>

    <cffunction name="test_edit_redirects_to_index_if_a_click_is_not_found">
        <cfset loc.params = {controller="Clicks", action="edit", key=-1}>
        <cfset loc.controller = controller(name="Clicks", params=loc.params)>
        <cfset loc.controller.$processAction()>
        <cfset loc.redirect = loc.controller.$getRedirect()>
        <cfset assert('StructKeyExists(loc.redirect, "$args")')>
        <cfset assert('loc.redirect.$args.action eq "index"')>
    </cffunction>

    <!---
    # CREATE
    --->

    <cffunction name="test_create_redirects_to_index_after_a_click_is_created">
        <cfset loc.params = {controller="Clicks", action="create"}>
        <!--- set valid properties for creating a click --->
        <cfset loc.params.click = loc.validProperties>
        <cfset loc.controller = controller(name="Clicks", params=loc.params)>
        <cfset loc.controller.$processAction()>
        <cfset loc.redirect = loc.controller.$getRedirect()>
        <cfset assert('StructKeyExists(loc.redirect, "$args")')>
        <cfset assert('loc.redirect.$args.action eq "index"')>
    </cffunction>

    <cffunction name="test_create_errors_display_when_click_is_invalid">
        <cfset loc.params = {controller="Clicks", action="create"}>
        <!--- set invalid properties for creating a click --->
        <cfset loc.params.click = loc.invalidProperties>
        <cfset loc.controller = controller("Clicks", loc.params)>
        <cfset loc.controller.$processAction()>
        <cfset loc.response = loc.controller.response()>
        <cfset loc.message = 'There was an error creating the click'>
        <cfset assert('loc.response contains loc.message')>
    </cffunction>

    <!---
    # UPDATE
    --->

    <cffunction name="test_update_redirects_to_index_after_a_click_is_updated">
        <cfset loc.click = model("Click").findOne()>
        <cfset loc.params = {controller="Clicks", action="update", key=loc.click.key()}>
        <cfset loc.params.click = loc.click.properties()>
        <cfset loc.controller = controller(name="Clicks", params=loc.params)>
        <cfset loc.controller.$processAction()>
        <cfset loc.redirect = loc.controller.$getRedirect()>
        <cfset assert('StructKeyExists(loc.redirect, "$args")')>
        <cfset assert('loc.redirect.$args.action eq "index"')>
    </cffunction>

    <cffunction name="test_update_errors_display_when_click_is_invalid">
        <cfset loc.click = model("Click").findOne()>
        <cfset loc.params = {controller="Clicks", action="update", key=loc.click.key()}>
        <cfset loc.params.click = loc.invalidProperties>
        <cfset loc.controller = controller("Clicks", loc.params)>
        <cfset loc.controller.$processAction()>
        <cfset loc.response = loc.controller.response()>
        <cfset loc.message = 'There was an error updating the click'>
        <cfset assert('loc.response contains loc.message')>
    </cffunction>

    <!---
    # DELETE
    --->

    <cffunction name="test_delete_redirects_to_index_after_a_click_is_deleted">
        <cfset loc.click = model("Click").findOne()>
        <cfset loc.params = {controller="Clicks", action="delete", key=loc.click.key()}>
        <cfset loc.controller = controller(name="Clicks", params=loc.params)>
        <cfset loc.controller.$processAction()>
        <cfset loc.redirect = loc.controller.$getRedirect()>
        <cfset assert('StructKeyExists(loc.redirect, "$args")')>
        <cfset assert('loc.redirect.$args.action eq "index"')>
    </cffunction>

</cfcomponent>
