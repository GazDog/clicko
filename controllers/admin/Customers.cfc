<cfcomponent extends="Controller" output="false">
	
	<!--- customers/index --->
	<cffunction name="index">
		<cfset customers = model("Customer").findAll()>
	</cffunction>
	
	<!--- customers/show/key --->
	<cffunction name="show">
		
		<!--- Find the record --->
    	<cfset customer = model("Customer").findByKey(params.key)>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(customer)>
	        <cfset flashInsert(error="Customer #params.key# was not found")>
	        <cfreturn redirectTo(action="index", delay=true)>
	    </cfif>
			
	</cffunction>
	
	<!--- customers/new --->
	<cffunction name="new">
		<cfset customer = model("Customer").new()>
	</cffunction>
	
	<!--- customers/edit/key --->
	<cffunction name="edit">
	
		<!--- Find the record --->
    	<cfset customer = model("Customer").findByKey(params.key)>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(customer)>
	        <cfset flashInsert(error="Customer #params.key# was not found")>
			<cfreturn redirectTo(action="index", delay=true)>
	    </cfif>
		
	</cffunction>
	
	<!--- customers/create --->
	<cffunction name="create">
		<cfset customer = model("Customer").new(params.customer)>
		
		<!--- Verify that the customer creates successfully --->
		<cfif customer.save()>
			<cfset flashInsert(success="The customer was created successfully.")>
            <cfreturn redirectTo(action="index", delay=true)>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error creating the customer.")>
			<cfset renderPage(action="new")>
		</cfif>
	</cffunction>
	
	<!--- customers/update --->
	<cffunction name="update">
		<cfset customer = model("Customer").findByKey(params.key)>
		
		<!--- Verify that the customer updates successfully --->
		<cfif customer.update(params.customer)>
			<cfset flashInsert(success="The customer was updated successfully.")>	
            <cfreturn redirectTo(action="index", delay=true)>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the customer.")>
			<cfset renderPage(action="edit")>
		</cfif>
	</cffunction>
	
	<!--- customers/delete/key --->
	<cffunction name="delete">
		<cfset customer = model("Customer").findByKey(params.key)>
		
		<!--- Verify that the customer deletes successfully --->
		<cfif customer.delete()>
			<cfset flashInsert(success="The customer was deleted successfully.")>	
            <cfreturn redirectTo(action="index", delay=true)>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the customer.")>
			<cfreturn redirectTo(action="index", delay=true)>
		</cfif>
	</cffunction>
	
</cfcomponent>
