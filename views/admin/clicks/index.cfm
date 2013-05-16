<h1>Listing clicks</h1>

<cfoutput>#includePartial("showFlash")#</cfoutput>

<cfoutput>
	<p>#linkTo(text="New click", action="new")#</p>
</cfoutput>

<cftable query="clicks" colHeaders="true" HTMLTable="true">
	
			
				
					<cfcol header="Id" text="#id#" />
				
					<cfcol header="Assetid" text="#assetid#" />
				
					<cfcol header="Ipaddress" text="#ipaddress#" />
				
					<cfcol header="Browser" text="#browser#" />
				
					<cfcol header="Browserversion" text="#browserversion#" />
				
					<cfcol header="Createdat" text="#createdat#" />
				
			
		
	<cfcol header="" text="#linkTo(text='Show', action='show', key=id)#" />
	<cfcol header="" text="#linkTo(text='Edit', action='edit', key=id)#" />
	<cfcol header="" text="#linkTo(text='Delete', action='delete', key=id, confirm='Are you sure?')#" />
</cftable>

