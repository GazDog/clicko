<cfoutput>
	
	#pageTitle("Campaigns")#
	
	<p>#linkTo(text="New Campaign", action="new", class="btn")#</p>
	
	<table class="table table-striped">
		<thead>
			<tr>
				<th>Name</th>
				<th>Customer</th>
				<th>Start</th>
				<th>Finish</th>
				<th>Created</th>
				<th class="span1"></th>
				<th class="span1"></th>
			</tr>
		</thead>
		<tbody>
			<cfoutput query="campaigns">
				<tr>
					<td>#linkTo(text=name, action='show', key=id)#</td>
					<td>#linkTo(text=customerName, route="customerPublishersShow", customerid=customerid, key=id)#</td>
					<td>#showDate(startAt)#</td>
					<td>#showDate(finishAt)#</td>
					<td>#timeAgoInWords(createdAt)# ago by #firstName#</td>
					<td>#linkTo(text='Edit', action='edit', key=id)#</td>
					<td>#linkTo(text='Delete', action='delete', key=id, confirm='Are you sure?')#</td>
				</tr>
			</cfoutput>
		</tbody>
	</table>
</cfoutput>