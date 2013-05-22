<cfoutput>
	#pageTitle("#get('appName')# Administrators")#

	#flashMessageTag()#
	
	<p>#linkTo(text="New Administrator", action="new", class="btn")#</p>
	
	<table class="table table-striped">
		<thead>
			<tr>
				<th>Name</th>
				<th>Email</th>
				<th>Access</th>
				<th>Last Login</th>
				<th class="span1"></th>
				<th class="span1"></th>
			</tr>
		</thead>
		<tbody>
			<cfoutput query="users">
				<tr>
					<td>#linkTo(text="#firstName# #lastName#", action='show', key=id)#</td>
					<td>#email#</td>
					<td>#accessLevel#</td>
					<td><cfif lastLoginAt eq "">--<cfelse>#timeAgoInWords(Lastloginat)# ago</cfif></td>
					<td>#linkTo(text='Edit', action='edit', key=id)#</td>
					<td>#linkTo(text='Delete', action='delete', key=id, confirm='Are you sure? This is VERY dangerous!')#</td>
				</tr>
			</cfoutput>
		</tbody>
	</table>
</cfoutput>