<h1>Showing publisher</h1>

<cfoutput>#includePartial("showFlash")#</cfoutput>

<cfoutput>

			
				
					<p><span>Id</span> <br />
						#publisher.id#</p>
				
					<p><span>Customerid</span> <br />
						#publisher.customerid#</p>
				
					<p><span>Name</span> <br />
						#publisher.name#</p>
				
					<p><span>Website</span> <br />
						#publisher.website#</p>
				
					<p><span>Contactname</span> <br />
						#publisher.contactname#</p>
				
					<p><span>Phone</span> <br />
						#publisher.phone#</p>
				
					<p><span>Email</span> <br />
						#publisher.email#</p>
				
					<p><span>Statusid</span> <br />
						#publisher.statusid#</p>
				
					<p><span>Createdat</span> <br />
						#publisher.createdat#</p>
				
					<p><span>Updatedat</span> <br />
						#publisher.updatedat#</p>
				
					<p><span>Deletedat</span> <br />
						#publisher.deletedat#</p>
				
			
		

#linkTo(text="Return to the listing", action="index")# | #linkTo(text="Edit this publisher", action="edit", key=publisher.id)#
</cfoutput>
