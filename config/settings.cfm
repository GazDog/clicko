<cfscript>

	set(URLRewriting="On");
	set(dataSourceName="clicko");
	set(appName="Clicko");

</cfscript>

<!--- function defaults --->
<cfset set(functionName="sendEmail", from="no-reply@#get('dataSourceName')#.com") />
<cfset set(functionName="startFormTag", id="w-form", class="form-horizontal") />
<cfset set(functionName="errorMessagesFor", class="alert alert-error") />
<cfset set(functionName="datePicker", style="width:80px;", dateFormat="dd/mm/yy")>
<cfset set(functionName="datePickerTag", style="width:80px;", dateFormat="dd/mm/yy")>
<cfset set(functionName="paginationLinks", name="pg", prepend='<div class="pagination" align="center"><ul>', append='</ul></div>', prependToPage='<li>', appendToPage='</li>', classForCurrent="active", anchorDivider='<li><a>...</a></li>', linkToCurrentPage=true, windowSize=5)>