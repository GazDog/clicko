<h1>Showing agency</h1>

<cfoutput>#includePartial("showFlash")#</cfoutput>

<cfoutput>

			
				
					<p><span>Id</span> <br />
						#agency.id#</p>
				
					<p><span>Name</span> <br />
						#agency.name#</p>
				
					<p><span>Streetnumber</span> <br />
						#agency.streetnumber#</p>
				
					<p><span>Streetname</span> <br />
						#agency.streetname#</p>
				
					<p><span>Suburb</span> <br />
						#agency.suburb#</p>
				
					<p><span>Phone</span> <br />
						#agency.phone#</p>
				
					<p><span>Email</span> <br />
						#agency.email#</p>
				
					<p><span>Statusid</span> <br />
						#agency.statusid#</p>
				
					<p><span>Accesslevel</span> <br />
						#agency.accesslevel#</p>
				
					<p><span>Createdat</span> <br />
						#agency.createdat#</p>
				
					<p><span>Updatedat</span> <br />
						#agency.updatedat#</p>
				
					<p><span>Deletedat</span> <br />
						#agency.deletedat#</p>
				
			
		

#linkTo(text="Return to the listing", action="index")# | #linkTo(text="Edit this agency", action="edit", key=agency.id)#
</cfoutput>
