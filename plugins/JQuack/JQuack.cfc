<cfcomponent output="false" mixin="controller">

	<cffunction name="init" returntype="any" access="public" output="false">
		<cfset this.version = "1.1.4,1.1.5,1.1.6">
		<cfreturn this />
	</cffunction>
	
	<cffunction name="JQuackVersion" returntype="string" access="public" output="false">
		<cfreturn "0.1.2" />
	</cffunction>
	
	<!--- core --->
	<cffunction name="JQuackCore" access="public" returntype="string" output="false">
		<cfargument name="coreFileName" type="string" required="false" default="" />
		<cfargument name="rootURL" type="string" required="false" default="#$JQueryDirectoryURL()#" />
		<cfargument name="head" type="boolean" required="false" default="false" />
		<cfset var loc = {} />
		<cfset loc.config = $jQuackConfig() />
		<cfif Len(arguments.coreFileName) eq 0>
			<cfset arguments.coreFileName = loc.config.coreFileName />
		</cfif>
		<cfreturn $jQuackRenderMarkup(file="#arguments.rootURL##arguments.coreFileName#", head=arguments.head) />
	</cffunction>
	
	<!--- plugin --->
	<cffunction name="JQuackPlugin" access="public" returntype="string" output="false">
		<cfargument name="key" type="string" required="false" default="" />
		<cfargument name="file" type="any" required="false" default="" />
		<cfargument name="pluginRootURL" type="string" required="false" default="#$JQueryPluginDirectoryURL()#" />
		<cfargument name="delimiter" type="string" required="false" default="#$JQuackCRLF()#" />
		<cfargument name="head" type="boolean" required="false" default="false" />
		
		<cfset var loc = StructNew() />
		<cfset loc.config = $jQuackConfig() />
		<cfset loc.return = "" />
		<cfset loc.files = ArrayNew(1) />
		
		<!--- if neither key or file arguments have been supplied, return all plugins --->
		<cfif Len(arguments.key) eq 0 AND (IsSimpleValue(arguments.file) AND Len(arguments.file) eq 0)>
			<cfset arguments.key = StructKeyList(loc.config.plugins) />
		</cfif>
		
		<cfif Len(arguments.key) gt 0>
			<cfloop list="#arguments.key#" index="loc.i">
				<cfif StructKeyExists(loc.config.plugins,loc.i)>
					<!--- prepend plugin name as folder --->
					<cfloop array="#loc.config.plugins[loc.i]#" index="loc.p">
						<cfset ArrayAppend(loc.files, loc.i & "/" & loc.p) />
					</cfloop>
				</cfif>
			</cfloop>
		</cfif>
		<cfif IsArray(arguments.file)>
			<cfset loc.files = $JQuackArrayJoin(loc.files,arguments.file) />
		<cfelseif Len(arguments.file) gt 0>
			<cfset loc.files = $JQuackArrayJoin(loc.files,listToArray(arguments.file)) />
		</cfif>
		<cfloop from="1" to="#ArrayLen(loc.files)#" index="loc.i">
			<cfset loc.file = $jQuackRenderMarkup(file="#arguments.pluginRootURL##loc.files[loc.i]#", head=arguments.head) />
			<cfif Len(loc.file) gt 0>
				<!--- ListAppend doesn't play nicely with empty delimiter --->
				<cfif Len(arguments.delimiter) eq 0>
					<cfset loc.return = loc.return & loc.file />
				<cfelse>
					<cfset loc.return = ListAppend(loc.return, loc.file, arguments.delimiter) />
				</cfif>
			</cfif>
		</cfloop>
		
		<cfreturn loc.return />
	</cffunction>
	
	<!--- ui --->
	<cffunction name="JQuackUI" access="public" returntype="string" output="false">
		<cfargument name="UIBundleName" type="string" required="false" default="" />
		<cfargument name="themeName" type="string" required="false" default="" />
		<cfargument name="rootURL" type="string" required="false" default="#$JQueryDirectoryURL()#" />
		<cfargument name="delimiter" type="string" required="false" default="#$JQuackCRLF()#" />
		<cfargument name="head" type="boolean" required="false" default="false" />
		<cfset var loc = {} />
		<cfset loc.config = $jQuackConfig() />
		<cfif Len(arguments.UIBundleName) eq 0>
			<cfset arguments.UIBundleName = loc.config.UIBundleName />
		</cfif>
		<cfif Len(arguments.themeName) eq 0>
			<cfset arguments.themeName = loc.config.themeName />
		</cfif>
		<cfset loc.return = "" />
		<cfset loc.return = ListAppend(loc.return, $jQuackRenderMarkup(file="#arguments.rootURL##arguments.UIBundleName#/js/#arguments.UIBundleName#.min.js", head=arguments.head), arguments.delimiter) />
		<cfset loc.return = ListAppend(loc.return, JQuackTheme(themeName=arguments.themeName, uiBundleName=arguments.uiBundleName, rootURL=arguments.rootURL, head=arguments.head), arguments.delimiter) />
		<cfreturn loc.return />
	</cffunction>
	
	<!--- theme --->
	<cffunction name="JQuackTheme" access="public" returntype="string" output="false">
		<cfargument name="themeName" type="string" required="true" />
		<cfargument name="UIBundleName" type="string" required="false" default="" />
		<cfargument name="rootURL" type="string" required="false" default="#$JQueryDirectoryURL()#" />
		<cfargument name="head" type="boolean" required="false" default="false" />
		<cfset var loc = {} />
		<cfset loc.config = $jQuackConfig() />
		<cfif Len(arguments.UIBundleName) eq 0>
			<cfset arguments.UIBundleName = loc.config.UIBundleName />
		</cfif>
		<cfif Len(arguments.themeName) eq 0>
			<cfset arguments.themeName = loc.config.themeName />
		</cfif>
		<cfreturn $jQuackRenderMarkup(file="#arguments.rootURL##arguments.UIBundleName#/css/#arguments.themeName#/#arguments.UIBundleName#.css", head=arguments.head) />
	</cffunction>
	
	<!--- all --->
	<cffunction name="JQuackAll" access="public" returntype="string" output="false">
		<cfargument name="delimiter" type="string" required="false" default="#Chr(13) & Chr(10)#" />
		<cfargument name="head" type="boolean" required="false" default="false" />
		<cfset var loc = {} />
		<cfset loc.return = "" />
		<cfset loc.core = JQuackCore(head=arguments.head) />
		<cfset loc.UI = JQuackUI(delimiter=arguments.delimiter, head=arguments.head) />
		<cfset loc.plugins = JQuackPlugin(delimiter=arguments.delimiter, head=arguments.head) />
		<cfif Len(loc.core) gt 0>
			<cfset loc.return = ListAppend(loc.return, loc.core, arguments.delimiter)  />
		</cfif>
		<cfif Len(loc.UI) gt 0>
			<cfset loc.return = ListAppend(loc.return, loc.UI, arguments.delimiter)  />
		</cfif>
		<cfif Len(loc.plugins) gt 0>
			<cfset loc.return = ListAppend(loc.return, loc.plugins, arguments.delimiter)  />
		</cfif>
		<cfreturn loc.return />
	</cffunction>
	
	<!--- "private" methods --->

	<cffunction name="$JQueryDirectoryPath" returntype="string" access="public">
		<cfreturn ExpandPath($JQueryDirectoryURL()) />
	</cffunction>
	
	<cffunction name="$JQueryPluginDirectoryPath" returntype="string" access="public">
		<cfreturn ExpandPath($JQueryPluginDirectoryURL()) />
	</cffunction>
	
	<cffunction name="$jQuackConfigFilePath" returntype="string" access="public">
		<cfreturn ExpandPath(application.wheels.pluginPath) & "\jquack\JQuack.config.cfm" />
	</cffunction>
	
	<cffunction name="$JQueryDirectoryURL" returntype="string" access="public">
		<cfreturn "#application.wheels.webPath##application.wheels.javascriptPath#/jquery/" />
	</cffunction>
	
	<cffunction name="$JQueryPluginDirectoryURL" returntype="string" access="public">
		<cfreturn "#application.wheels.webPath##application.wheels.javascriptPath#/jquery/plugins/" />
	</cffunction>
	
	<cffunction name="$jQuackRenderMarkup" returntype="string" access="public">
		<cfargument name="file" type="string" required="true" />
		<cfargument name="head" type="boolean" required="false" default="false" />
		<cfset var loc = StructNew() />
		<cfset loc.key = ReReplaceNoCase(arguments.file,"[^a-z0-9]","","all") />
		<cfset loc.return = "">
		<cfif not StructKeyExists(request,"_jQuack")>
			<cfset request._jQuack = StructNew() />
		</cfif>
		<cfif StructKeyExists(request._jQuack,loc.key)>
			<cfset loc.return = "">
		<cfelseif CompareNoCase(ListLast(arguments.file,"."),"js") eq 0>
			<cfset loc.return = '<script type="text/javascript" src="#arguments.file#"></script>' />
		<cfelseif CompareNoCase(ListLast(arguments.file,"."),"css") eq 0>
			<cfset loc.return = '<link rel="stylesheet" href="#arguments.file#" type="text/css" media="screen" />' />
		</cfif>
		<cfset request._jQuack[loc.key] = true />
		<cfif arguments.head>
			<cfset $JQuackHTMLHead(text=loc.return) />
			<cfset loc.return = "" />
		</cfif>
		<cfreturn loc.return />
	</cffunction>
	
	<cffunction name="$jQuackArrayJoin" access="public" returntype="array">
		<cfargument name="array1" required="true" type="array" />
		<cfargument name="array2" required="true" type="array" />
		<cfset var loc = StructNew() />
		<cfset loc.return = arguments.array1 />
		<cfloop array="#arguments.array2#" index="loc.i">
			<cfif arrayFindNoCase(loc.return,loc.i) eq 0>
				<cfset arrayAppend(loc.return,loc.i) />
			</cfif>
		</cfloop>
		<cfreturn loc.return />
	</cffunction>
	
	<cffunction name="$jQuackConfig" returntype="struct" access="public">
		<cfargument name="reload" type="boolean" required="false" default="false" />
		<cfif !StructKeyExists(application.wheels,"JQuackConfig") OR arguments.reload>
			<cfset set(JQuackConfig=$jQuackParseConfigFile()) />
			<!---<cfset application.wheels.JQuackConfig = $jQuackParseConfigFile() />--->
		</cfif>
		<cfreturn get("JQuackConfig") />
		<!---<cfreturn application.wheels.JQuackConfig />--->
	</cffunction>
	
	<cffunction name="$jQuackParseConfigFile" returntype="struct" access="public">
		<cfset var loc = StructNew()>
		<cfset loc.return = StructNew() />
		<cfif !FileExists($jQuackConfigFilePath())>
			<cfset $jQuackInitConfigFile() />
		</cfif>
		<cffile action="read" file="#$jQuackConfigFilePath()#" variable="loc.json">
		<cfif IsJSON(loc.json)>
			<cfset loc.return = DeserializeJSON(loc.json) />
		</cfif>
		<cfreturn loc.return />
	</cffunction>
	
	<cffunction name="$jQuackInitConfigFile" returntype="string" access="public">
		<cfset var loc = StructNew() />
		<cfset loc.outputStruct = StructNew() />
		<cfset loc.outputStruct.coreFileName = "" />
		<cfset loc.outputStruct.UIBundleName = "" />
		<cfset loc.outputStruct.themeName = "" />
		<cfset loc.outputStruct.plugins = StructNew() />
		
		<!--- see if i can find some files.. --->
		<cfset loc.jQueryDirectoryPath = $JQueryDirectoryPath()>
		<cfdirectory action="list" directory="#loc.jQueryDirectoryPath#" name="loc.JQueryDir" sort="name DESC">
		<cfloop query="loc.JQueryDir">
			<cfif Len(loc.outputStruct.coreFileName) EQ 0 AND loc.JQueryDir.type IS "File" AND Left(loc.JQueryDir.name,7) IS "jquery-" AND ListLast(loc.JQueryDir.name,".") IS "js">
				<!--- jquery-1.6.2.min.js --->
				<cfset loc.outputStruct.coreFileName = loc.JQueryDir.name />
			<cfelseif Len(loc.outputStruct.UIBundleName) EQ 0 AND loc.JQueryDir.type IS "Dir" AND Left(loc.JQueryDir.name,10) IS "jquery-ui-">
				<!--- jquery-ui-1.8.16.custom --->
				<cfset loc.outputStruct.UIBundleName = loc.JQueryDir.name />
				<cfset loc.UIBundleDirectoryPath = loc.jQueryDirectoryPath & "\" & loc.JQueryDir.name & "\" & "css\" />
				
				<cfif Len(loc.outputStruct.themeName) EQ 0>
					<!--- try to find themes.. --->
					<cfif DirectoryExists(loc.UIBundleDirectoryPath)>
						<cfdirectory action="list" directory="#loc.UIBundleDirectoryPath#" name="loc.themesDir">
						<cfset loc.outputStruct.themeName = loc.themesDir.Name>
					</cfif>
				</cfif>
			</cfif>
		</cfloop>
		<!--- if no plugins structure is found, parse the plugins folder.. --->
		<cfset loc.jQueryPluginDirectoryPath = $jQueryPluginDirectoryPath()>
		<cfdirectory action="list" directory="#loc.jQueryPluginDirectoryPath#" name="loc.pluginDir">
		<cfloop query="loc.pluginDir">
			<!--- look for child folders of #jQueryPluginDirectoryPath# --->
			<cfif loc.pluginDir.type IS "Dir">
				<cfset loc.currentPluginFolder = loc.pluginDir.directory & "\" & loc.pluginDir.name & "\" />
				<cfset loc.currentPluginKey = loc.pluginDir.name />
				<cfset loc.outputStruct.plugins[loc.currentPluginKey] = ArrayNew(1) />
				<cfdirectory action="list" directory="#loc.currentPluginFolder#" name="loc.pluginFiles">
				<cfloop query="loc.pluginFiles">
					<cfif loc.pluginFiles.type IS "File" AND ListFindNoCase("js,css",ListLast(loc.pluginFiles.name,".")) GT 0>
						<!--- change absolute path to URL --->
						<!--- <cfdump var="#loc.pluginFiles.directory#"/>
						<cfdump var="#$JQueryPluginDirectoryPath()#" abort="true" />
						 --->
						<cfset loc.jqueryDirURL = ReplaceNoCase(loc.pluginFiles.directory,$JQueryPluginDirectoryPath(),"") />
						<!--- switch slash direction --->
						<cfset loc.jqueryDirURL = Replace(loc.jqueryDirURL,"\","/","all") />
						<cfset ArrayAppend(loc.outputStruct.plugins[loc.currentPluginKey], loc.pluginFiles.name) />
					</cfif>
				</cfloop>
			</cfif>
		</cfloop>
		<cfset loc.outputString = SerializeJSON(loc.outputStruct)>
		<cfset $jQuackWriteFile(file=$jQuackConfigFilePath(), output=loc.outputString)>
		<cfreturn loc.outputString />
	</cffunction>
	
	<cffunction name="$jQuackSaveConfigFile" returntype="string" access="public">
		<cfargument name="params" required="true" type="struct" />
		
		<cfset var loc = StructNew() />
		<!--- create config struct --->
		<cfset loc.params = arguments.params />
		<cfset loc.config = StructNew() />
		
		<!--- build an array of plugin keys --->
		<cfset loc.pluginKeyArray = ArrayNew(1) />
		<cfloop from="1" to="#loc.params.pluginKeyCount#" index="loc.i">
			<cfset loc.pluginKeyArray[loc.i] = loc.params["pluginKey_#loc.i#"] />
		</cfloop>
		
		<!--- grab static named core & ui variables. --->
		<cfset loc.config = StructNew() />
		<cfset loc.config.coreFileName = loc.params.coreFileName />
		<cfset loc.config.UIBundleName = loc.params.UIBundleName />
		<cfset loc.config.themeName = loc.params.themeName />
		
		<cfset loc.config.plugins = StructNew() />
		
		<!--- process new package --->
		<cfif Len(loc.params.pluginKey_new) GT 0>
			<cfset loc.config.plugins[$JQuackStructKeySafe(loc.params.pluginKey_new)] = ArrayNew(1) />
		</cfif>
		
		<!--- loop over params & extract plugin keys --->
		<cfloop array="#loc.pluginKeyArray#" index="loc.i">
			<cfif Len(loc.i) GT 0>
				<cfset loc.config.plugins[$JQuackStructKeySafe(loc.i)] = ArrayNew(1) />
			</cfif>
		</cfloop>
		
		<!--- loop over params & extract plugins --->
		<cfloop collection="#loc.params#" item="loc.i">
			<cfif Left(loc.i,15) IS "pluginFile_new_" AND Len(loc.params[loc.i]) GT 0>
				<cfset loc.thisKey = $JQuackStructKeySafe(loc.params.pluginKey_new) />
				<cfset ArrayAppend(loc.config.plugins[loc.thisKey], loc.params[loc.i]) />
			<cfelseif Left(loc.i,11) IS "pluginFile_" AND Len(loc.params[loc.i]) GT 0>
				<cfset loc.thisKeyIndex = ListGetAt(loc.i,2,"_") />
				<cfset loc.thisKey = loc.pluginKeyArray[loc.thisKeyIndex]>
				<cfset ArrayAppend(loc.config.plugins[loc.thisKey], loc.params[loc.i]) />
			</cfif>
		</cfloop>
		<cfset loc.return = $JQuackWriteConfigFile(loc.config) />
		<cfreturn loc.return />
	</cffunction>
	
	<cffunction name="$JQuackDeletePluginPackage" returntype="string" access="public">
		<cfargument name="key" type="string" required="true" />
		<cfset var loc = StructNew() />
		<cfset loc.config = $jQuackParseConfigFile() />
		<cfset StructDelete(loc.config.plugins,arguments.key) />
		<cfset loc.return = $JQuackWriteConfigFile(loc.config) />
		<cfreturn loc.return />
	</cffunction>
	
	<cffunction name="$JQuackWriteConfigFile" returntype="string" access="public">
		<cfargument name="config" type="any" required="true" />
		<cfset var loc = StructNew() />
		<cfset loc.config = arguments.config />
		<cfif IsStruct(arguments.config)>
			<cfset loc.config = SerializeJSON(arguments.config) />
		</cfif>
		<cfif FileExists($jQuackConfigFilePath())>
			<cffile action="delete" file="#$jQuackConfigFilePath()#" />
		</cfif>
		<cfset $jQuackWriteFile($jQuackConfigFilePath(), loc.config)>
		<cfreturn loc.config />
	</cffunction>
	
	<cffunction name="$jQuackScaffoldDirectoryPaths" returntype="struct" access="public">
		<cfset var loc = {} />
		
		<!--- define directories --->
		<cfset loc.pluginsDirectoryPath = $JQueryDirectoryPath() & "plugins/exampleplugin/">
		<cfset loc.pluginsDirectoryPath2 = $JQueryDirectoryPath() & "plugins/second-example-plugin/">
		<cfset loc.UIDirectoryPath = $JQueryDirectoryPath() & "jquery-ui-0.0.01.custom.example/">
		<cfset loc.UIThemeDirectoryPath = loc.UIDirectoryPath & "css/exampletheme/">
		<cfset loc.UIImagesDirectoryPath = loc.UIThemeDirectoryPath & "images/">
		<cfset loc.UIJSDirectoryPath = loc.UIDirectoryPath & "js/">
		
		<cfreturn loc />
	</cffunction>
	
	<cffunction name="$jQuackScaffoldFilePaths" returntype="array" access="public">
		<cfset var loc = {} />
		
		<cfset loc.directories = $jQuackScaffoldDirectoryPaths() />
		
		<!--- define files --->
		<cfset loc.fileArray = ArrayNew(1) />
		<cfset ArrayAppend(loc.fileArray,$JQueryDirectoryPath() & "jquery-0.0.1.min.example.js")>
		<cfset ArrayAppend(loc.fileArray,loc.directories.pluginsDirectoryPath & "jquery.exampleplugin.example.js")>
		<cfset ArrayAppend(loc.fileArray,loc.directories.pluginsDirectoryPath & "jquery.exampleplugin.example.css")>
		
		<cfset ArrayAppend(loc.fileArray,loc.directories.pluginsDirectoryPath2 & "jquery.second-example-plugin.example.js")>
		<cfset ArrayAppend(loc.fileArray,loc.directories.pluginsDirectoryPath2 & "jquery.second-example-plugin.example.css")>
		<cfset ArrayAppend(loc.fileArray,loc.directories.pluginsDirectoryPath2 & "jquery.second-example-plugin.example.txt")>		
		
		<cfset ArrayAppend(loc.fileArray,loc.directories.UIThemeDirectoryPath & "jquery-ui-0.0.01.custom.example.css")>
		<cfset ArrayAppend(loc.fileArray,loc.directories.UIJSDirectoryPath & "jquery-ui-0.0.01.custom.example.js")>
		
		<cfreturn loc.fileArray />
	</cffunction>
	
	<cffunction name="$jQuackScaffold" returntype="array" access="public">
		<cfset var loc = StructNew() />
		
		<!--- define files --->
		<cfset loc.fileArray = $jQuackScaffoldFilePaths() />
		
		<!--- create scaffold directories & files --->
		<cfloop array="#loc.fileArray#" index="loc.i">
			<cfset $jQuackWriteFile(file=loc.i, output="#loc.i# is a sample file created by the jQuack plugin.. 'QUACK!'")>
		</cfloop>
		<cfreturn loc.fileArray>
	</cffunction>
	
	<cffunction name="$jQuackCleanupScaffoldFiles" returntype="boolean" access="public">
		<cfset var loc = StructNew() />
		
		<!--- define files --->
		<cfset loc.files = $jQuackScaffoldFilePaths() />
		<cfset loc.directories = $jQuackScaffoldDirectoryPaths() />
		
		<!--- delete scaffold files & directories --->
		<cfloop array="#loc.files#" index="loc.i">
			<cfif FileExists(loc.i)>
				<cffile action="delete" file="#loc.i#" />
			</cfif>
		</cfloop>
		
		<cfloop collection="#loc.directories#" item="loc.i">
			<cfif DirectoryExists(loc.directories[loc.i])>
				<cfdirectory action="delete" directory="#loc.directories[loc.i]#" recurse="true" />
			</cfif>
		</cfloop>
		
		<cfreturn true>
	</cffunction>
	
	<cffunction name="$jQuackScaffoldExists" returntype="boolean" access="public">
		<cfset var loc = StructNew() />
		<cfset loc.return = false />
		
		<!--- define files --->
		<cfset loc.files = $jQuackScaffoldFilePaths() />
		<cfset loc.directories = $jQuackScaffoldDirectoryPaths() />
		
		<!--- check for any scaffold files or directories --->
		<cfloop array="#loc.files#" index="loc.i">
			<cfif FileExists(loc.i)>
				<cfset loc.return = true />
				<cfbreak />
			</cfif>
		</cfloop>
		
		<cfif !loc.return>
			<cfloop collection="#loc.directories#" item="loc.i">
				<cfif DirectoryExists(loc.directories[loc.i])>
					<cfset loc.return = true />
					<cfbreak />
				</cfif>
			</cfloop>
		</cfif>
		
		<cfreturn loc.return />
	</cffunction>
	
	<cffunction name="$jQuackWriteFile" returntype="string" access="public">
		<cfargument name="file" required="true" type="string" />
		<cfargument name="output" required="true" type="string" />
		<cfset var loc = StructNew() />
		<cfset loc.directory = GetDirectoryFromPath(arguments.file)>
		<cfif !DirectoryExists(loc.directory)>
			<cfdirectory action="create" directory="#loc.directory#" />
		</cfif>
		<cfif !FileExists(arguments.file)>
			<cffile action="write" file="#arguments.file#" output="#arguments.output#">
		</cfif>
		<cfreturn arguments.file />
	</cffunction>
	
	<cffunction name="$JQuackStructKeySafe" returntype="string" access="public">
		<cfargument name="key" required="true" type="string" />
		<cfreturn ReReplaceNoCase(arguments.key,"[^0-9a-z-_]","","all") />
	</cffunction>
	
	<cffunction name="$JQuackHTMLHead" returntype="void" access="public">
		<cfargument name="text" required="true" type="string">
		<cfhtmlhead text="#arguments.text#" />
	</cffunction>
	
	<cffunction name="$JQuackCRLF" returntype="string" access="public">
		<cfreturn Chr(13) & Chr(10) />
	</cffunction>
	
</cfcomponent>