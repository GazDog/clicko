<CFSETTING ENABLECFOUTPUTONLY="YES">
<!----------------------------------------------------------------------------
Name:   CF_HEAD
Author: Dan G. Switzer, II
Date:   December 8, 1998

Description:
This tag is a replacement for the <CFHTMLHEAD> tag. It will take all the 
output between the <CF_HEAD> and </CF_HEAD> tags and place the content into
the <HEAD></HEAD> tags on the HTML document.

Usage:
<CF_HEAD><SCRIPT SRC="./lib/general.js"></SCRIPT></CF_HEAD>
  This would place the <SCRIPT ...></SCRIPT> tags in between the 
  <HEAD></HEAD> of the current HTML document.
----------------------------------------------------------------------------->
<!---// begin end tag code //--->
<CFIF ThisTag.ExecutionMode IS "END">
	<!---// call the "real" tag to place text within <HEAD> tags //--->
	<CFHTMLHEAD TEXT="#Trim(ThisTag.GeneratedContent)#">
	<!---// clear out the variable so no content is generated to the screen //--->
	<CFSET ThisTag.GeneratedContent = "">
</CFIF>
<CFSETTING ENABLECFOUTPUTONLY="NO">