<cfcomponent extends="Controller" output="false">
	
	<!--- publishers/index --->
	<cffunction name="index">
		<cfset publishers = model("Publisher").findAll()>
	</cffunction>
	
	<!--- publishers/show/key --->
	<cffunction name="show">
		
		<!--- Find the record --->
    	<cfset publisher = model("Publisher").findByKey(params.key)>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(publisher)>
	        <cfset flashInsert(error="Publisher #params.key# was not found")>
	        <cfreturn redirectTo(action="index", delay=true)>
	    </cfif>
			
	</cffunction>
	
	<!--- publishers/new --->
	<cffunction name="new">
		<cfset publisher = model("Publisher").new()>
	</cffunction>
	
	<!--- publishers/edit/key --->
	<cffunction name="edit">
	
		<!--- Find the record --->
    	<cfset publisher = model("Publisher").findByKey(params.key)>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(publisher)>
	        <cfset flashInsert(error="Publisher #params.key# was not found")>
			<cfreturn redirectTo(action="index", delay=true)>
	    </cfif>
		
	</cffunction>
	
	<!--- publishers/create --->
	<cffunction name="create">
		<cfset publisher = model("Publisher").new(params.publisher)>
		
		<!--- Verify that the publisher creates successfully --->
		<cfif publisher.save()>
			<cfset flashInsert(success="The publisher was created successfully.")>
            <cfreturn redirectTo(action="index", delay=true)>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error creating the publisher.")>
			<cfset renderPage(action="new")>
		</cfif>
	</cffunction>
	
	<!--- publishers/update --->
	<cffunction name="update">
		<cfset publisher = model("Publisher").findByKey(params.key)>
		
		<!--- Verify that the publisher updates successfully --->
		<cfif publisher.update(params.publisher)>
			<cfset flashInsert(success="The publisher was updated successfully.")>	
            <cfreturn redirectTo(action="index", delay=true)>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the publisher.")>
			<cfset renderPage(action="edit")>
		</cfif>
	</cffunction>
	
	<!--- publishers/delete/key --->
	<cffunction name="delete">
		<cfset publisher = model("Publisher").findByKey(params.key)>
		
		<!--- Verify that the publisher deletes successfully --->
		<cfif publisher.delete()>
			<cfset flashInsert(success="The publisher was deleted successfully.")>	
            <cfreturn redirectTo(action="index", delay=true)>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the publisher.")>
			<cfreturn redirectTo(action="index", delay=true)>
		</cfif>
	</cffunction>
	
</cfcomponent>
