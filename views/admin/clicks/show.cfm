<h1>Showing click</h1>

<cfoutput>#includePartial("showFlash")#</cfoutput>

<cfoutput>

			
				
					<p><span>Id</span> <br />
						#click.id#</p>
				
					<p><span>Assetid</span> <br />
						#click.assetid#</p>
				
					<p><span>Ipaddress</span> <br />
						#click.ipaddress#</p>
				
					<p><span>Browser</span> <br />
						#click.browser#</p>
				
					<p><span>Browserversion</span> <br />
						#click.browserversion#</p>
				
					<p><span>Createdat</span> <br />
						#click.createdat#</p>
				
			
		

#linkTo(text="Return to the listing", action="index")# | #linkTo(text="Edit this click", action="edit", key=click.id)#
</cfoutput>
