<cfoutput>
	#pageTitle("Publishers")#

	#flashMessageTag()#
	
	<p>#linkTo(text="New Publisher", action="new", class="btn")#</p>
	
	<table class="table table-striped">
		<thead>
			<tr>
				<th>Name</th>
				<th>Website</th>
				<th>Contact</th>
				<th>Phone</th>
				<th>Email</th>
				<th>Created</th>
				<th class="span1"></th>
				<th class="span1"></th>
			</tr>
		</thead>
		<tbody>
			<cfoutput query="publishers">
				<tr>
					<td>#linkTo(text="#name#", action='show', key=id)#</td>
					<td>#linkTo(href=website, text=shortURL(website), target="_blank")#</td>
					<td>#contactName#</td>
					<td>#phone#</td>
					<td>#email#</td>
					<td>#timeAgoInWords(createdAt)# ago</td>
					<td>#linkTo(text='Edit', action='edit', key=id)#</td>
					<td>#linkTo(text='Delete', action='delete', key=id, confirm='Are you sure?')#</td>
				</tr>
			</cfoutput>
		</tbody>
	</table>
</cfoutput>