<cfoutput>
<h1>LessSupport V#LessSupportVersion()#</h1>

<p>LessSupport enables the <code>styleSheetLinkTag()</code> to support <a href="http://lesscss.org/" target="_blank">LESS</a> extended stylesheets</p>

<h3>Example</h3>
<pre>
&lt;!--- view code --->
&lt;head>
	&lt;!--- Includes `stylesheets/styles.less` --->
	##styleSheetLinkTag("styles.less")##
&lt;/head>

&lt;body>
	&lt;!--- This will still appear in the `head` --->
	##styleSheetLinkTag("styles.less", head=true)##
&lt;/body>
</pre>

<h2>Disclaimer</h2>
<p>Use this plugin at your own risk. All care taken, but no responsibility.<br /> This plugin may:
	<ul>
		<li>Not work as described</li>
		<li>Touch you inappropriately</li>
	</ul>
</p>

</cfoutput>