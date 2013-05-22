<cfcomponent extends="Controller" output="false">
	
	<!--- users/index --->
	<cffunction name="index">
		<cfset users = model("User").findAll(where="isAdministrator = 1")>
	</cffunction>
	
	<!--- users/show/key --->
	<cffunction name="show">
		
		<!--- Find the record --->
    	<cfset user = model("User").findByKey(params.key)>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(user)>
	        <cfset flashInsert(message="User #params.key# was not found", messageType="error")>
	        <cfreturn redirectTo(action="index", delay=true)>
	    </cfif>
			
	</cffunction>
	
	<!--- users/new --->
	<cffunction name="new">
		<cfset user = model("User").new()>
	</cffunction>
	
	<!--- users/edit/key --->
	<cffunction name="edit">
	
		<!--- Find the record --->
    	<cfset user = model("User").findByKey(params.key)>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(user)>
	        <cfset flashInsert(message="User #params.key# was not found", messageType="error")>
			<cfreturn redirectTo(action="index", delay=true)>
	    </cfif>
		
	</cffunction>
	
	<!--- users/create --->
	<cffunction name="create">
		<cfset user = model("User").new(params.user)>
		<cfset user.isAdministrator = true>

		<!--- Verify that the user creates successfully --->
		<cfif user.save()>
			<cfset flashInsert(message="The user was created successfully.", messageType="success")>
            <cfreturn redirectTo(action="index", delay=true)>
		<!--- Otherwise --->
		<cfelse>
			<cfset user.passwordToBlank()>
			<cfset flashInsert(message="There was an error creating the user.", messageType="error")>
			<cfset renderPage(action="new")>
		</cfif>
	</cffunction>
	
	<!--- users/update --->
	<cffunction name="update">
		<cfset user = model("User").findByKey(params.key)>
		
		<!--- Verify that the user updates successfully --->
		<cfif user.update(params.user)>
			<cfset flashInsert(message="The user was updated successfully.", messageType="success")>	
            <cfreturn redirectTo(action="index", delay=true)>
		<!--- Otherwise --->
		<cfelse>
			<cfset user.passwordToBlank()>
			<cfset flashInsert(message="There was an error updating the user.", messageType="error")>
			<cfset renderPage(action="edit")>
		</cfif>
	</cffunction>
	
	<!--- users/delete/key --->
	<cffunction name="delete">
		<cfset user = model("User").findByKey(params.key)>
		
		<!--- Verify that the user deletes successfully --->
		<cfif user.delete()>
			<cfset flashInsert(message="The user was deleted successfully.", messageType="success")>	
            <cfreturn redirectTo(action="index", delay=true)>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(message="There was an error deleting the user.", messageType="error")>
			<cfreturn redirectTo(action="index", delay=true)>
		</cfif>
	</cffunction>
	
</cfcomponent>
