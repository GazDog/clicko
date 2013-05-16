<cfcomponent extends="wheelsMapping.Test">

	<cffunction name="setup">
		<!--- save the orginal environment --->
		<cfset loc.orgApp = Duplicate(application) />
		<!--- path to our plugins assets folder where we will store our components and files --->
		<cfset loc.assetsPath = "plugins/DatePicker/tests/assets" />
		<!--- repoint the lookup paths wheels uses to our assets directories --->
		<cfset application.wheels.controllerPath = "#loc.assetsPath#/controllers" />
		<!--- we're always going to need a controller for our test so we'll just create one --->
		<cfset params = {controller="foo", action="bar"} />
		<cfset foo = controller("Foo", params) />
	</cffunction>
	
	<cffunction name="test_00_setup_and_teardown">
		<cfset assert("true")>
	</cffunction>
	
	<cffunction name="test_01_lessSupport_markup">
		<cfset dateString = DateFormat(Now(), "mm/dd/yyyy")>
		<cfset source = "foo.less">
		<cfset a = foo.styleSheetLinkTag(source)>
		<cfset b = foo.styleSheetLinkTag(UCase(source))>
		<cfset x = '<link href="#get("webPath")##get("styleSheetPath")#/#source#" rel="stylesheet/less" type="text/css" />' & chr(10)>
		<cfset assert("a eq x")>
		<cfset assert("b eq x")>
	</cffunction>
	
	<cffunction name="teardown">
		<!--- recopy the original environment back after each test --->
		<cfset application = loc.orgApp>
	</cffunction>
		
</cfcomponent>
