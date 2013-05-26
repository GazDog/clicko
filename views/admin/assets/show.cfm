<cfoutput>

	#pageTitle("#asset.name#")#			
				
					<p><span>Id</span> <br />
						#asset.id#</p>
				
					<p><span>Campaignid</span> <br />
						#asset.campaignid#</p>
				
					<p><span>Publisherid</span> <br />
						#asset.publisherid#</p>
				
					<p><span>Name</span> <br />
						#asset.name#</p>
				
					<p><span>Sourceurl</span> <br />
						#generateURL(asset.id)#</p>
				
					<p><span>Destinationurl</span> <br />
						#asset.destinationurl#</p>
				
					<p><span>Startat</span> <br />
						#asset.startat#</p>
				
					<p><span>Finishat</span> <br />
						#asset.finishat#</p>
				
					<p><span>Notes</span> <br />
						#asset.notes#</p>
				
					<p><span>Createdat</span> <br />
						#asset.createdat#</p>
				
					<p><span>Updatedat</span> <br />
						#asset.updatedat#</p>
				
					<p><span>Deletedat</span> <br />
						#asset.deletedat#</p>
				
			
		

#linkTo(text="Return to the listing", action="index")# | #linkTo(text="Edit this asset", action="edit", key=asset.id)#
</cfoutput>
