<cfcomponent extends="Controller" output="false">
	
	<cffunction name="init">
		<cfset super.init()>
		<!--- TODO: once automatic datafuntions is working.. use a private 'form' method --->
		<cfset filters(through="getCustomers", only="new,edit,create,update")>
		<cfset filters(through="getCampaign", only="show,edit,update,delete")>
	</cffunction>

	<!--- 
	** FILTERS **
	--->
	<cffunction name="getCustomers">
		<cfset customers = model("Customer").findAll(select="id, name", where="agencyid = #currentUser.agencyid#", order="name")>
	</cffunction>

	<cffunction name="getCampaign">
		<cfset campaign = model("Campaign").findOneByIdAndAgencyid(params="#params.key#,#currentUser.agencyid#", include="Customer")>
	</cffunction>

	<!--- 
	** PUBLIC **
	--->

	<!--- campaigns/index --->
	<cffunction name="index">
		<cfset campaigns = model("Campaign").findAll(where="agencyid = #currentUser.agencyid#", include="Customer,User", order="name")>
	</cffunction>
	
	<!--- campaigns/show/key --->
	<cffunction name="show">
		
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(campaign)>
	        <cfset flashInsert(message="Campaign #params.key# was not found", messageType="error")>
	        <cfreturn redirectTo(action="index", delay=true)>
	    </cfif>
			
	</cffunction>
	
	<!--- campaigns/new --->
	<cffunction name="new">
		<cfset campaign = model("Campaign").new()>
	</cffunction>
	
	<!--- campaigns/edit/key --->
	<cffunction name="edit">
	
    	<!--- Check if the record exists --->
	    <cfif NOT IsObject(campaign)>
	        <cfset flashInsert(message="Campaign #params.key# was not found", messageType="error")>
			<cfreturn redirectTo(action="index", delay=true)>
	    </cfif>
		
	</cffunction>
	
	<!--- campaigns/create --->
	<cffunction name="create">
		<cfset campaign = model("Campaign").new(params.campaign)>
		
		<!--- Verify that the campaign creates successfully --->
		<cfif campaign.save()>
			<cfset flashInsert(message="The campaign was created successfully.", messageType="success")>
            <cfreturn redirectTo(action="index", delay=true)>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(message="There was an error creating the campaign.", messageType="error")>
			<cfset renderPage(action="new")>
		</cfif>
	</cffunction>
	
	<!--- campaigns/update --->
	<cffunction name="update">
		
		<!--- Verify that the campaign updates successfully --->
		<cfif campaign.update(params.campaign)>
			<cfset flashInsert(message="The campaign was updated successfully.", messageType="success")>	
            <cfreturn redirectTo(action="index", delay=true)>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(message="There was an error updating the campaign.", messageType="error")>
			<cfset renderPage(action="edit")>
		</cfif>
	</cffunction>
	
	<!--- campaigns/delete/key --->
	<cffunction name="delete">
		
		<!--- Verify that the campaign deletes successfully --->
		<cfif campaign.delete()>
			<cfset flashInsert(message="The campaign was deleted successfully.", messageType="success")>	
            <cfreturn redirectTo(action="index", delay=true)>
		<!--- Otherwise --->
		<cfelse>
			<cfset flashInsert(message="There was an error deleting the campaign.", messageType="error")>
			<cfreturn redirectTo(action="index", delay=true)>
		</cfif>
	</cffunction>
	
</cfcomponent>
