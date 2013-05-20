<h1>Listing users</h1>

<cfoutput>#includePartial("showFlash")#</cfoutput>

<cfoutput>
	<p>#linkTo(text="New user", action="new")#</p>
</cfoutput>

<cftable query="users" colHeaders="true" HTMLTable="true">
	
			
				
					<cfcol header="Id" text="#id#" />
				
					<cfcol header="Agencyid" text="#agencyid#" />
				
					<cfcol header="Isadministrator" text="#isadministrator#" />
				
					<cfcol header="Firstname" text="#firstname#" />
				
					<cfcol header="Lastname" text="#lastname#" />
				
					<cfcol header="Phone" text="#phone#" />
				
					<cfcol header="Email" text="#email#" />
				
					<cfcol header="Accesslevel" text="#accesslevel#" />
				
					<cfcol header="Statusid" text="#statusid#" />
				
					<cfcol header="Password" text="#password#" />
				
					<cfcol header="Salt" text="#salt#" />
				
					<cfcol header="Passwordresettoken" text="#passwordresettoken#" />
				
					<cfcol header="Passwordresetat" text="#passwordresetat#" />
				
					<cfcol header="Isconfirmed" text="#isconfirmed#" />
				
					<cfcol header="Emailconfirmationtoken" text="#emailconfirmationtoken#" />
				
					<cfcol header="Lastloginat" text="#lastloginat#" />
				
					<cfcol header="Logincount" text="#logincount#" />
				
					<cfcol header="Createdat" text="#createdat#" />
				
					<cfcol header="Updatedat" text="#updatedat#" />
				
					<cfcol header="Deletedat" text="#deletedat#" />
				
			
		
	<cfcol header="" text="#linkTo(text='Show', action='show', key=id)#" />
	<cfcol header="" text="#linkTo(text='Edit', action='edit', key=id)#" />
	<cfcol header="" text="#linkTo(text='Delete', action='delete', key=id, confirm='Are you sure?')#" />
</cftable>

