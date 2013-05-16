<cfcomponent extends="Controller">
	
	<cffunction name="index">
		
		<cfif StructKeyExists(params, "key")>
		
			<!--- find the asset by key --->
			<cfset asset = model("Asset").findByKey(key=deObfuscateParam(params.key))>
			<!--- if found, log a click and send the user on.. --->
			<cfif IsObject(asset)>
				
				<cfset model("Click").create(
					assetid=asset.key()
					,ipaddress=cgi.remote_addr
					,browser=browserDetect()
				)>
				<!--- go to the destination url --->
				<cflocation url="#asset.destinationURL#" statuscode="302" addtoken="false">

			<cfelse>
				<!--- ruh roh!? --->
				<cfset renderText("Link not found")>
			</cfif>
		<cfelse>
			<!--- ruh roh!? --->
			<cfset renderText("Param/s not found")>
		</cfif>

	</cffunction>

</cfcomponent>