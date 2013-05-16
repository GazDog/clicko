<h1>Showing customer</h1>

<cfoutput>#includePartial("showFlash")#</cfoutput>

<cfoutput>

			
				
					<p><span>Id</span> <br />
						#customer.id#</p>
				
					<p><span>Agencyid</span> <br />
						#customer.agencyid#</p>
				
					<p><span>Name</span> <br />
						#customer.name#</p>
				
					<p><span>Website</span> <br />
						#customer.website#</p>
				
					<p><span>Phone</span> <br />
						#customer.phone#</p>
				
					<p><span>Email</span> <br />
						#customer.email#</p>
				
					<p><span>Statusid</span> <br />
						#customer.statusid#</p>
				
					<p><span>Accesslevel</span> <br />
						#customer.accesslevel#</p>
				
					<p><span>Createdat</span> <br />
						#customer.createdat#</p>
				
					<p><span>Updatedat</span> <br />
						#customer.updatedat#</p>
				
					<p><span>Deletedat</span> <br />
						#customer.deletedat#</p>
				
			
		

#linkTo(text="Return to the listing", action="index")# | #linkTo(text="Edit this customer", action="edit", key=customer.id)#
</cfoutput>
