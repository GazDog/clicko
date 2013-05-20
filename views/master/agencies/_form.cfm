<cfoutput>
	#input(inputType="textField", objectName="agency", property="name", label="Name")#
	#input(inputType="textField", objectName="agency", property="streetnumber", label="Street Number")#
	#input(inputType="textField", objectName="agency", property="streetname", label="Street Name")#
	#input(inputType="textField", objectName="agency", property="suburb", label="Suburb")#
	#input(inputType="textField", objectName="agency", property="phone", label="Phone")#
	#input(inputType="textField", objectName="agency", property="email", label="Email")#
	<!--- #input(inputType="textField", objectName="agency", property="statusid", label="Status")# --->
	#input(inputType="select", objectName="agency", property="accesslevel", options=accessLevels, label="Access Level")#
</cfoutput>