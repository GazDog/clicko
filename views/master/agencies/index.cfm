<cfoutput>
	#pageTitle("Agencies")#
	
	<p>#linkTo(text="New Agency", action="new", class="btn")#</p>
	
	<table class="table table-striped">
		<thead>
			<tr>
				<th>Name</th>
				<th>Address</th>
				<th>Status</th>
				<th>Created</th>
				<th class="span1"></th>
				<th class="span1"></th>
			</tr>
		</thead>
		<tbody>
			<cfoutput query="agencies">
				<tr>
					<td>#linkTo(text=name, action='show', key=id)#</td>
					<td>#streetNumber# #streetName#, #suburb#</td>
					<td>#statusid#</td>
					<td>#timeAgoInWords(createdAt)# ago</td>
					<td>#linkTo(text='Edit', action='edit', key=id)#</td>
					<td>#linkTo(text='Delete', action='delete', key=id, confirm='Are you sure?')#</td>
				</tr>
			</cfoutput>
		</tbody>
	</table>
</cfoutput>