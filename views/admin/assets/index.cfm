<h1>Listing assets</h1>

<cfoutput>#includePartial("showFlash")#</cfoutput>

<cfoutput>
	<p>#linkTo(text="New asset", action="new")#</p>
</cfoutput>

<cftable query="assets" colHeaders="true" HTMLTable="true">
	
			
				
					<cfcol header="Id" text="#id#" />
				
					<cfcol header="Campaignid" text="#campaignid#" />
				
					<cfcol header="Publisherid" text="#publisherid#" />
				
					<cfcol header="Name" text="#name#" />
				
					<cfcol header="Sourceurl" text="#sourceurl#" />
				
					<cfcol header="Destinationurl" text="#destinationurl#" />
				
					<cfcol header="Startat" text="#startat#" />
				
					<cfcol header="Finishat" text="#finishat#" />
				
					<cfcol header="Notes" text="#notes#" />
				
					<cfcol header="Createdat" text="#createdat#" />
				
					<cfcol header="Updatedat" text="#updatedat#" />
				
					<cfcol header="Deletedat" text="#deletedat#" />
				
			
		
	<cfcol header="" text="#linkTo(text='Show', action='show', key=id)#" />
	<cfcol header="" text="#linkTo(text='Edit', action='edit', key=id)#" />
	<cfcol header="" text="#linkTo(text='Delete', action='delete', key=id, confirm='Are you sure?')#" />
</cftable>

