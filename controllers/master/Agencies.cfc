<cfcomponent extends="Controller" output="false">
	
	<cffunction name="init">
		<cfset super.init()>
		<cfset filters(through="formDataFunction", only="new,edit,create,update")>
	</cffunction>

	<!--- agencies/index --->
	<cffunction name="index">
		<cfset agencies = model("Agency").findAll()>
	</cffunction>
	
	<!--- agencies/show/key --->
	<cffunction name="show">
		
		<!--- Find the record --->
    	<cfset agency = model("Agency").findByKey(params.key)>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(agency)>
	        <cfset flashInsert(message="Agency #params.key# was not found", messageType="error")>
	        <cfreturn redirectTo(action="index", delay=true)>
	    </cfif>
			
	</cffunction>
	
	<!--- agencies/new --->
	<cffunction name="new">
		<cfset agency = model("Agency").new()>
	</cffunction>
	
	<!--- agencies/edit/key --->
	<cffunction name="edit">
	
		<!--- Find the record --->
    	<cfset agency = model("Agency").findByKey(params.key)>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(agency)>
	        <cfset flashInsert(message="Agency #params.key# was not found", messageType="error")>
			<cfreturn redirectTo(action="index", delay=true)>
	    </cfif>
		
	</cffunction>
	
	<!--- agencies/create --->
	<cffunction name="create">
		<cfset agency = model("Agency").new(params.agency)>
		
		<!--- Verify that the agency creates successfully --->
		<cfif agency.save()>
			<cfset flashInsert(message="#agency.name# was created successfully.", messageType="success")>
            <cfreturn redirectTo(action="index", delay=true)>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(message="There was an error creating the agency.", messageType="error")>
			<cfset renderPage(action="new")>
		</cfif>
	</cffunction>
	
	<!--- agencies/update --->
	<cffunction name="update">
		<cfset agency = model("Agency").findByKey(params.key)>
		
		<!--- Verify that the agency updates successfully --->
		<cfif agency.update(params.agency)>
			<cfset flashInsert(message="#agency.name# was updated successfully.", messageType="success")>	
            <cfreturn redirectTo(action="index", delay=true)>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(message="There was an error updating the agency.", messageType="error")>
			<cfset renderPage(action="edit")>
		</cfif>
	</cffunction>
	
	<!--- agencies/delete/key --->
	<cffunction name="delete">
		<cfset agency = model("Agency").findByKey(params.key)>
		
		<!--- Verify that the agency deletes successfully --->
		<cfif agency.delete()>
			<cfset flashInsert(message="#agency.name# was deleted successfully.", messageType="success")>	
            <cfreturn redirectTo(action="index", delay=true)>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(message="There was an error deleting the agency.", messageType="error")>
			<cfreturn redirectTo(action="index", delay=true)>
		</cfif>
	</cffunction>
	
	<!--- TODO: this is a fudge as tge automatic data function is not working.. --->
	<cffunction name="formDataFunction" access="private">
		<cfset accessLevels = []>
		<cfset ArrayAppend(accessLevels, {value="0", text="Single Customer"})>
		<!--- <cfset ArrayAppend(accessLevels, {value="1", text="5 Customers"})> --->
		<cfset ArrayAppend(accessLevels, {value="2", text="Unlimited Customers"})>
	</cffunction>

	<!--- <cffunction name="form" access="private" returntype="struct">
		<cfset accessLevels = []>
		<cfset ArrayAppend(accessLevels, {value="0", text="Single Customer"})>
		<cfset ArrayAppend(accessLevels, {value="1", text="5 Customers"})>
		<cfset ArrayAppend(accessLevels, {value="2", text="Unlimited Customers"})>
		<cfreturn {}>
	</cffunction> --->

</cfcomponent>
