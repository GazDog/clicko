<cfoutput><!DOCTYPE html>
	<html lang="en">
		<head>
			<meta charset="utf-8">
			<title>#get("appName")# : #includeContent("pageTitle")#</title>
			<meta name="description" content="">
			<meta name="author" content="">
			<!-- Le HTML5 shim, for IE6-8 support of HTML elements -->
			<!--[if lt IE 9]>
				<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
				<![endif]-->
			<!-- Le styles -->
			
			#jQuackCore()#
			#jQuackUI()#
			
			#styleSheetLinkTag("bootstrap-2.1.1/css/bootstrap")# 
			#styleSheetLinkTag("bootstrap-2.1.1/css/bootstrap-responsive")#
			#styleSheetLinkTag("bootstrap.less")#

			<!--- #styleSheetLinkTag("bootstrap/bootstrap")#  --->
			<!--- #styleSheetLinkTag("cerulean.bootstrap.min")# --->
			<!--- NOTE: bootstrap js is included in _close partial --->
			<!--- #styleSheetLinkTag("bootstrap/bootstrap-responsive")# --->
			<!--- #lessFileLinkTag("bootstrap")# --->
			
			<style>
				body { padding-top: 60px; /* 60px to make the container go all the way to the bottom of the topbar */ } 
				##flashContainer {position:fixed; top:40px; width:100%;}
			</style>
			
			<script>
				$(window).load(function() {	
					<!--- hide success messages --->
					var hideSuccess = function() {
						$("##flashContainer div.alert-success, ##flashContainer div.alert-info").slideUp();
					}
					setTimeout(hideSuccess,5000);
				});
			</script>

			<!-- Le fav and touch icons -->
			<link rel="shortcut icon" href="images/favicon.html">
			<link rel="apple-touch-icon" href="images/apple-touch-icon.html">
			<link rel="apple-touch-icon" sizes="72x72" href="images/apple-touch-icon-72x72.html">
			<link rel="apple-touch-icon" sizes="114x114" href="images/apple-touch-icon-114x114.html">
			<cfif get("environment") IS "design"><!-- [signedIn:#signedIn()#] --></cfif>
		</head>
		<body>
</cfoutput>