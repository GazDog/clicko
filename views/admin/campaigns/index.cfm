<h1>Listing campaigns</h1>

<cfoutput>#includePartial("showFlash")#</cfoutput>

<cfoutput>
	<p>#linkTo(text="New campaign", action="new")#</p>
</cfoutput>

<cftable query="campaigns" colHeaders="true" HTMLTable="true">
	
			
				
					<cfcol header="Id" text="#id#" />
				
					<cfcol header="Customerid" text="#customerid#" />
				
					<cfcol header="Name" text="#name#" />
				
					<cfcol header="Startat" text="#startat#" />
				
					<cfcol header="Finishat" text="#finishat#" />
				
					<cfcol header="Creatoruserid" text="#creatoruserid#" />
				
					<cfcol header="Createdat" text="#createdat#" />
				
					<cfcol header="Updatedat" text="#updatedat#" />
				
					<cfcol header="Deletedat" text="#deletedat#" />
				
			
		
	<cfcol header="" text="#linkTo(text='Show', action='show', key=id)#" />
	<cfcol header="" text="#linkTo(text='Edit', action='edit', key=id)#" />
	<cfcol header="" text="#linkTo(text='Delete', action='delete', key=id, confirm='Are you sure?')#" />
</cftable>

