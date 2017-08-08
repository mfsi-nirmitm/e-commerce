<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>Untitled Document</title>
</head>

<body>
<form id="frmUser" name="frmUser" method="get" action="actionPage.cfm">
<fieldset>
<legend>Registration form</legend>
  <p>
    <label for="fld_firstName">First Name</label>
    <input type="text" name="fld_firstName" id="fld_firstName" />
  </p>
  <p>
    <label for="fld_lastName">Last Name</label>
    <input type="text" name="fld_lastName" id="fld_lastName" />
  </p>
  <p>
    <label><input type="radio" name="fld_gender" value="M" id="fld_gender_0" />Male</label>
    <label><input type="radio" name="fld_gender" value="F" id="fld_gender_1" />Female</label>
  </p>
  <p>
    <label for="fld_country">Your Country</label>
    <select name="fld_country" id="fld_country">
      <option value="USA">United States</option>
      <option value="FR">France</option>
      <option value="IT">Italy</option>
      <option value="BE">Belgium</option>
      <option value="SP">Spain</option>
    </select>
  </p>
  <p>What are you most interested in?</p>
  <p>
    <input name="fld_interests" type="checkbox" id="fld_interestsSports" value="sports" />
    <label for="fld_interestsSports">Sports</label>
    <input name="fld_interests" type="checkbox" id="fld_interestsMusic" value="music" />
    <label for="fld_interestsMusic">Music</label>
    <input name="fld_interests" type="checkbox" id="fld_interestsMovie" value="movie" />
    <label for="fld_interestsMovie">Movie</label>
    <input name="fld_interests" type="checkbox" id="fld_interestsGames" value="games" />
    <label for="fld_interestsGames">Games</label>
  </p>
  <p>
    <input name="fld_conditions" type="checkbox" id="fld_conditions" value="YES" />
    <label for="fld_conditions">Yes, I approve the terms and conditions.</label>
  </p>
  <p>
    <label for="fld_comments">Your comment</label>
    <textarea name="fld_comments" id="fld_comments" cols="45" rows="5"></textarea>
  </p>
  </fieldset>
  <p>
    <input type="submit" name="fld_submitUser" id="fld_submitUser" value="I register!" />
  </p>
</form>
</body>
</html>
