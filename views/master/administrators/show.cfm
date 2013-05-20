<h1>Showing user</h1>

<cfoutput>#includePartial("showFlash")#</cfoutput>

<cfoutput>

			
				
					<p><span>Id</span> <br />
						#user.id#</p>
				
					<p><span>Agencyid</span> <br />
						#user.agencyid#</p>
				
					<p><span>Isadministrator</span> <br />
						#user.isadministrator#</p>
				
					<p><span>Firstname</span> <br />
						#user.firstname#</p>
				
					<p><span>Lastname</span> <br />
						#user.lastname#</p>
				
					<p><span>Phone</span> <br />
						#user.phone#</p>
				
					<p><span>Email</span> <br />
						#user.email#</p>
				
					<p><span>Accesslevel</span> <br />
						#user.accesslevel#</p>
				
					<p><span>Statusid</span> <br />
						#user.statusid#</p>
				
					<p><span>Password</span> <br />
						#user.password#</p>
				
					<p><span>Salt</span> <br />
						#user.salt#</p>
				
					<p><span>Passwordresettoken</span> <br />
						#user.passwordresettoken#</p>
				
					<p><span>Passwordresetat</span> <br />
						#user.passwordresetat#</p>
				
					<p><span>Isconfirmed</span> <br />
						#user.isconfirmed#</p>
				
					<p><span>Emailconfirmationtoken</span> <br />
						#user.emailconfirmationtoken#</p>
				
					<p><span>Lastloginat</span> <br />
						#user.lastloginat#</p>
				
					<p><span>Logincount</span> <br />
						#user.logincount#</p>
				
					<p><span>Createdat</span> <br />
						#user.createdat#</p>
				
					<p><span>Updatedat</span> <br />
						#user.updatedat#</p>
				
					<p><span>Deletedat</span> <br />
						#user.deletedat#</p>
				
			
		

#linkTo(text="Return to the listing", action="index")# | #linkTo(text="Edit this user", action="edit", key=user.id)#
</cfoutput>
