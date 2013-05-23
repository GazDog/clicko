<cfcomponent extends="Controller" output="false">
	
	<cffunction name="init">
		<cfset super.init()>
		<!--- TODO: once automatic datafuntions is working.. use a private 'form' method --->
		<cfset filters(through="getCustomers", only="new,edit,create,update")>
	</cffunction>

	<!--- 
	** FILTERS **
	--->
	<cffunction name="getCustomers">
		<cfset customers = model("Customer").findAll(select="id, name", where="agencyid = #currentUser.agencyid#", order="name")>
	</cffunction>

	<!--- 
	** PUBLIC **
	--->

	<!--- publishers/index --->
	<cffunction name="index">
		<cfset publishers = model("Publisher").findAll(where="agencyid = #currentUser.agencyid#", include="customer(agency)")>
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
	        <cfset flashInsert(message="Publisher #params.key# was not found", messageType="error")>
			<cfreturn redirectTo(action="index", delay=true)>
	    </cfif>
		
	</cffunction>
	
	<!--- publishers/create --->
	<cffunction name="create">
		<cfset publisher = model("Publisher").new(params.publisher)>
		
		<!--- Verify that the publisher creates successfully --->
		<cfif publisher.save()>
			<cfset flashInsert(message="The publisher was created successfully.", messageType="success")>
            <cfreturn redirectTo(action="index", delay=true)>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(message="There was an error creating the publisher.", messageType="error")>
			<cfset renderPage(action="new")>
		</cfif>
	</cffunction>
	
	<!--- publishers/update --->
	<cffunction name="update">
		<cfset publisher = model("Publisher").findByKey(params.key)>
		
		<!--- Verify that the publisher updates successfully --->
		<cfif publisher.update(params.publisher)>
			<cfset flashInsert(message="The publisher was updated successfully.", messageType="success")>	
            <cfreturn redirectTo(action="index", delay=true)>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(message="There was an error updating the publisher.", messageType="error")>
			<cfset renderPage(action="edit")>
		</cfif>
	</cffunction>
	
	<!--- publishers/delete/key --->
	<cffunction name="delete">
		<cfset publisher = model("Publisher").findByKey(params.key)>
		
		<!--- Verify that the publisher deletes successfully --->
		<cfif publisher.delete()>
			<cfset flashInsert(message="The publisher was deleted successfully.", messageType="success")>	
            <cfreturn redirectTo(action="index", delay=true)>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(message="There was an error deleting the publisher.", messageType="error")>
			<cfreturn redirectTo(action="index", delay=true)>
		</cfif>
	</cffunction>
	
</cfcomponent>
