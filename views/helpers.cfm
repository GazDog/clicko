<cffunction name="flashMessageTag" access="public" output="false" returnType="string" hint="Flashes any avalable messages in the flash.">
	<cfset local.html = "">
	<cfif flashKeyExists("message")>
		<cfsavecontent variable="local.html">
			<cfoutput>
				<div class="alert alert-#flash('messageType')#" data-dismiss="alert">
					<a class="close">&times;</a>
					#flash("message")#
				</div>
			</cfoutput>
		</cfsavecontent>
	</cfif>
	<cfreturn local.html>
</cffunction>

<cffunction name="pageTitle" access="public" output="false" returnType="string" hint="Sets and displays page title">
	<cfargument name="title" type="string" required="true">
	<cfset var loc = {} />
	<!--- NOTE: pageTitle variable also used in _htmlOpen partial for html title tag--->
	<cfset contentFor(pageTitle=arguments.title)>
	<cfsavecontent variable="loc.html">
		<cfoutput>
			<div class="page-header">
				<h2>#includeContent("pageTitle")#</h2>
			</div>
		</cfoutput>
	</cfsavecontent>
	<cfreturn loc.html>
</cffunction>

<cffunction name="input" access="public" output="false" returntype="string" hint="render form input types with containing HTML">
	<cfargument name="inputType" type="string" required="true">
	<cfset var loc = {} />
	
	<!--- extract the label, then set to false for actual wheels function call --->
	<cfif !StructKeyExists(arguments,"label")>
		<cfset arguments.label = titleize(StructKeyExists(arguments,"objectName") ? arguments.property : arguments.name)>
	</cfif>
	
	<!--- build an attribute structure for the controlGroup tag --->
	<cfset loc.tagAttr = {}>
	<cfset loc.tagAttr.label = arguments.label>
	<cfset loc.tagAttr.for = StructKeyExists(arguments,"objectName") ? "#arguments.objectName#-#arguments.property#" : arguments.name>

	<!--- TODO: build this as a list and loop thru each... --->
	<cfif StructKeyExists(arguments,"input_prepend")>
		<!--- add to args for the cf_controlGroup tag --->
		<cfset loc.tagAttr.input_prepend = arguments.input_prepend>
		<!--- remove from args that will be passed into wheels form helper --->
		<cfset structDelete(arguments,"input_prepend")>
	</cfif>
	<cfif StructKeyExists(arguments,"help_block")>
		<cfset loc.tagAttr.help_block = arguments.help_block>
		<cfset structDelete(arguments,"help_block")>
	</cfif>
	<cfif StructKeyExists(arguments,'controlGroupId')>
		<cfset loc.tagAttr.control_group_id = arguments.controlGroupId>
		<cfset structDelete(arguments,"controlGroupId")>
	</cfif>
	
	<cfset arguments.label = false>
	
	<cfswitch expression="#arguments.inputType#">
		<cfcase value="textField">
			<cfset loc.input = textField(argumentCollection=arguments)>
		</cfcase>
		<cfcase value="textFieldTag">
			<cfset loc.input = textFieldTag(argumentCollection=arguments)>
		</cfcase>
		<cfcase value="textArea">
			<cfset loc.input = textArea(argumentCollection=arguments)>
		</cfcase>
		<cfcase value="textAreaTag">
			<cfset loc.input = textAreaTag(argumentCollection=arguments)>
		</cfcase>
		<cfcase value="passwordField">
			<cfset loc.input = passwordField(argumentCollection=arguments)>
		</cfcase>
		<cfcase value="passwordFieldTag">
			<cfset loc.input = passwordFieldTag(argumentCollection=arguments)>
		</cfcase>
		<cfcase value="select">
			<cfset loc.input = select(argumentCollection=arguments)>
		</cfcase>
		<cfcase value="selectTag">
			<cfset loc.input = selectTag(argumentCollection=arguments)>
		</cfcase>
		<cfcase value="fileField">
			<cfset loc.input = fileField(argumentCollection=arguments)>
		</cfcase>
		<cfcase value="fileFieldTag">
			<cfset loc.input = fileFieldTag(argumentCollection=arguments)>
		</cfcase>
		<cfcase value="datePicker">
			<cfset loc.input = datePicker(argumentCollection=arguments)>
		</cfcase>
		<cfcase value="datePickerTag">
			<cfset loc.input = datePickerTag(argumentCollection=arguments)>
		</cfcase>
		<cfcase value="checkBox">
			<cfset loc.input = checkBox(argumentCollection=arguments)>
		</cfcase>
		<cfcase value="checkBoxTag">
			<cfset loc.input = checkBoxTag(argumentCollection=arguments)>
		</cfcase>
		<cfcase value="radioButtonTag">
			<cfset loc.input = radioButtonTag(argumentCollection=arguments)>
		</cfcase>
		<cfcase value="CKEditor">
			<!--- |<cfset arguments.class = listAppend(arguments.class, "ckeditor", " ")> --->
			<cfset arguments.class = "ckeditor">
			<cfset javascriptIncludeTag(source="ckeditor/ckeditor.js", head=true)>
			<cfset loc.input = textArea(argumentCollection=arguments)>
		</cfcase>
		<cfdefaultcase>
			<cfthrow message="Unknown inputType ('#arguments.inputType#') for input() view helper">
		</cfdefaultcase>
	</cfswitch>
	
	<cfoutput>
		<cfimport taglib="/valkyrie/customtags/" prefix="tag">
		<cfsavecontent variable="loc.return">
			<tag:controlGroup attributeCollection="#loc.tagAttr#">
				#loc.input#
			</tag:controlGroup>
		</cfsavecontent>
	</cfoutput>
	
	<cfreturn loc.return>
</cffunction>