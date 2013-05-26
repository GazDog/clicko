<cfoutput>

	#pageTitle("#campaign.name# - #campaign.customer.name#")#		
				
					<p><span>Id</span> <br />
						#campaign.id#</p>
				
					<p><span>Customerid</span> <br />
						#campaign.customerid#</p>
				
					<p><span>Name</span> <br />
						#campaign.name#</p>
				
					<p><span>Startat</span> <br />
						#campaign.startat#</p>
				
					<p><span>Finishat</span> <br />
						#campaign.finishat#</p>
				
					<p><span>Creatoruserid</span> <br />
						#campaign.creatoruserid#</p>
				
					<p><span>Createdat</span> <br />
						#campaign.createdat#</p>
				
					<p><span>Updatedat</span> <br />
						#campaign.updatedat#</p>
				
					<p><span>Deletedat</span> <br />
						#campaign.deletedat#</p>
				
			
		

#linkTo(text="Return to the listing", action="index")# | #linkTo(text="Edit this campaign", action="edit", key=campaign.id)#
</cfoutput>
