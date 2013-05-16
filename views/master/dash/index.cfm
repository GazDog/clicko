<table>
	<thead>
		<tr>
			<th>##</th>
			<th>URL</th>
			<th>Destination</th>
			<th>Clicks</th>
		</tr>
	</thead>
	<cfoutput query="assets">
		<tr>
			<td>#id#</td>
			<td>#linkTo(href=generateURL(id), target="blank")#</td>
			<td>#destinationURL#</td>
			<td>
				<!--- dodgey!! --->
				<cfset cnt = model('Click').count(where="assetid = #id#")>
				#cnt#
			</td>
		</tr>
	</cfoutput>
</table>