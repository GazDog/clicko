<cfoutput>

	#pageTitle('Add Administrator')#
			
	#errorMessagesFor("user")#
	
	<div class="row">
		<div class="span12">
			#startFormTag(action="create")#
				<fieldset>
		
					#includePartial("form")#

					<div class="form-actions">
						#submitTag(value="Save", class="btn btn-primary")#
						#linkTo(text="Cancel", action="index", class="btn")#
					</div>
				</fieldset>
			#endFormTag()#
		</div>		
	</div>		

</cfoutput>