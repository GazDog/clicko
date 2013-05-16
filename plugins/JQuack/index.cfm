<cfsilent>
	
	<!--- init config file --->
	<cfset config = $jQuackParseConfigFile() />
	
	<!--- perform available actions --->
	<cfif StructKeyExists(form,"scaffold")>
		<cfset $jQuackScaffold() />
		<cfset flashInsert(success="Example folders &amp; files created!")>
		<cfset redirectTo(back=true)>
	<cfelseif StructKeyExists(form,"cleanup")>
		<cfset $jQuackCleanupScaffoldFiles() />
		<cfset flashInsert(success="Example folders &amp; files deleted!")>
		<cfset redirectTo(back=true)>
	<cfelseif StructKeyExists(form,"config")>
		<cfset $jQuackSaveConfigFile(form) />
		<cfset flashInsert(success="JQuack configuration file was saved!")>
		<cfset redirectTo(back=true)>
	<cfelseif StructKeyExists(form,"reset")>
		<cfif FileExists($jQuackConfigFilePath())>
			<cffile action="delete" file="#$jQuackConfigFilePath()#" />
		</cfif>
		<cfset $jQuackInitConfigFile() />
		<cfset flashInsert(success="JQuack configuration file was reset!")>
		<cfset redirectTo(back=true)>
	<cfelseif StructKeyExists(params,"deleteKey")>	
		<cfset $JQuackDeletePluginPackage(key=params.pluginKey) />
		<cfset flashInsert(success="JQuack package '#params.pluginKey#' was deleted!")>
		<cfset redirectTo(back=true)>
	<cfelseif StructKeyExists(form,"verify")>
		<!--- <cfset $JQuackVerifyFilesHTTP() /> --->
		<!--- process output --->
		<cfset flashInsert(success="Under development")>
		<cfset redirectTo(back=true)>
	</cfif>

</cfsilent>
<cfinclude template="css.cfm" />
<cfoutput>
<h1>JQuack v#JQuackVersion()#</h1>
<p>Manage and call your jQuery core files, plugin packages, UI and themes with a set of JQuack functions.</p>

<p>This plugin adds a set of functions to call your jQuery core files, plugin packages, UI and themes. You can can also call files from an external library (Eg: Google CDN).

It also adds a simple UI for configuring all your core and plugins.</p>

<h2>Requirements:</h2>
<p>As with CFWheels, there are conventions that need to be followed.</p>
<ul>
	<li>All jQuery files must reside in the <tt>/javascripts/jquery/</tt> folder</li>
	<li>Plugin folders must use the following convention <tt>/javascripts/jquery/plugins/[key]/[file]</tt></li>
	<li>In this release of JQuack, you must use the minified version of your UI bundle. E.g. <tt>/javascripts/jquery/jquery-ui-1.1.1.custom/js/jquery-ui-1.1.1.custom.<strong style="color:red;">min</strong>.js</tt></li>
</ul>

<cfif flashKeyExists("success")>
	<pre>#flash("success")#</pre>
</cfif>

<table style="width:100%;">
	<tr>
		<td style="vertical-align:top;">
			<h2>Core File &amp; UI</h2>
			<cfform action="#CGI.script_name & '?' & CGI.query_string#">
				<input type="hidden" name="config" value="true" />	
				<p><label for="coreFileName">jQuery Core File Name</label> <br>
					<cfinput name="coreFileName" value="#config.coreFileName#" size="30">
				</p>
				<p><label for="UIBundleName">jQuery UI Bundle Name</label> <br>
					<cfinput name="UIBundleName" value="#config.UIBundleName#" size="30">
				</p>
				<p><label for="themeName">jQuery UI Theme Name</label> <br>
					<cfinput name="themeName" value="#config.themeName#" size="30">
				</p>
				<h2>Plugin Packages</h2>
				<cfset counter = 0 />
				<cfif StructKeyExists(config,"plugins")>
					<cfloop collection="#config.plugins#" item="key">
						<cfset counter++ />
						<h3>#key#</h3>
						<label>Package Key</label><br />
						<cfinput name="pluginKey_#counter#" value="#key#" size="20"> <input type="button" value="Delete" onclick="self.location='#CGI.script_name & '?' & CGI.query_string#&deleteKey=true&pluginKey=#key#'"> <br />
						<label>Package File/s</label><br />
						<cfloop from="1" to="#ArrayLen(config.plugins[key])#" index="i">
							<cfinput name="pluginFile_#counter#_#i#" value="#config.plugins[key][i]#" size="60"><br />
						</cfloop>
						<cfinput name="pluginFile_#counter#_#ArrayLen(config.plugins[key])+1#" value="" size="60" title="Add a new file"><br />
						<br />
					</cfloop>
				</cfif>
				<input type="hidden" name="pluginKeyCount" value="#counter#" />
				<h2>Add Plugin Package</h2>
				<label>Package Key. (E.g. "foo")</label><br />
				<cfinput name="pluginKey_new" value="" size="20"><br />
				<label>File/s (E.g. jquery.foo.js)</label><br />
				<cfloop from="1" to="3" index="i">
					<cfinput name="pluginFile_new_#i#" value="" size="60" title="Add a new file"><br />
				</cfloop>
				
				<p><cfinput type="submit" name="btnSubmit" value="Save"></p>
			</cfform>
		</td>
		<td style="vertical-align:top;padding-left:20px;">
			<h2>Instructions</h2>
			
			<h3>1. Place your jQuery files in the /javascripts/jquery/ folder.</h3>
			<cfif jQuack.$jQuackScaffoldExists()>
				<form action="#CGI.script_name & '?' & CGI.query_string#" method="post">
					<input type="hidden" name="cleanup" value="true" />
					<p>Clean up any scaffold example files &amp; folders. Any files you have put there yourself will be untouched..<br />
					<input type="submit" value="Clean up!" style="width:80px;" />
					</p>
				</form>
			<cfelse>
				<form action="#CGI.script_name & '?' & CGI.query_string#" method="post">
					<input type="hidden" name="scaffold" value="true" />
					<p>Click the 'Scaffold!' button to create the recommended folders with example files to get you started.. not the actual js files though.. you'll need to source those yourself!. (You will be able to clean these example files up later)<br />
					<input type="submit" value="Scaffold!" style="width:80px;" />
					</p>
				</form>
			</cfif>
			
			<h3>2. Configure your core files in the form to your left.</h3>
			<form action="#CGI.script_name & '?' & CGI.query_string#" method="post">
				<input type="hidden" name="reset" value="true" />
				<p>
					<cfif FileExists(jQuack.$jQuackConfigFilePath())>
						Reload config file.. This will scan the javascripts/jquery/ folder in an attempt to find your core files, plugin packages &amp; theme. 
						<span style="color:red;">WARNING:</span> It will delete any manual plugin package entries you may have made. (Your files will be untouched)
						<br />
						<input type="submit" value="Reload!" style="width:80px;" />
					<cfelse>
						Initialise config file.. This will scan the javascripts/jquery/ folder in an attempt to find your core files, plugin packages &amp; theme.
						<br />
						<input type="submit" value="Initialise!" style="width:80px;" />
					</cfif>
				</p>
			</form>
			
			<!--- <h3>3. Verify that your files are where you say they are.</h3>
			<form action="#CGI.script_name & '?' & CGI.query_string#" method="post">
				<input type="hidden" name="verify" value="true" />
				<p>
					<input type="button" value="Verify!" style="width:80px;" onclick="alert('Hold your horses.. still under development!')" />
				</p>
			</form> --->
			
			<h3>3. Read the <a href="##documentation">documentation</a>.</h3>
			
			<h3>4. Have a snooze.</h3>
			
		</td>
	</tr>
</table>
</cfoutput>

<h2 id="documentation">Documentation</h2>

<h3 id="documentation">Function Syntax</h3>
<p><code> JQuackCore([<em>coreFileName</em>, <em>rootURL</em>, <em>head</em>])</code></p> 
<p><code> JQuackPlugin([<em>key</em>, <em>file</em>, <em>pluginRootURL</em>, <em>delimiter</em>, <em>head</em>])</code></p>
<p><code> JQuackUI([<em>UIBundleName</em>, <em>themeName</em>, <em>rootURL</em>, <em>delimiter</em>, <em>head</em>])</code></p>
<p><code> JQuackTheme(themeName, [<em>UIBundleName</em>, <em>rootURL</em>, <em>head</em>])</code></p>
<p><code> JQuackAll([<em>delimiter</em>, <em>head</em>])</code></p>

<h3>Recommended Usage Example</h3>
<pre>
&lt;!--- 1. include all files as defined in your JQuack configuration ---&gt;
#JQuackAll()#

&lt;!--- 2. include minimal files ---&gt;
#JQuackCore()#
#JQuackPlugin("foo,bar")#
#JQuackUI()#

&lt;!--- 3. include a combination of files ---&gt;
#JQuackCore()#
#JQuackPlugin("foo,bar")#
#JQuackPlugin(file="jquery.foo.js", pluginRootURL="http://www.foobar.com/plugins/")#
#JQuackUI(themeName="barfoo")#
</pre>

<h2>JQuackCore()</h2>
<table class="doc">
<thead> 
	<tr> 
		<th>Argument</th> 
		<th>Type</th> 
		<th>Required</th> 
		<th>Default</th> 
		<th>Description</th> 
	</tr> 
</thead> 
<tbody> 
	<tr>
		<td valign="top"><code>coreFileName</code></td> 
		<td valign="top"><code>string</code></td> 
		<td valign="top">Optional</td> 
		<td valign="top"><code>[value defined in "Core File Name" field]</code></td> 
		<td valign="top">The name of the jQuery core file including js extension</td> 
	</tr>
	<tr>
		<td valign="top"><code>rootURL</code></td> 
		<td valign="top"><code>string</code></td> 
		<td valign="top">Optional</td> 
		<td valign="top"><code>[site]/javascripts/jquery/</code></td> 
		<td valign="top">URL of the containing directory. Use this argument to call remote files.</td> 
	</tr>
	<tr>
		<td valign="top"><code>head</code></td> 
		<td valign="top"><code>boolean</code></td> 
		<td valign="top">Optional</td> 
		<td valign="top"><code>false</code></td> 
		<td valign="top">Set <code>head=true</code> to place the output in the head area of the HTML page instead of the default behavior, which is to place the output where the function is called from.</td> 
	</tr>
<tbody> 
</table>

<h3>Usage Example</h3>
<pre>
&lt;!--- JQuackCore() Examples ---&gt;
&lt;!--- call the core file as defined in config ---&gt;
#JQuackCore()#

&lt;!--- write the output to the head area of the HTML page ---&gt;
#JQuackCore(head=true)#

&lt;!--- call a different version of the core file from your javascripts/jquery/ folder ---&gt;
#JQuackCore(coreFileName="jquery-1.5.0.min.js")#

&lt;!--- call from Google Libraries API ---&gt;
#JQuackCore(coreFileName="jquery.min.js", rootURL="http://ajax.googleapis.com/ajax/libs/jquery/1.6.4/")#
</pre>

<h2>JQuackPlugin()</h2> 
<table class="doc">
<thead> 
	<tr> 
		<th>Argument</th> 
		<th>Type</th> 
		<th>Required</th> 
		<th>Default</th> 
		<th>Description</th> 
	</tr> 
</thead> 
<tbody> 
	<tr>
		<td valign="top"><code>key</code></td> 
		<td valign="top"><code>string</code></td> 
		<td valign="top">Optional</td> 
		<td valign="top"><code>[all packages defined in the config file]</code></td> 
		<td valign="top">A list or array of package names. Omit this argument to include all plugin files.</td>
	</tr>
	<tr>
		<td valign="top"><code>file</code></td>
		<td valign="top"><code>string</code></td> 
		<td valign="top">Optional</td> 
		<td valign="top"><code></code></td> 
		<td valign="top">Name or location of a file. Use this argument to call files not defined in your packages.</td> 
	</tr>
	<tr>
		<td valign="top"><code>pluginRootURL</code></td> 
		<td valign="top"><code>string</code></td> 
		<td valign="top">Optional</td> 
		<td valign="top"><code>[site]/javascripts/jquery/plugins/</code></td> 
		<td valign="top">URL of the containing directory. Use this argument to include remote files.</td> 
	</tr>
	<tr>
		<td valign="top"><code>delimiter</code></td> 
		<td valign="top"><code>string</code></td> 
		<td valign="top">Optional</td> 
		<td valign="top"><code>Chr(13) & Chr(10)</code></td> 
		<td valign="top">The string to place between the tag markup. Use <code>delimiter=""</code> to remove any line breaks</td> 
	</tr>
	<tr>
		<td valign="top"><code>head</code></td> 
		<td valign="top"><code>boolean</code></td> 
		<td valign="top">Optional</td> 
		<td valign="top"><code>false</code></td> 
		<td valign="top">Set to true to place the output in the head area of the HTML page instead of the default behavior, which is to place the output where the function is called from.</td> 
	</tr>
<tbody> 
</table>

<h3>Usage Example</h3>
<pre>
&lt;!--- JQuackPlugin() Examples ---&gt;
&lt;!--- call a single plugin package ---&gt;
#JQuackPlugin("foo")#

&lt;!--- call multiple plugin packages ---&gt;
#JQuackPlugin("foo,bar,quack")#

&lt;!--- don't worry, none of the 'foo' files will be included more than once ---&gt;
#JQuackPlugin("foo,bar")#
#JQuackPlugin("foo")#

&lt;!--- write the output to the head area of the HTML page ---&gt;
#JQuackPlugin(key="foo,bar", head=true)#

&lt;!--- call all plugins ---&gt;
#JQuackPlugin()#

&lt;!--- remove line breaks between included files ---&gt;
#JQuackPlugin(delimiter="")#

&lt;!--- call a plugin package from another location ---&gt;
#JQuackPlugin(key="foo", pluginRootURL="http://someserver.com/js/plugins/")#
#JQuackPlugin(key="bar", pluginRootURL="/javascripts/someotherfolder/")#

&lt;!--- call a file not defined in your packages but located in the /javascripts/jquery/plugins/ folder ---&gt;
#JQuackPlugin(file="jquery.foobar.js")#

&lt;!--- call a file from another location ---&gt;
#JQuackPlugin(file="jquery.foobar.js", pluginRootURL="http://someserver.com/js/plugins/")#
</pre>

<h2>JQuackUI()</h2> 
<table class="doc">
<thead> 
	<tr> 
		<th>Argument</th> 
		<th>Type</th> 
		<th>Required</th> 
		<th>Default</th> 
		<th>Description</th> 
	</tr> 
</thead> 
<tbody> 
	<tr>
		<td valign="top"><code>UIBundleName</code></td> 
		<td valign="top"><code>string</code></td> 
		<td valign="top">Optional</td> 
		<td valign="top"><code>[value defined in "UI Bundle Name" field]</code></td> 
		<td valign="top">The name of the jQuery UI bundle. When downloaded from jqueryui.com, it looks something like <code>jquery-ui-1.0.00.custom</code>. NOTE: In this release you must use the minified version of the js file (*.min.js)</td>
	</tr>
	<tr>
		<td valign="top"><code>themeName</code></td> 
		<td valign="top"><code>string</code></td> 
		<td valign="top">Optional</td> 
		<td valign="top"><code>[value defined in "UI Theme Name" field]</code></td> 
		<td valign="top">The name of the UI theme to use as the source for css. It is a subfolder of the UI Bundle folder.</td> 
	</tr>
	<tr>
		<td valign="top"><code>rootURL</code></td>
		<td valign="top"><code>string</code></td> 
		<td valign="top">Optional</td> 
		<td valign="top"><code>[site]/javascripts/jquery/</code></td> 
		<td valign="top">URL of the containing directory. Use this argument to call remote files.</td> 
	</tr>
	<tr>
		<td valign="top"><code>delimiter</code></td> 
		<td valign="top"><code>string</code></td> 
		<td valign="top">Optional</td> 
		<td valign="top"><code>Chr(13) & Chr(10)</code></td> 
		<td valign="top">The string to place between the tag markup. Use <code>delimiter=""</code> to remove any line breaks</td> 
	</tr>
	<tr>
		<td valign="top"><code>head</code></td> 
		<td valign="top"><code>boolean</code></td> 
		<td valign="top">Optional</td> 
		<td valign="top"><code>false</code></td> 
		<td valign="top">Set <code>head=true</code> to place the output in the head area of the HTML page instead of the default behavior, which is to place the output where the function is called from.</td> 
	</tr>
<tbody> 
</table>

<h3>Usage Example</h3>
<pre>
&lt;!--- JQuackUI() Examples ---&gt;
&lt;!--- call the UI bundle as defined in config ---&gt;
#JQuackUI()#

&lt;!--- include the UI with a different theme ---&gt;
#JQuackUI(themeName="rainy")#

&lt;!--- include a different UI bundle ---&gt;
#JQuackUI(UIBundleName="jquery-ui-1.2.34.custom")#

&lt;!--- write the output to the head area of the HTML page ---&gt;
#JQuackUI(head=true)#
</pre>

<h2>JQuackTheme()</h2>
NOTE: This function is called within JQuackUI(), so should only be used to override the theme used in JQuackUI()<br />
<table class="doc">
<thead> 
	<tr> 
		<th>Argument</th> 
		<th>Type</th> 
		<th>Required</th> 
		<th>Default</th> 
		<th>Description</th> 
	</tr> 
</thead> 
<tbody>
	<tr>
		<td valign="top"><code>themeName</code></td> 
		<td valign="top"><code>string</code></td> 
		<td valign="top">Required</td> 
		<td valign="top"><code></code></td> 
		<td valign="top">The name of the UI theme to use as the source for css. It is a subfolder of the UI Bundle folder.</td> 
	</tr>
	<tr>
		<td valign="top"><code>UIBundleName</code></td> 
		<td valign="top"><code>string</code></td> 
		<td valign="top">Optional</td> 
		<td valign="top"><code>[value defined in "UI Bundle Name" field]</code></td> 
		<td valign="top">The name of the jQuery UI bundle. When downloaded from jqueryui.com, it looks something like <code>jquery-ui-1.0.00.custom</code>.</td>
	</tr>
	<tr>
		<td valign="top"><code>rootURL</code></td>
		<td valign="top"><code>string</code></td> 
		<td valign="top">Optional</td> 
		<td valign="top"><code>[site]/javascripts/jquery/</code></td> 
		<td valign="top">URL of the containing directory. Use this argument to call remote files.</td> 
	</tr>
	<tr>
		<td valign="top"><code>delimiter</code></td> 
		<td valign="top"><code>string</code></td> 
		<td valign="top">Optional</td> 
		<td valign="top"><code>Chr(13) & Chr(10)</code></td> 
		<td valign="top">The string to place between the tag markup. Use <code>delimiter=""</code> to remove any line breaks</td> 
	</tr>
	<tr>
		<td valign="top"><code>head</code></td> 
		<td valign="top"><code>boolean</code></td> 
		<td valign="top">Optional</td> 
		<td valign="top"><code>false</code></td> 
		<td valign="top">Set <code>head=true</code> to place the output in the head area of the HTML page instead of the default behavior, which is to place the output where the function is called from.</td> 
	</tr>
<tbody> 
</table>

<h3>Usage Example</h3>
<pre>
&lt;!--- JQuackTheme() Examples ---&gt;

&lt;!--- include a different theme ---&gt;
#JQuackTheme(themeName="wacky")#

&lt;!--- write the output to the head area of the HTML page ---&gt;
#JQuackTheme(themeName="wacky", head=true)#
</pre>

<h2>JQuackAll()</h2> 
<table class="doc">
<thead> 
	<tr> 
		<th>Argument</th> 
		<th>Type</th> 
		<th>Required</th> 
		<th>Default</th> 
		<th>Description</th> 
	</tr> 
</thead> 
<tbody> 
	<tr>
		<td valign="top"><code>delimiter</code></td> 
		<td valign="top"><code>string</code></td> 
		<td valign="top">Optional</td> 
		<td valign="top"><code>Chr(13) & Chr(10)</code></td> 
		<td valign="top">The string to place between the tag markup. Use <code>delimiter=""</code> to remove any line breaks</td> 
	</tr>
	<tr>
		<td valign="top"><code>head</code></td> 
		<td valign="top"><code>boolean</code></td> 
		<td valign="top">Optional</td> 
		<td valign="top"><code>false</code></td> 
		<td valign="top">Set <code>head=true</code> to place the output in the head area of the HTML page instead of the default behavior, which is to place the output where the function is called from.</td> 
	</tr>
<tbody> 
</table>

<h3>Usage Example</h3>
<pre>
&lt;!--- JQuackAll() Examples ---&gt;
&lt;!--- include all files ---&gt;
#JQuackAll()#

&lt;!--- include all files without line breaks ---&gt;
#JQuackAll(delimiter="")#

&lt;!--- write all output to the head area of the HTML page ---&gt;
#JQuackAll(head=true)#
</pre>

<h2>Donations</h2>
<p>In spite of the disclaimer above, should this plugin make you filthy rich, attractive, cool or just more productive, I am desparate for a new ivory back-scratcher and a mint 1970 Boss Mustang.</p>

<h2>Contributions</h2>
<p>JQuack will be on GitHub soon.. but for the time being just email any bugs or suggestions to adam.p.chapman at g mail dot com</p>

<h2>Credits</h2>
<p>
	<ul>
		<li>Tony Petruzzi for his many replies to all things CFWheels, plugins and unit testing</li>
		<li>CFWheels and jQuery for all-round awesomeness</li>
	</ul>
</p>

<h2>JQuack Roadmap</h2>
<p>
	<ul>
		<li>Better support for external file requests</li>
		<li>Support for non minified versions of UI files</li>
		<li>File verification tool</li>
		<li>Unit test improvements</li>
	</ul>
</p>

<h2>Disclaimer</h2>
<p>Use this plugin at your own risk. All care taken, but no responsibility.<br /> This plugin may:
	<ul>
		<li>Not work as described</li>
		<li>Cause your hair to fall out</li>
		<li>Transfer money from your bank account to a Nigerian Prince</li>
	</ul>
</p>

<a href="<cfoutput>#cgi.http_referer#</cfoutput>"><< Back</a>