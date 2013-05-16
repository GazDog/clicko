<cfcomponent extends="Controller" output="false">
	
	<cffunction name="init">
		<cfset super.init()>
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
	        <cfset flashInsert(error="Agency #params.key# was not found")>
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
	        <cfset flashInsert(error="Agency #params.key# was not found")>
			<cfreturn redirectTo(action="index", delay=true)>
	    </cfif>
		
	</cffunction>
	
	<!--- agencies/create --->
	<cffunction name="create">
		<cfset agency = model("Agency").new(params.agency)>
		
		<!--- Verify that the agency creates successfully --->
		<cfif agency.save()>
			<cfset flashInsert(success="The agency was created successfully.")>
            <cfreturn redirectTo(action="index", delay=true)>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error creating the agency.")>
			<cfset renderPage(action="new")>
		</cfif>
	</cffunction>
	
	<!--- agencies/update --->
	<cffunction name="update">
		<cfset agency = model("Agency").findByKey(params.key)>
		
		<!--- Verify that the agency updates successfully --->
		<cfif agency.update(params.agency)>
			<cfset flashInsert(success="The agency was updated successfully.")>	
            <cfreturn redirectTo(action="index", delay=true)>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the agency.")>
			<cfset renderPage(action="edit")>
		</cfif>
	</cffunction>
	
	<!--- agencies/delete/key --->
	<cffunction name="delete">
		<cfset agency = model("Agency").findByKey(params.key)>
		
		<!--- Verify that the agency deletes successfully --->
		<cfif agency.delete()>
			<cfset flashInsert(success="The agency was deleted successfully.")>	
            <cfreturn redirectTo(action="index", delay=true)>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the agency.")>
			<cfreturn redirectTo(action="index", delay=true)>
		</cfif>
	</cffunction>
	
</cfcomponent>
