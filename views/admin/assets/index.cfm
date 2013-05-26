<cfoutput>
	
	#pageTitle("Assets")#
	
	<p>#linkTo(text="New Asset", action="new", class="btn")#</p>
	
	<table class="table table-striped">
		<thead>
			<tr>
				<th>Name</th>
				<th>Customer</th>
				<th>Publisher</th>
				<th>Campaign</th>
				<th>#get('appName')# URL</th>
				<th>Destination</th>
				<th>Start</th>
				<th>Finish</th>
				<th>Note</th>
				<th>Created</th>
				<th class="span1"></th>
				<th class="span1"></th>
			</tr>
		</thead>
		<tbody>
			<cfoutput query="assets">
				<tr>
					<td>#linkTo(text=name, action='show', key=id)#</td>
					<td>#linkTo(text=customerName, controller="customer", action="show", key=customerid)#</td>
					<td>#linkTo(text=publisherName, route="customerPublishersShow", customerid=customerid, key=publisherid)#</td>
					<td>#linkTo(text=campaignName, route="customerCampaignsShow", customerid=customerid, key=campaignid)#</td>
					<td>#generateURL(id)#</td>
					<td>#destinationURL#</td>
					<td>#showDate(startAt)#</td>
					<td>#showDate(finishAt)#</td>
					<td><icon clas="icon-comment"></icon></td>
					<td>#timeAgoInWords(createdAt)# ago</td>
					<td>#linkTo(text='Edit', action='edit', key=id)#</td>
					<td>#linkTo(text='Delete', action='delete', key=id, confirm='Are you sure?')#</td>
				</tr>
			</cfoutput>
		</tbody>
	</table>
</cfoutput>