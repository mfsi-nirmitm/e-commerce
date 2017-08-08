<!--- Form processing script starts here --->
<cfif structKeyExists(form,'fld_newUserSubmit')>
	<!---Server side data validation--->
	<cfset aErrorMessages = Arraynew(1) />
	<!---Validate first name--->
	<cfif form.fld_userFirstName EQ ''>
		<cfset arrayAppend(aErrorMessages,'Please provide a valid first name') />
	</cfif>
	<cfif form.fld_userLastName EQ ''>
		<cfset arrayAppend(aErrorMessages,'Please provide a valid last name') />
	</cfif>
	<cfif form.fld_userEmail EQ '' OR NOT isValid("eMail",form.fld_userEmail)>
		<cfset arrayAppend(aErrorMessages,'Please provide a valid Email') />
	</cfif>
	<cfif ArrayisEmpty(aErrorMessages)>
		<!---generate the missing data--->
		<cfset form.fld_userPassword = generateSecretKey("AES") />
		<cfset form.fld_userRole = 1 />
		<cfset form.fld_userApproved = 0 />
		<cfset form.fld_userIsActive = 0 />
		<!---Insert data in database if no error detected--->
		<cfquery datasource = "hdStreet">
			INSERT INTO TBL_USERS
			(FLD_USERFIRSTNAME,FLD_USERLASTNAME,FLD_USEREMAIL, FLD_USERPASSWORD,FLD_USERAPPROVED, FLD_USERISACTIVE, FLD_USERROLE,FLD_USERINSTRUMENT)
			VALUES
			('#form.fld_userFirstName#','#form.fld_userLastName#','#form.fld_userEmail#','#form.fld_userPassword#','#form.fld_userComment#',#form.fld_userIsActive#,#form.fld_userRole#,#form.fld_userInstrument#)
		</cfquery>
	</cfif>
</cfif>
<!---Get page content for fld_pageID = 4--->
<cfquery datasource="hdStreet" name="rsPage">
	SELECT FLD_PAGETITLE, FLD_PAGECONTENT
	FROM TBL_PAGES
	WHERE FLD_PAGEID = 4 AND FLD_PAGEISACTIVE = 1
</cfquery>
<!--- Get the instruments list to fill the drop menu of the form--->
<cfquery datasource="hdStreet" name="rsInstrumentsList">
	SELECT FLD_INSTRUMENTID, FLD_INSTRUMENTNAME
	FROM TBL_INSTRUMENTS
	ORDER BY FLD_INSTRUMENTNAME ASC
</cfquery>
<cf_front>
  <div id="pageBody">
  	<div id="calendarContent">
    <!---Erase from here--->
    <h1>Come play with us</h1>
<p><img src="images/homeImage.jpg" alt="the band playin" width="300" height="201" class="floatLeft" />You are a musician and want to come play with us? Read on... all the information you need is on this page.</p>
<h2>What level?</h2>
<p>A band certainly is one of the bast place to learn how to play music. As such, we welcome anyone interested in playing music with us. Of course it is required to be able to read musical notation and have some practice with your instruments.</p>
<p>If you feel ready, if you're up to it, we'll be more than happy to welcome you in the band. There certainly is a spot on the stage for everyone.</p>
    <h2>What instruments?</h2>
    <p>A band like ours include brass instruments, woodwind instrumants and some percussion. We need no strings except for a bass guitar and a harp for some pieces. Here is a list of instruments we are currently looking for. If you are not sure about the instrument you play, please contact us.</p>
    <h3>Brass</h3>
    <ul>
      <li>Trumpet - Trombone - Horn - Tuba</li>
    </ul>
    <h3>Woodwind</h3>
    <ul>
      <li>Saxophone - Clarinet - Oboe - English Horn - Flute</li>
    </ul>
    <h3>Percussion</h3>
    <ul>
      <li>Drums - Timpani - Xylophone - Vibraphone</li>
    </ul>
    <h2>About the rehersals</h2>
    <p>We rehearse once a week on Wednesay nights from 8:00pm till 10:00pm at the Baton Rouge High school. Sometimes, we add extra-rehearsals and dress-rehearsals as required by the concert schedule.</p>
    <h2>Contact us</h2>
    <p>If you want to play with us, please feel free to contact us by e-mail <a href="mailto:info@hdstreetband.com">info@hdstreetband.com</a></p>
    <p>&nbsp;</p>
    <!---To here--->
	</div>
	<div id="calendarSideBar">
		<h2>Complete the form below to join our band</h2>
		<cfif isDefined('aErrorMessages') AND NOT ArrayIsEmpty(aErrorMessages)>
			<cfoutput>
				<cfloop array="#aErrorMessages#" index="message">
					<p class="errorMessage">#message#</p>
				</cfloop>
			</cfoutput>
		</cfif>
		<cfform id="frm_newUser">
				<fieldset>
					<legend>Join our band</legend>
					<dl>
						<dt><label>First Name</label></dt>
						<dd><cfinput type="text" name="fld_userFirstName" id="fld_userFirstName" required="true" message="Please enter first name"/></dd>
						<dt><label>Last Name</label></dt>
						<dd><cfinput type="text" name="fld_userLastName" id="fld_userLastName" required="true" message="Please enter last name"/></dd>
						<dt><label>E-mail Address</label></dt>
						<dd><cfinput  type="text" name="fld_userEmail" id="fld_userEmail" required="true" validate="eMail" message="Please enter a valid eMail address" /></dd>
						<dt><label>Instrument</label></dt>
						<dd>
							<cfselect name="fld_userInstrument" id="fld_userInstrument" query = "rsInstrumentsList" value = "FLD_INSTRUMENTID" display="FLD_INSTRUMENTNAME" queryposition="below">
								<option value="0">Please choose your instrument</option>

							</cfselect>
						</dd>
						<dt><label>Comment</label></dt>
						<dd><textarea name="fld_userComment" id="fld_userComment"></textarea></dd>
					</dl>
					<input type="submit" name="fld_newUserSubmit" id="fld_newUserSubmit" value="Join the band" />
				</fieldset>
			</cfform>
	</div>
	</div>
 </div>
</cf_front>
