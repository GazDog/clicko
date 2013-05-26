<cfcomponent extends="Controller" output="false">
	
	<cffunction name="init">
		<cfset super.init()>
	</cffunction>



	<!--- TODO: filters --->
	<!--- TODO: messages --->
	<!--- TODO: where agencyid = x --->

	<!--- 
	** FILTERS **
	--->
	<cffunction name="getCustomers">
		<cfset customers = model("Customer").findAll(select="id, name", where="agencyid = #currentUser.agencyid#", order="name")>
	</cffunction>

	<!--- 
	** PUBLIC **
	--->

	<!--- assets/index --->
	<cffunction name="index">
		<cfset assets = model("Asset").findAll(include="Publisher(Customer),Campaign")>
	</cffunction>
	
	<!--- assets/show/key --->
	<cffunction name="show">
		
		<!--- Find the record --->
    	<cfset asset = model("Asset").findByKey(params.key)>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(asset)>
	        <cfset flashInsert(error="Asset #params.key# was not found")>
	        <cfreturn redirectTo(action="index", delay=true)>
	    </cfif>
			
	</cffunction>
	
	<!--- assets/new --->
	<cffunction name="new">
		<cfset asset = model("Asset").new()>
	</cffunction>
	
	<!--- assets/edit/key --->
	<cffunction name="edit">
	
		<!--- Find the record --->
    	<cfset asset = model("Asset").findByKey(params.key)>
    	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(asset)>
	        <cfset flashInsert(error="Asset #params.key# was not found")>
			<cfreturn redirectTo(action="index", delay=true)>
	    </cfif>
		
	</cffunction>
	
	<!--- assets/create --->
	<cffunction name="create">
		<cfset asset = model("Asset").new(params.asset)>
		
		<!--- Verify that the asset creates successfully --->
		<cfif asset.save()>
			<cfset flashInsert(success="The asset was created successfully.")>
            <cfreturn redirectTo(action="index", delay=true)>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error creating the asset.")>
			<cfset renderPage(action="new")>
		</cfif>
	</cffunction>
	
	<!--- assets/update --->
	<cffunction name="update">
		<cfset asset = model("Asset").findByKey(params.key)>
		
		<!--- Verify that the asset updates successfully --->
		<cfif asset.update(params.asset)>
			<cfset flashInsert(success="The asset was updated successfully.")>	
            <cfreturn redirectTo(action="index", delay=true)>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error updating the asset.")>
			<cfset renderPage(action="edit")>
		</cfif>
	</cffunction>
	
	<!--- assets/delete/key --->
	<cffunction name="delete">
		<cfset asset = model("Asset").findByKey(params.key)>
		
		<!--- Verify that the asset deletes successfully --->
		<cfif asset.delete()>
			<cfset flashInsert(success="The asset was deleted successfully.")>	
            <cfreturn redirectTo(action="index", delay=true)>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(error="There was an error deleting the asset.")>
			<cfreturn redirectTo(action="index", delay=true)>
		</cfif>
	</cffunction>
	
</cfcomponent>
