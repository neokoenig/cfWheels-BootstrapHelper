<cfprocessingdirective pageencoding="utf8" suppresswhitespace="yes">
<!--- Notes: 	Would be nice if this was in Bootstrap style, but don't think plugins can have their own layout.cfm??
				If you could, you could then use this as a way to demonstrate everything
				
				--->
<cfscript>
	bootstrapHelper = {};
	bootstrapHelper.version = "0.1";
	
	// Set some paths
	bootstrapHelper.cssCheck.root="/stylesheets/bootstrap"; 
	bootstrapHelper.cssCheck.cssPath =expandPath(bootstrapHelper.cssCheck.root & "/css");
	bootstrapHelper.cssCheck.imgPath =expandPath(bootstrapHelper.cssCheck.root & "/css/img");
	
	// Check for location of CSS files
	bootstrapHelper.cssCheck.main = fileexists(bootstrapHelper.cssCheck.cssPath & "/bootstrap.min.css");
	bootstrapHelper.cssCheck.icons = fileexists(bootstrapHelper.cssCheck.imgPath & "/glyphicons-halflings.png");
	bootstrapHelper.cssCheck.iconsWhite = fileexists(bootstrapHelper.cssCheck.imgPath & "/glyphicons-halflings-white.png");
	
	// Flags
	bootstrapHelper.valid.css=iif(bootstrapHelper.cssCheck.main, true, false);
	bootstrapHelper.valid.img=iif(bootstrapHelper.cssCheck.icons AND bootstrapHelper.cssCheck.iconsWhite, true, false);
</cfscript> 
 
 
<cfoutput>
<h1>BootstrapHelper #bootstrapHelper.version#</h1>
<p>Description here</p> 
<h2>Usage</h2>
<h3>Layout Helpers</h3>
<p>
<strong>getBootstrapSettings() </strong>- <br />
gets a load of cfwheels set() defaults for
formhelpers to output expected syntax for cfwheels form helpers - needs to
be added to events/onapplicationstart.cfm
<p><strong>getBootstrapCSS()</strong> - <br />
  gets CSS overrides to make cfwheels outputs like
  errorMessagesFor() look like bootstrap 
etc - for
layout.cfm header, classes to buttons etc..
<p><strong>getBootstrapJS()<br />
</strong>gets Bootstrap JS from CDN, includes jQuery 1.7 - for
  layout.cfm footer
  <p><strong>getBootstrapMeta() </strong>- <br />
    outputs HTML5 js + viewport meta tags - for layout.cfm
    head section
  <h3>View helpers:
  </h3>
  <p><strong>bootstrapGrid(partial="yourPartial", perRow=4, rowspan=3, recordset=yourRecordset)</strong> - <br />
    Outputs a bootstrap style grid, defaults to span3, 4
        records per row - basically a shortcut to having to work out the opening
        and closing
&lt;divs&gt;
    , good for image galleries - takes a partial as an
        argument, plus perRow, rowSpan etc..
  <p><strong>bootStrapDateTimeSelectTags(name="foo", groupLabel="bootStrap", labelClass="", class="span1")<br />
  </strong>alternative for cfWheels form helpers -
          wraps datetime select tags differently, and adds groupLabel for a label on the
          left.
  <p><strong>bootStrapDateSelectTags()</strong> - as above without time
</p>
  <h2>Checking File locations</h2>
<table>
<thead>
    <tr><th>Test</th><th>Result</th></tr>
</thead>
<tr>
	<td>CSS Valid?</td><td>#bootstrapHelper.valid.css#</td>
</tr>
<tr>
	<td>IMG Valid?</td><td>#bootstrapHelper.valid.img#</td>
</tr> 
</table> 
</cfoutput>
</cfprocessingdirective>