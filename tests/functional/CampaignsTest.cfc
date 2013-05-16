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

    <!---
    # INDEX
    --->

    <cffunction name="test_index_displays_campaign_listing">
        <!--- setup some params for the tests --->
        <cfset loc.params = {controller="Campaigns", action="index"}>
        <!--- create an instance of the controller --->
        <cfset loc.controller = controller("Campaigns", loc.params)>
        <!--- process the action of the controller --->
        <cfset loc.controller.$processAction()>
        <!--- get copy of the code the view generated --->
        <cfset loc.response = loc.controller.response()>
        <!--- make sure this string is displayed  --->
        <cfset loc.string = '<h1>Listing Campaigns</h1>'>
        <cfset assert('loc.response contains loc.string')>
        <!--- check additional strings --->

    </cffunction>

    <!---
    # SHOW
    --->

    <cffunction name="test_show_displays_campaign">
        <!--- find a campaign object --->
        <cfset loc.campaign = model("Campaign").findOne()>
        <!--- define the key param --->
        <cfset loc.params = {controller="Campaigns", action="show", key=loc.campaign.key()}>
        <cfset loc.controller = controller("Campaigns", loc.params)>
        <cfset loc.controller.$processAction()>
        <cfset loc.response = loc.controller.response()>
        <cfset loc.string = '<h1>Showing Campaign</h1>'>
        <cfset assert('loc.response contains loc.string')>
        <!--- check additional strings --->

    </cffunction>

    <cffunction name="test_show_redirects_to_index_if_a_campaign_is_not_found">
        <!--- provide a key that doesn't exist --->
        <cfset loc.params = {controller="Campaigns", action="show", key=-1}>
        <cfset loc.controller = controller(name="Campaigns", params=loc.params)>
        <cfset loc.controller.$processAction()>
        <cfset loc.redirect = loc.controller.$getRedirect()>
        <cfset assert('StructKeyExists(loc.redirect, "$args")')>
        <cfset assert('loc.redirect.$args.action eq "index"')>
    </cffunction>

    <!---
    # NEW
    --->

    <cffunction name="test_new_displays_campaign_form">
        <cfset loc.params = {controller="Campaigns", action="new"}>
        <!--- create a new campaign object for the form --->
        <cfset loc.params.campaign = model("Campaign").new()>
        <cfset loc.controller = controller("Campaigns", loc.params)>
        <cfset loc.controller.$processAction()>
        <cfset loc.response = loc.controller.response()>
        <cfset loc.string = '<h1>Create a New Campaign</h1>'>
        <cfset assert('loc.response contains loc.string')>
        <!--- check additional strings --->

    </cffunction>

    <!---
    # EDIT
    --->

    <cffunction name="test_edit_displays_campaign_form">
        <cfset loc.campaign = model("Campaign").findOne()>
        <cfset loc.params = {controller="Campaigns", action="edit", key=loc.campaign.key()}>
        <cfset loc.controller = controller("Campaigns", loc.params)>
        <cfset loc.controller.$processAction()>
        <cfset loc.response = loc.controller.response()>
        <cfset loc.string = '<h1>Editing Campaign</h1>'>
        <cfset assert('loc.response contains loc.string')>
        <!--- check additional strings --->

    </cffunction>

    <cffunction name="test_edit_redirects_to_index_if_a_campaign_is_not_found">
        <cfset loc.params = {controller="Campaigns", action="edit", key=-1}>
        <cfset loc.controller = controller(name="Campaigns", params=loc.params)>
        <cfset loc.controller.$processAction()>
        <cfset loc.redirect = loc.controller.$getRedirect()>
        <cfset assert('StructKeyExists(loc.redirect, "$args")')>
        <cfset assert('loc.redirect.$args.action eq "index"')>
    </cffunction>

    <!---
    # CREATE
    --->

    <cffunction name="test_create_redirects_to_index_after_a_campaign_is_created">
        <cfset loc.params = {controller="Campaigns", action="create"}>
        <!--- set valid properties for creating a campaign --->
        <cfset loc.params.campaign = loc.validProperties>
        <cfset loc.controller = controller(name="Campaigns", params=loc.params)>
        <cfset loc.controller.$processAction()>
        <cfset loc.redirect = loc.controller.$getRedirect()>
        <cfset assert('StructKeyExists(loc.redirect, "$args")')>
        <cfset assert('loc.redirect.$args.action eq "index"')>
    </cffunction>

    <cffunction name="test_create_errors_display_when_campaign_is_invalid">
        <cfset loc.params = {controller="Campaigns", action="create"}>
        <!--- set invalid properties for creating a campaign --->
        <cfset loc.params.campaign = loc.invalidProperties>
        <cfset loc.controller = controller("Campaigns", loc.params)>
        <cfset loc.controller.$processAction()>
        <cfset loc.response = loc.controller.response()>
        <cfset loc.message = 'There was an error creating the campaign'>
        <cfset assert('loc.response contains loc.message')>
    </cffunction>

    <!---
    # UPDATE
    --->

    <cffunction name="test_update_redirects_to_index_after_a_campaign_is_updated">
        <cfset loc.campaign = model("Campaign").findOne()>
        <cfset loc.params = {controller="Campaigns", action="update", key=loc.campaign.key()}>
        <cfset loc.params.campaign = loc.campaign.properties()>
        <cfset loc.controller = controller(name="Campaigns", params=loc.params)>
        <cfset loc.controller.$processAction()>
        <cfset loc.redirect = loc.controller.$getRedirect()>
        <cfset assert('StructKeyExists(loc.redirect, "$args")')>
        <cfset assert('loc.redirect.$args.action eq "index"')>
    </cffunction>

    <cffunction name="test_update_errors_display_when_campaign_is_invalid">
        <cfset loc.campaign = model("Campaign").findOne()>
        <cfset loc.params = {controller="Campaigns", action="update", key=loc.campaign.key()}>
        <cfset loc.params.campaign = loc.invalidProperties>
        <cfset loc.controller = controller("Campaigns", loc.params)>
        <cfset loc.controller.$processAction()>
        <cfset loc.response = loc.controller.response()>
        <cfset loc.message = 'There was an error updating the campaign'>
        <cfset assert('loc.response contains loc.message')>
    </cffunction>

    <!---
    # DELETE
    --->

    <cffunction name="test_delete_redirects_to_index_after_a_campaign_is_deleted">
        <cfset loc.campaign = model("Campaign").findOne()>
        <cfset loc.params = {controller="Campaigns", action="delete", key=loc.campaign.key()}>
        <cfset loc.controller = controller(name="Campaigns", params=loc.params)>
        <cfset loc.controller.$processAction()>
        <cfset loc.redirect = loc.controller.$getRedirect()>
        <cfset assert('StructKeyExists(loc.redirect, "$args")')>
        <cfset assert('loc.redirect.$args.action eq "index"')>
    </cffunction>

</cfcomponent>
