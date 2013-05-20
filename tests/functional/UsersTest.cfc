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

    <!---
    # INDEX
    --->

    <cffunction name="test_index_displays_user_listing">
        <!--- setup some params for the tests --->
        <cfset loc.params = {controller="Users", action="index"}>
        <!--- create an instance of the controller --->
        <cfset loc.controller = controller("Users", loc.params)>
        <!--- process the action of the controller --->
        <cfset loc.controller.$processAction()>
        <!--- get copy of the code the view generated --->
        <cfset loc.response = loc.controller.response()>
        <!--- make sure this string is displayed  --->
        <cfset loc.string = '<h1>Listing Users</h1>'>
        <cfset assert('loc.response contains loc.string')>
        <!--- check additional strings --->

    </cffunction>

    <!---
    # SHOW
    --->

    <cffunction name="test_show_displays_user">
        <!--- find a user object --->
        <cfset loc.user = model("User").findOne()>
        <!--- define the key param --->
        <cfset loc.params = {controller="Users", action="show", key=loc.user.key()}>
        <cfset loc.controller = controller("Users", loc.params)>
        <cfset loc.controller.$processAction()>
        <cfset loc.response = loc.controller.response()>
        <cfset loc.string = '<h1>Showing User</h1>'>
        <cfset assert('loc.response contains loc.string')>
        <!--- check additional strings --->

    </cffunction>

    <cffunction name="test_show_redirects_to_index_if_a_user_is_not_found">
        <!--- provide a key that doesn't exist --->
        <cfset loc.params = {controller="Users", action="show", key=-1}>
        <cfset loc.controller = controller(name="Users", params=loc.params)>
        <cfset loc.controller.$processAction()>
        <cfset loc.redirect = loc.controller.$getRedirect()>
        <cfset assert('StructKeyExists(loc.redirect, "$args")')>
        <cfset assert('loc.redirect.$args.action eq "index"')>
    </cffunction>

    <!---
    # NEW
    --->

    <cffunction name="test_new_displays_user_form">
        <cfset loc.params = {controller="Users", action="new"}>
        <!--- create a new user object for the form --->
        <cfset loc.params.user = model("User").new()>
        <cfset loc.controller = controller("Users", loc.params)>
        <cfset loc.controller.$processAction()>
        <cfset loc.response = loc.controller.response()>
        <cfset loc.string = '<h1>Create a New User</h1>'>
        <cfset assert('loc.response contains loc.string')>
        <!--- check additional strings --->

    </cffunction>

    <!---
    # EDIT
    --->

    <cffunction name="test_edit_displays_user_form">
        <cfset loc.user = model("User").findOne()>
        <cfset loc.params = {controller="Users", action="edit", key=loc.user.key()}>
        <cfset loc.controller = controller("Users", loc.params)>
        <cfset loc.controller.$processAction()>
        <cfset loc.response = loc.controller.response()>
        <cfset loc.string = '<h1>Editing User</h1>'>
        <cfset assert('loc.response contains loc.string')>
        <!--- check additional strings --->

    </cffunction>

    <cffunction name="test_edit_redirects_to_index_if_a_user_is_not_found">
        <cfset loc.params = {controller="Users", action="edit", key=-1}>
        <cfset loc.controller = controller(name="Users", params=loc.params)>
        <cfset loc.controller.$processAction()>
        <cfset loc.redirect = loc.controller.$getRedirect()>
        <cfset assert('StructKeyExists(loc.redirect, "$args")')>
        <cfset assert('loc.redirect.$args.action eq "index"')>
    </cffunction>

    <!---
    # CREATE
    --->

    <cffunction name="test_create_redirects_to_index_after_a_user_is_created">
        <cfset loc.params = {controller="Users", action="create"}>
        <!--- set valid properties for creating a user --->
        <cfset loc.params.user = loc.validProperties>
        <cfset loc.controller = controller(name="Users", params=loc.params)>
        <cfset loc.controller.$processAction()>
        <cfset loc.redirect = loc.controller.$getRedirect()>
        <cfset assert('StructKeyExists(loc.redirect, "$args")')>
        <cfset assert('loc.redirect.$args.action eq "index"')>
    </cffunction>

    <cffunction name="test_create_errors_display_when_user_is_invalid">
        <cfset loc.params = {controller="Users", action="create"}>
        <!--- set invalid properties for creating a user --->
        <cfset loc.params.user = loc.invalidProperties>
        <cfset loc.controller = controller("Users", loc.params)>
        <cfset loc.controller.$processAction()>
        <cfset loc.response = loc.controller.response()>
        <cfset loc.message = 'There was an error creating the user'>
        <cfset assert('loc.response contains loc.message')>
    </cffunction>

    <!---
    # UPDATE
    --->

    <cffunction name="test_update_redirects_to_index_after_a_user_is_updated">
        <cfset loc.user = model("User").findOne()>
        <cfset loc.params = {controller="Users", action="update", key=loc.user.key()}>
        <cfset loc.params.user = loc.user.properties()>
        <cfset loc.controller = controller(name="Users", params=loc.params)>
        <cfset loc.controller.$processAction()>
        <cfset loc.redirect = loc.controller.$getRedirect()>
        <cfset assert('StructKeyExists(loc.redirect, "$args")')>
        <cfset assert('loc.redirect.$args.action eq "index"')>
    </cffunction>

    <cffunction name="test_update_errors_display_when_user_is_invalid">
        <cfset loc.user = model("User").findOne()>
        <cfset loc.params = {controller="Users", action="update", key=loc.user.key()}>
        <cfset loc.params.user = loc.invalidProperties>
        <cfset loc.controller = controller("Users", loc.params)>
        <cfset loc.controller.$processAction()>
        <cfset loc.response = loc.controller.response()>
        <cfset loc.message = 'There was an error updating the user'>
        <cfset assert('loc.response contains loc.message')>
    </cffunction>

    <!---
    # DELETE
    --->

    <cffunction name="test_delete_redirects_to_index_after_a_user_is_deleted">
        <cfset loc.user = model("User").findOne()>
        <cfset loc.params = {controller="Users", action="delete", key=loc.user.key()}>
        <cfset loc.controller = controller(name="Users", params=loc.params)>
        <cfset loc.controller.$processAction()>
        <cfset loc.redirect = loc.controller.$getRedirect()>
        <cfset assert('StructKeyExists(loc.redirect, "$args")')>
        <cfset assert('loc.redirect.$args.action eq "index"')>
    </cffunction>

</cfcomponent>
