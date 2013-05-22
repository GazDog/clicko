<cfoutput>

	<h1>#pageTitle(customer.name)#</h1>			
	
	<div class="row-fluid">
		<div class="span4">
			<p><span>Id</span> <br />
				#customer.id#</p>

			<p><span>Agencyid</span> <br />
				#customer.agencyid#</p>

			<p><span>Name</span> <br />
				#customer.name#</p>

			<p><span>Website</span> <br />
				#customer.website#</p>

			<p><span>Phone</span> <br />
				#customer.phone#</p>

			<p><span>Email</span> <br />
				#customer.email#</p>

			<p><span>Statusid</span> <br />
				#customer.statusid#</p>

			<p><span>Accesslevel</span> <br />
				#customer.accesslevel#</p>

			<p><span>Createdat</span> <br />
				#customer.createdat#</p>

			<p><span>Updatedat</span> <br />
				#customer.updatedat#</p>

			<p><span>Deletedat</span> <br />
				#customer.deletedat#</p>
		</div>
		<div class="span8">
			<h3>Publishers</h3>
			<table class="table table-striped">
				<tbody>
					<cfoutput query="publishers">
						<tr>
							<td>#linkTo(text=name, route="customerPublishersShow", customerid=customer.key(), key=id)#</td>
							<td>#timeAgoInWords(createdAt)#</td>
						</tr>
					</cfoutput>
				</tbody>
			</table>

			<h3>Campaigns</h3>
			<table class="table table-striped">
				<tbody>
					<cfoutput query="campaigns">
						<tr>
							<td>#linkTo(text=name, route="customerCampaignsShow", customerid=customer.key(), key=id)#</td>
							<td>#timeAgoInWords(createdAt)#</td>
						</tr>
					</cfoutput>
				</tbody>
			</table>

			<h3>Assets</h3>
			<table class="table table-striped">
				<thead>
					<tr>
						<th>Name</th>
						<th>Publisher</th>
						<th>Campaign</th>
						<th>Created</th>
					</tr>
				</thead>
				<tbody>
					<cfoutput query="assets">
						<tr>
							<td>#linkTo(text=name, route="customerAssetsShow", customerid=customer.key(), key=id)#</td>
							<td>#linkTo(text=publisherName, route="customerPublishersShow", customerid=customer.key(), key=publisherId)#</td>
							<td>#linkTo(text=campaignName, route="customerAssetsShow", customerid=customer.key(), key=campaignId)#</td>
							<td>#timeAgoInWords(createdAt)#</td>
						</tr>
					</cfoutput>
				</tbody>
			</table>
		</div>
	</div>


#linkTo(text="Back", back=true, class="btn")# #linkTo(text="Edit", action="edit", key=customer.id, class="btn btn-primary")#
</cfoutput>
