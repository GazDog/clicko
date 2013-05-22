<cfcomponent extends="Controller" output="false">
	
	<cffunction name="init">
		<cfset super.init()>
	</cffunction>

	<!--- customers/index --->
	<cffunction name="index">
		<cfset customers = model("Customer").findAll(where="agencyid = #currentUser.agencyid#")>
	</cffunction>
	
	<!--- customers/show/key --->
	<cffunction name="show">
		
		<!--- Find the record --->
    	<cfset customer = model("Customer").findByKey(key=params.key, where="agencyid = #currentUser.agencyid#")>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(customer)>
	        <cfset flashInsert(message="Customer #params.key# was not found", messageType="error")>
	        <cfreturn redirectTo(action="index", delay=true)>
	    </cfif>
		
	    <cfset publishers = model("Publisher").findAll(where="agencyid = #currentUser.agencyid# AND customerid = #customer.key()#", include="customer", order="name")>
	    <cfset campaigns = model("Campaign").findAll(where="agencyid = #currentUser.agencyid# AND customerid = #customer.key()#", include="customer", order="name")>
	    <cfset assets = model("Asset").findAll(where="agencyid = #currentUser.agencyid# AND customerid = #customer.key()#", include="publisher(customer),campaign")>

	</cffunction>
	
	<!--- customers/new --->
	<cffunction name="new">
		<cfset customer = model("Customer").new()>
	</cffunction>
	
	<!--- customers/edit/key --->
	<cffunction name="edit">
	
		<!--- Find the record --->
    	<cfset customer = model("Customer").findByKey(key=params.key, where="agencyid = #currentUser.agencyid#")>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(customer)>
	        <cfset flashInsert(message="Customer #params.key# was not found", messageType="error")>
			<cfreturn redirectTo(action="index", delay=true)>
	    </cfif>
		
	</cffunction>
	
	<!--- customers/create --->
	<cffunction name="create">
		<cfset customer = model("Customer").new(params.customer)>
		<cfset customer.agencyid = currentUser.agencyid>
		
		<!--- Verify that the customer creates successfully --->
		<cfif customer.save()>
			<cfset flashInsert(message="The customer was created successfully.", messageType="success")>
            <cfreturn redirectTo(action="index", delay=true)>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(message="There was an error creating the customer.", messageType="error")>
			<cfset renderPage(action="new")>
		</cfif>
	</cffunction>
	
	<!--- customers/update --->
	<cffunction name="update">
		<cfset customer = model("Customer").findByKey(key=params.key, where="agencyid = #currentUser.agencyid#")>
		
		<!--- Verify that the customer updates successfully --->
		<cfif customer.update(params.customer)>
			<cfset flashInsert(message="The customer was updated successfully.", messageType="success")>	
            <cfreturn redirectTo(action="index", delay=true)>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(message="There was an error updating the customer.", messageType="error")>
			<cfset renderPage(action="edit")>
		</cfif>
	</cffunction>
	
	<!--- customers/delete/key --->
	<cffunction name="delete">
		<cfset customer = model("Customer").findByKey(key=params.key, where="agencyid = #currentUser.agencyid#")>
		
		<!--- Verify that the customer deletes successfully --->
		<cfif customer.delete()>
			<cfset flashInsert(message="The customer was deleted successfully.", messageType="success")>	
            <cfreturn redirectTo(action="index", delay=true)>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(message="There was an error deleting the customer.", messageType="error")>
			<cfreturn redirectTo(action="index", delay=true)>
		</cfif>
	</cffunction>
	
</cfcomponent>
