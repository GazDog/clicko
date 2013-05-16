<cfcomponent output="false" mixin="controller">

	<cffunction name="init" returntype="any" access="public" output="false">
		<cfset this.version = "1.1.7">
		<cfreturn this />
	</cffunction>
	
	<cffunction name="LessSupportVersion" returntype="string" access="public" output="false">
		<cfreturn "1.0" />
	</cffunction>

	<!--- alter the styleSheetLinkTag to support less files --->
	<cffunction name="styleSheetLinkTag" returntype="string" access="public" output="false" hint="Returns a `link` tag for a stylesheet (or several) based on the supplied arguments."
		examples=
		'
			<!--- view code --->
			<head>
				<!--- Includes `stylesheets/styles.css` --->
			    ##styleSheetLinkTag("styles")##
				<!--- Includes `stylesheets/blog.css` and `stylesheets/comments.css` --->
				##styleSheetLinkTag("blog,comments")##
				<!--- Includes printer style sheet --->
				##styleSheetLinkTag(source="print", media="print")##
				<!--- Includes `stylesheets/styles.less` --->
			    ##styleSheetLinkTag("styles.less")##
			</head>
			
			<body>
				<!--- This will still appear in the `head` --->
				##styleSheetLinkTag(source="tabs", head=true)##
			</body>
		'
		categories="view-helper,assets" chapters="miscellaneous-helpers" functions="javaScriptIncludeTag,imageTag">
		<cfargument name="sources" type="string" required="false" default="" hint="The name of one or many CSS files in the `stylesheets` folder, minus the `.css` extension. (Can also be called with the `source` argument.)">
		<cfargument name="type" type="string" required="false" hint="The `type` attribute for the `link` tag.">
		<cfargument name="media" type="string" required="false" hint="The `media` attribute for the `link` tag.">
		<cfargument name="head" type="string" required="false" hint="Set to `true` to place the output in the `head` area of the HTML page instead of the default behavior, which is to place the output where the function is called from.">
		<cfargument name="delim" type="string" required="false" default="," hint="the delimiter to use for the list of stylesheets">
		<cfscript>
			var loc = {};
			$args(name="styleSheetLinkTag", args=arguments, combine="sources/source/!", reserved="href,rel");
			arguments.rel = "stylesheet";
			loc.returnValue = "";
			arguments.sources = $listClean(list=arguments.sources, returnAs="array", delim=arguments.delim);
			loc.iEnd = ArrayLen(arguments.sources);
			for (loc.i=1; loc.i <= loc.iEnd; loc.i++)
			{
				loc.item = arguments.sources[loc.i];
				if (ReFindNoCase("^https?:\/\/", loc.item))
				{
					arguments.href = arguments.sources[loc.i];
				}
				else
				{
					arguments.href = application.wheels.webPath & application.wheels.stylesheetPath & "/" & loc.item;
					if (ListLast(loc.item, ".") IS "less" )
					{
						arguments.rel = "stylesheet/less";
						StructDelete(arguments, "media");
					} 
					else if (!ListFindNoCase("css,cfm", ListLast(loc.item, "."))) 
					{
						arguments.href = arguments.href & ".css";
					}
					arguments.href = $assetDomain(arguments.href) & $appendQueryString();
				}
				loc.returnValue = loc.returnValue & $tag(name="link", skip="sources,head,delim", close=true, attributes=arguments) & chr(10);
			}
			if (arguments.head)
			{
				$htmlhead(text=loc.returnValue);
				loc.returnValue = "";
			}
		</cfscript>
		<cfreturn loc.returnValue>
	</cffunction>

</cfcomponent>