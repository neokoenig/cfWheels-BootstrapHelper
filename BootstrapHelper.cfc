<cfcomponent output="false">

<!---================================= Boostrap cfwheels plugin ==========================---> 
<!---		Author: 	Tom King / www.oxalto.co.uk / @neokoenig						  --->
<!---		Date: 		March 2012														  --->
<!---		Requires:	See Docs														  --->
<!---		Docs: 		Add Link														  --->
<!---=====================================================================================---> 

<cffunction name="init">
	<cfset this.version = "1.1.7">
    <cfreturn this>
</cffunction>

<!---================================= View Helpers ======================================---> 
<cffunction name="bootstrapHello" hint="Says Hello" mixin="controller">
	<cfset var result="Hello, from Bootstrap">
	<cfreturn result />
</cffunction>  

<cffunction name="bootstrapGrid" mixin="controller"  hint="Outputs a bootstrap grid with markup, defaults to span3, 4 records per row">
<cfargument name="perRow" default="4" required="no" type="numeric" hint="Number of Cells Per Row">
<cfargument name="rowSpan" default="3" required="no" type="numeric" hint="Span Class for each cell">
<cfargument name="partial" default="" required="yes" type="string" hint="The name of the partial to output for the cell">
<cfargument name="recordcount" default="12" required="no" type="numeric" hint="Number of cells"> 
<cfargument name="recordset" required="yes" hint="The query to loop over">
<cfscript>	 
	var loc={};
	// Assign local instance of core IncludePartial to prevent named arguments error in CF9
	var thisincludePartial=core.includePartial;
	loc.perRow=arguments.perRow;
	loc.rowspan=arguments.rowspan;
	loc.partial=arguments.partial;
	loc.recordset=arguments.recordset;   
	</cfscript> 

<cfsavecontent variable="loc.result">
<div class="row">
<cfloop query="loc.recordset">
<cfset arguments.currentCell=currentrow>
	<cfoutput>
        <div class="span#loc.rowSpan#">#thisincludePartial(argumentCollection=arguments)#</div>
        <cfif NOT currentrow MOD loc.perRow AND currentrow NEQ loc.recordset.recordcount></div><div class="row"></cfif>
        <cfif currentrow EQ loc.recordset.recordcount></div></cfif>
    </cfoutput>
</cfloop>
</cfsavecontent>
<cfreturn loc.result />
</cffunction>


<!---================================= Layout Helpers ====================================---> 
<!---	Notes: 	What's the best way to implement CSS in a plugin? you can't use stylesheetlinkTag() as that looks in the stylesheet folder.
				Is it to have a .CSS file which is then 'deployed' into that folder as required? You could do a check in getBootstrapSettings() easily enough
				Same goes for CSS specific images.
				Would be good if this could magically grab from the web and create folders/files, but I think you'd hit permissions issues.
				--->
<cffunction name="getBootstrapCSS" hint="Includes Bootstrap CSS & Custom CSS overrides"  mixin="controller">
	<cfset var result="">
    <cfsavecontent variable="result">
    <cfoutput>#stylesheetlinkTag(sources='bootstrap/css/bootstrap.min')#</cfoutput>
    <style>
	/* Useful for grids etc */
	.append {margin-bottom:10px;}
	
	/*********************CfWHeels/Bootstrap overrides*********/
	.alert p {margin-bottom:0;}
	ul.alert {margin-left:0; padding-left:25px;}
	 
	/* Replicate error fields to look like bootstrap alerts */
	.fieldWithErrors .control-group > label, .fieldWithErrors .control-group .help-block, .fieldWithErrors .control-group .help-inline {
	color: #b94a48;
	}
	.fieldWithErrors .control-group input, .fieldWithErrors .control-group select, .fieldWithErrors .control-group textarea {
	color: #b94a48;
	border-color: #b94a48;
	}
	.fieldWithErrors .control-group input:focus, .fieldWithErrors .control-group select:focus, .fieldWithErrors .control-group textarea:focus {
	border-color: #953b39;
	-webkit-box-shadow: 0 0 6px #d59392;
	-moz-box-shadow: 0 0 6px #d59392;
	box-shadow: 0 0 6px #d59392;
	}
	.fieldWithErrors .control-group .input-prepend .add-on, .fieldWithErrors .control-group .input-append .add-on {
	color: #b94a48;
	background-color: #f2dede;
	border-color: #b94a48;
	}
	.pagination a:hover, .pagination a.active {
		background-color: #f5f5f5; cursor:pointer;
	}
	.pagination  a.active {
		color: #999999;
		cursor: default;
	}
	/* If you use jCrop, this fixes it */
	.jcrop-holder img {max-width:none;}
	 
	</style>
    </cfsavecontent>
    <cfreturn result />
</cffunction>

<!---	Notes: 	This one's obviously optional - lots of people will want to roll their own, but for ease it's here --->
<cffunction name="getBootstrapJS" hint="Includes Bootstrap JS from CDN, including jQuery latest"  mixin="controller">
	<cfset var result="">
    <cfsavecontent variable="result">
    <cfoutput>
    #javascriptIncludeTag(sources="
    http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js,
    http://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.0.1/bootstrap.min.js")#
    </cfoutput>
    <script>
    // Bootstrap config:
	$('.dropdown-toggle').dropdown()
	$(".collapse").collapse(); 
	</script>
    </cfsavecontent>
    <cfreturn result />
</cffunction>

<!---	Notes: 	This one's obviously optional but useful as a starter --->
<cffunction name="getBootstrapMeta" hint="Adds Bootstrap Meta tags like viewport"  mixin="controller">
	<cfset var result="">
    <cfsavecontent variable="result">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">     
    <!--[if lt IE 9]><script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script><![endif]-->
    </cfsavecontent>
    <cfreturn result />
</cffunction> 


<!---	Notes: 	Uses core.DateTimeSelectTags --->
<cffunction name="bootStrapDateTimeSelectTags" mixin="controller">
    <cfargument name="groupLabel" type="string" required="false" default="" hint="Special Arg for this override">
	<cfscript>
	var loc={};
	var thisdateTimeSelectTags=core.dateTimeSelectTags;
	loc.result="";
    loc.prepend="<div class='control-group'>";
    loc.append="</div></div>";
	</cfscript>
    <cfif structkeyexists(arguments, "groupLabel")>
    	<cfset loc.prepend=loc.prepend & "<label class='control-label' for='" & arguments.groupLabel & "'>" & arguments.groupLabel & "</label>">
        <cfset structdelete(arguments, "groupLabel")> 
    </cfif>
    <cfset loc.prepend=loc.prepend &  "<div class='controls'>">
    <cfset loc.result=loc.prepend & thisdateTimeSelectTags(argumentCollection=arguments) & loc.append>
    <cfreturn loc.result />
</cffunction>

<cffunction name="bootStrapDateSelectTags" mixin="controller">
    <cfargument name="groupLabel" type="string" required="false" default="" hint="Special Arg for this override">
	<cfscript>
	var loc={};
	var thisdateSelectTags=core.dateSelectTags;
	loc.result="";
    loc.prepend="<div class='control-group'>";
    loc.append="</div></div>";
	</cfscript>
    <cfif structkeyexists(arguments, "groupLabel")>
    	<cfset loc.prepend=loc.prepend & "<label class='control-label' for='" & arguments.groupLabel & "'>" & arguments.groupLabel & "</label>">
        <cfset structdelete(arguments, "groupLabel")> 
    </cfif>
    <cfset loc.prepend=loc.prepend &  "<div class='controls'>">
    <cfset loc.result=loc.prepend & thisdateSelectTags(argumentCollection=arguments) & loc.append>
    <cfreturn loc.result />
</cffunction>
 
<!---================================= Administrative ====================================---> 
<cffunction name="getBootstrapSettings" hint="Some sensible cfWheels defaults to include" mixin="application">
<cfset var result="">
<cfsavecontent variable="result"> 
<cfscript>
//	Form Defaults
set(functionName="textField,textFieldTag,textArea,textAreaTag,passwordField,passwordFieldTag,select,selectTag,fileField,fileFieldTag", 
	labelPlacement="before",
	labelClass="control-label",
	prependToLabel="<div class='control-group'>", 
	prepend="<div class='controls'>",
	append="</div></div>"
);
  
// Checkboxes & Radio Buttons
set(functionName="checkBoxTag", 
	labelPlacement="around",
	labelClass="controls", 
	prependToLabel="<div class='control-group'>",
	prepend="<div class='controls'>",
	append="</div></div>"  );

// Just here for reference:
set(functionName="bootStrapDateTimeSelectTags,bootStrapDateSelectTags");
 set(functionName="startFormTag", class="form-horizontal");
set(functionName="submitTag", class="btn");

// Give flash messages a default alert class
set(functionName="flashMessages", class="alert alert-info");
set(functionName="errorMessagesFor", class="alert alert-danger");

//	Paging
set(functionName="paginationLinks", 
	 prepend="<div class=""pagination""><ul>",
	 append="</ul></div>",
	 prependToPage="<li>",
	 appendToPage="</li>",
	 linkToCurrentPage=true,
	 classForCurrent="active",
	 anchorDivider="");
</cfscript>
</cfsavecontent>
<cfreturn result />
</cffunction> 

</cfcomponent>