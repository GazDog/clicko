<cfoutput>

	#contentFor(pageTitle="#get('appName')# - Home Page")#

	<div class="container">
		<div class="page-header">
			<h1>CFWheels User Manager</h1>
		</div>
		<div class="row">
			<div class="span7">
				#flashMessageTag()#
				<p>Assuming you created the data source and the database using the provided SQL file, see the users table accross for usage details.</p>
				<p>#linkTo(text="Sign in", route="admin", class="btn primary")#</p>
			</div>
			<div class="span9">
				<div class="well">
					<p>You can login with the following credentials:</p>
					<table>
						<thead>
							<tr>
								<th>Name</th>
								<th>Username</th>
								<th>Password</th>
								<th>Role</th>
							</tr>
						</thead>
						<tbody>
							<cfloop query="users">
								<tr>
									<td>#users.firstname# #users.lastname#</td>
									<td>#users.email#</td>
									<td>password123</td>
									<td>#users.isadministrator ? "Admin" : "User"#</td>
								</tr>
							</cfloop>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>

</cfoutput>