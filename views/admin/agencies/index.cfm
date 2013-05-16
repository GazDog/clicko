<h1>Listing agencies</h1>

<cfoutput>#includePartial("showFlash")#</cfoutput>

<cfoutput>
	<p>#linkTo(text="New agency", action="new")#</p>
</cfoutput>

<cftable query="agencies" colHeaders="true" HTMLTable="true">
	
			
				
					<cfcol header="Id" text="#id#" />
				
					<cfcol header="Name" text="#name#" />
				
					<cfcol header="Streetnumber" text="#streetnumber#" />
				
					<cfcol header="Streetname" text="#streetname#" />
				
					<cfcol header="Suburb" text="#suburb#" />
				
					<cfcol header="Phone" text="#phone#" />
				
					<cfcol header="Email" text="#email#" />
				
					<cfcol header="Statusid" text="#statusid#" />
				
					<cfcol header="Accesslevel" text="#accesslevel#" />
				
					<cfcol header="Createdat" text="#createdat#" />
				
					<cfcol header="Updatedat" text="#updatedat#" />
				
					<cfcol header="Deletedat" text="#deletedat#" />
				
			
		
	<cfcol header="" text="#linkTo(text='Show', action='show', key=id)#" />
	<cfcol header="" text="#linkTo(text='Edit', action='edit', key=id)#" />
	<cfcol header="" text="#linkTo(text='Delete', action='delete', key=id, confirm='Are you sure?')#" />
</cftable>

