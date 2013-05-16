<cfcomponent extends="Controller" output="false">
	
	<!--- clicks/index --->
	<cffunction name="index">
		<cfset clicks = model("Click").findAll()>
	</cffunction>
	
	<!--- clicks/show/key --->
	<cffunction name="show">
		
		<!--- Find the record --->
    	<cfset click = model("Click").findByKey(params.key)>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(click)>
	        <cfset flashInsert(error="Click #params.key# was not found")>
	        <cfreturn redirectTo(action="index", delay=true)>
	    </cfif>
			
	</cffunction>
	
	<!--- clicks/new --->
	<cffunction name="new">
		<cfset click = model("Click").new()>
	</cffunction>
	
	<!--- clicks/edit/key --->
	<cffunction name="edit">
	
		<!--- Find the record --->
    	<cfset click = model("Click").findByKey(params.key)>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(click)>
	        <cfset flashInsert(error="Click #params.key# was not found")>
			<cfreturn redirectTo(action="index", delay=true)>
	    </cfif>
		
	</cffunction>
	
	<!--- clicks/create --->
	<cffunction name="create">
		<cfset click = model("Click").new(params.click)>
		
		<!--- Verify that the click creates successfully --->
		<cfif click.save()>
			<cfset flashInsert(success="The click was created successfully.")>
            <cfreturn redirectTo(action="index", delay=true)>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error creating the click.")>
			<cfset renderPage(action="new")>
		</cfif>
	</cffunction>
	
	<!--- clicks/update --->
	<cffunction name="update">
		<cfset click = model("Click").findByKey(params.key)>
		
		<!--- Verify that the click updates successfully --->
		<cfif click.update(params.click)>
			<cfset flashInsert(success="The click was updated successfully.")>	
            <cfreturn redirectTo(action="index", delay=true)>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the click.")>
			<cfset renderPage(action="edit")>
		</cfif>
	</cffunction>
	
	<!--- clicks/delete/key --->
	<cffunction name="delete">
		<cfset click = model("Click").findByKey(params.key)>
		
		<!--- Verify that the click deletes successfully --->
		<cfif click.delete()>
			<cfset flashInsert(success="The click was deleted successfully.")>	
            <cfreturn redirectTo(action="index", delay=true)>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the click.")>
			<cfreturn redirectTo(action="index", delay=true)>
		</cfif>
	</cffunction>
	
</cfcomponent>
