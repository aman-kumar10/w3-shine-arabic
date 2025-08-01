{if in_array('state', $optionalFields)}
    <script>
        var statesTab = 10,
            stateNotRequired = true;
    </script>
{/if}

<script src="{$BASE_PATH_JS}/StatesDropdown.js"></script>
<script src="{$BASE_PATH_JS}/PasswordStrength.js"></script>

<script>
    window.langPasswordStrength = "{lang key='pwstrength'}";
    window.langPasswordWeak = "{lang key='pwstrengthweak'}";
    window.langPasswordModerate = "{lang key='pwstrengthmoderate'}";
    window.langPasswordStrong = "{lang key='pwstrengthstrong'}";
    jQuery(document).ready(function() {
        jQuery("#inputNewPassword1").keyup(registerFormPasswordStrengthFeedback);
    });
</script>

{if !$registrationDisabled}
    <section class="page-title register-banner">
        <div class="container">
            <div class="title-text ms-5 text-16">
                <h1>{$LANG.registarSignup}</h1>
            </div>
        </div>
    </section>

	<div class="alert-register-wrapper">
		{if $registrationDisabled}
			{include file="$template/includes/alert.tpl" type="error" msg="{lang key='registerCreateAccount'}"|cat:' <strong><a href="'|cat:"$WEB_ROOT"|cat:'/cart.php" class="alert-link">'|cat:"{lang key='registerCreateAccountOrder'}"|cat:'</a></strong>'}
		{/if}
		{if $errormessage}
			{include file="$template/includes/alert.tpl" type="error" errorshtml=$errormessage}
		{/if}
 	</div>

    <div class="inner-cnt" id="registration">
        <div class="container">
			<form method="post" class="using-password-strength" action="{$smarty.server.PHP_SELF}" role="form" name="orderfrm" id="frmCheckout" enctype="multipart/form-data">
				<input type="hidden" name="register" value="true"/>
				<div class="row">
					{include file="$template/includes/linkedaccounts.tpl" linkContext="registration"}
					<div class="col-12 col-md-12 d-flex justify-content-center">
						<div class="login col-12 col-sm-12 col-md-8 col-lg-8">
							<h3 class="text-center text-16">{$LANG.registarCreateNew}</h3>
							<div class="form-box px-5 py-5">
								<div class="row">
									<h4 class="text-17 fw-bold">{$LANG.registarPersonalInfo}</h4>

									<div class="col-12 col-sm-12 col-md-6 col-lg-6 mb-2">
										<input type="text" name="firstname" id="inputFirstName" class="field form-control" placeholder="{lang key='orderForm.firstName'}" value="{$clientfirstname}" {if !in_array('firstname', $optionalFields)}required{/if} autofocus>
									</div>

									<div class="col-12 col-sm-12 col-md-6 col-lg-6 mb-2">
										<input type="text" name="lastname" id="inputLastName" class="field form-control" placeholder="{lang key='orderForm.lastName'}" value="{$clientlastname}" {if !in_array('lastname', $optionalFields)}required{/if}>
									</div>

									<div class="col-12 col-sm-12 col-md-12 col-lg-12 mb-2">
										<input type="text" name="companyname" id="inputCompanyName" class="field form-control" placeholder="{lang key='orderForm.orgName'}" value="{$clientcompanyname}">
									</div>


									<div id="ctl00_ContentPlaceHolder1_pnlInternational">
										<div class="col-12 col-sm-12 col-md-12 col-lg-12 mb-2">
											<input type="text" name="city" id="inputCity" class="field form-control" placeholder="{lang key='orderForm.city'}" value="{$clientcity}"  {if !in_array('city', $optionalFields)}required{/if}>
										</div>
										<div class="col-12 col-sm-12 col-md-12 col-lg-12 mb-2">
											<div class="row">
												<div class="col-md-6">
													<input type="text" name="address1" id="inputAddress1" class="field form-control" placeholder="{lang key='orderForm.streetAddress'}" value="{$clientaddress1}"  {if !in_array('address1', $optionalFields)}required{/if}>
												</div>
												<div class="col-md-6">
													<input type="text" name="address2" id="inputAddress2" class="field form-control" placeholder="{lang key='orderForm.streetAddress2'}" value="{$clientaddress2}">
												</div>
											</div>
										</div>
									</div>

									<div class="col-12 col-sm-12 col-md-12 col-lg-12 mb-2">
										<input type="text" name="state" id="state" class="field form-control" placeholder="{lang key='orderForm.state'}" value="{$clientstate}"  >
									</div>

									<div id="ctl00_ContentPlaceHolder1_UpdatePanel1">
										<div class="col-12 col-sm-12 col-md-12 col-lg-12 mb-2">
											<div class="form-group prepend-icon">
												<select name="country" id="inputCountry" class="field form-control">
													{foreach $clientcountries as $countryCode => $countryName}
														<option value="{$countryCode}"{if (!$clientcountry && $countryCode eq $defaultCountry) || ($countryCode eq $clientcountry)} selected="selected"{/if}>
															{$countryName}
														</option>
													{/foreach}
												</select>
											</div>
										</div>
									</div>


									<div class="col-12 col-sm-12 col-md-6 col-lg-6 mb-2">
										<input type="text" name="postcode" id="inputPostcode" class="field form-control" placeholder="{lang key='orderForm.postcode'}" value="{$clientpostcode}" {if !in_array('postcode', $optionalFields)}required{/if}>
									</div>

									{if $customfields}
										{foreach $customfields as $customfield}
											<div class="col-12 col-sm-12 col-md-6 col-lg-6 mb-2 userCustom" data-value="{$customfield.name}">
												{$customfield.input}
											</div>
										{/foreach}
									{/if}

									<div class="col-12 col-sm-12 col-md-6 col-lg-6 mb-2">
										<div class="row">
											<div class="col-md-12">
												<div class="form-group">
													<label for="inputPhone" class="field-icon">
														<i class="fas fa-phone"></i>
													</label>
													<input type="tel" name="phonenumber" id="inputPhone" class="field" placeholder="{lang key='orderForm.phoneNumber'}" value="{$clientphonenumber}">
												</div>
											</div>
										</div>
									</div>

									<!-- <div class="col-12 col-sm-12 col-md-6 col-lg-6 mb-2">
										<div class="row">
											<div class="col-md-6">
												<select name="ctl00$ContentPlaceHolder1$dlcontrycodefax" id="ctl00_ContentPlaceHolder1_dlcontrycodefax" class="form-option">
													<option value="44">UK (+44)</option>
													<option value="1">USA (+1)</option>
													<option value="213">Algeria (+213)</option>
													<option value="376">Andorra (+376)</option>
													<option value="244">Angola (+244)</option>
													<option value="1264">Anguilla (+1264)</option>
													<option value="1268">Antigua &amp; Barbuda (+1268)</option>
													<option value="54">Argentina (+54)</option>
													<option value="374">Armenia (+374)</option>
													<option value="297">Aruba (+297)</option>
													<option value="61">Australia (+61)</option>
													<option value="43">Austria (+43)</option>
													<option value="994">Azerbaijan (+994)</option>
													<option value="1242">Bahamas (+1242)</option>
													<option value="973">Bahrain (+973)</option>
													<option value="880">Bangladesh (+880)</option>
													<option value="1246">Barbados (+1246)</option>
													<option value="375">Belarus (+375)</option>
													<option value="32">Belgium (+32)</option>
													<option value="501">Belize (+501)</option>
													<option value="229">Benin (+229)</option>
													<option value="1441">Bermuda (+1441)</option>
													<option value="975">Bhutan (+975)</option>
													<option value="591">Bolivia (+591)</option>
													<option value="387">Bosnia Herzegovina (+387)</option>
													<option value="267">Botswana (+267)</option>
													<option value="55">Brazil (+55)</option>
													<option value="673">Brunei (+673)</option>
													<option value="359">Bulgaria (+359)</option>
													<option value="226">Burkina Faso (+226)</option>
													<option value="257">Burundi (+257)</option>
													<option value="855">Cambodia (+855)</option>
													<option value="237">Cameroon (+237)</option>
													<option value="1">Canada (+1)</option>
													<option value="238">Cape Verde Islands (+238)</option>
													<option value="1345">Cayman Islands (+1345)</option>
													<option value="236">Central African Republic (+236)</option>
													<option value="56">Chile (+56)</option>
													<option value="86">China (+86)</option>
													<option value="57">Colombia (+57)</option>
													<option value="269">Comoros (+269)</option>
													<option value="242">Congo (+242)</option>
													<option value="682">Cook Islands (+682)</option>
													<option value="506">Costa Rica (+506)</option>
													<option value="385">Croatia (+385)</option>
													<option value="53">Cuba (+53)</option>
													<option value="90392">Cyprus North (+90392)</option>
													<option value="357">Cyprus South (+357)</option>
													<option value="42">Czech Republic (+42)</option>
													<option value="45">Denmark (+45)</option>
													<option value="253">Djibouti (+253)</option>
													<option value="1809">Dominica (+1809)</option>
													<option value="1809">Dominican Republic (+1809)</option>
													<option value="593">Ecuador (+593)</option>
													<option value="20">Egypt (+20)</option>
													<option value="503">El Salvador (+503)</option>
													<option value="240">Equatorial Guinea (+240)</option>
													<option value="291">Eritrea (+291)</option>
													<option value="372">Estonia (+372)</option>
													<option value="251">Ethiopia (+251)</option>
													<option value="500">Falkland Islands (+500)</option>
													<option value="298">Faroe Islands (+298)</option>
													<option value="679">Fiji (+679)</option>
													<option value="358">Finland (+358)</option>
													<option value="33">France (+33)</option>
													<option value="594">French Guiana (+594)</option>
													<option value="689">French Polynesia (+689)</option>
													<option value="241">Gabon (+241)</option>
													<option value="220">Gambia (+220)</option>
													<option value="7880">Georgia (+7880)</option>
													<option value="49">Germany (+49)</option>
													<option value="233">Ghana (+233)</option>
													<option value="350">Gibraltar (+350)</option>
													<option value="30">Greece (+30)</option>
													<option value="299">Greenland (+299)</option>
													<option value="1473">Grenada (+1473)</option>
													<option value="590">Guadeloupe (+590)</option>
													<option value="671">Guam (+671)</option>
													<option value="502">Guatemala (+502)</option>
													<option value="224">Guinea (+224)</option>
													<option value="245">Guinea - Bissau (+245)</option>
													<option value="592">Guyana (+592)</option>
													<option value="509">Haiti (+509)</option>
													<option value="504">Honduras (+504)</option>
													<option value="852">Hong Kong (+852)</option>
													<option value="36">Hungary (+36)</option>
													<option value="354">Iceland (+354)</option>
													<option selected="selected" value="91">India (+91)</option>
													<option value="62">Indonesia (+62)</option>
													<option value="98">Iran (+98)</option>
													<option value="964">Iraq (+964)</option>
													<option value="353">Ireland (+353)</option>
													<option value="972">Israel (+972)</option>
													<option value="39">Italy (+39)</option>
													<option value="1876">Jamaica (+1876)</option>
													<option value="81">Japan (+81)</option>
													<option value="962">Jordan (+962)</option>
													<option value="7">Kazakhstan (+7)</option>
													<option value="254">Kenya (+254)</option>
													<option value="686">Kiribati (+686)</option>
													<option value="850">Korea North (+850)</option>
													<option value="82">Korea South (+82)</option>
													<option value="965">Kuwait (+965)</option>
													<option value="996">Kyrgyzstan (+996)</option>
													<option value="856">Laos (+856)</option>
													<option value="371">Latvia (+371)</option>
													<option value="961">Lebanon (+961)</option>
													<option value="266">Lesotho (+266)</option>
													<option value="231">Liberia (+231)</option>
													<option value="218">Libya (+218)</option>
													<option value="417">Liechtenstein (+417)</option>
													<option value="370">Lithuania (+370)</option>
													<option value="352">Luxembourg (+352)</option>
													<option value="853">Macao (+853)</option>
													<option value="389">Macedonia (+389)</option>
													<option value="261">Madagascar (+261)</option>
													<option value="265">Malawi (+265)</option>
													<option value="60">Malaysia (+60)</option>
													<option value="960">Maldives (+960)</option>
													<option value="223">Mali (+223)</option>
													<option value="356">Malta (+356)</option>
													<option value="692">Marshall Islands (+692)</option>
													<option value="596">Martinique (+596)</option>
													<option value="222">Mauritania (+222)</option>
													<option value="269">Mayotte (+269)</option>
													<option value="52">Mexico (+52)</option>
													<option value="691">Micronesia (+691)</option>
													<option value="373">Moldova (+373)</option>
													<option value="377">Monaco (+377)</option>
													<option value="976">Mongolia (+976)</option>
													<option value="1664">Montserrat (+1664)</option>
													<option value="212">Morocco (+212)</option>
													<option value="258">Mozambique (+258)</option>
													<option value="95">Myanmar (+95)</option>
													<option value="264">Namibia (+264)</option>
													<option value="674">Nauru (+674)</option>
													<option value="977">Nepal (+977)</option>
													<option value="31">Netherlands (+31)</option>
													<option value="687">New Caledonia (+687)</option>
													<option value="64">New Zealand (+64)</option>
													<option value="505">Nicaragua (+505)</option>
													<option value="227">Niger (+227)</option>
													<option value="234">Nigeria (+234)</option>
													<option value="683">Niue (+683)</option>
													<option value="672">Norfolk Islands (+672)</option>
													<option value="670">Northern Marianas (+670)</option>
													<option value="47">Norway (+47)</option>
													<option value="968">Oman (+968)</option>
													<option value="92">Pakistan (+92)</option>
													<option value="680">Palau (+680)</option>
													<option value="507">Panama (+507)</option>
													<option value="675">Papua New Guinea (+675)</option>
													<option value="595">Paraguay (+595)</option>
													<option value="51">Peru (+51)</option>
													<option value="63">Philippines (+63)</option>
													<option value="48">Poland (+48)</option>
													<option value="351">Portugal (+351)</option>
													<option value="1787">Puerto Rico (+1787)</option>
													<option value="974">Qatar (+974)</option>
													<option value="262">Reunion (+262)</option>
													<option value="40">Romania (+40)</option>
													<option value="7">Russia (+7)</option>
													<option value="250">Rwanda (+250)</option>
													<option value="378">San Marino (+378)</option>
													<option value="239">Sao Tome &amp; Principe (+239)</option>
													<option value="966">Saudi Arabia (+966)</option>
													<option value="221">Senegal (+221)</option>
													<option value="381">Serbia (+381)</option>
													<option value="248">Seychelles (+248)</option>
													<option value="232">Sierra Leone (+232)</option>
													<option value="65">Singapore (+65)</option>
													<option value="421">Slovak Republic (+421)</option>
													<option value="386">Slovenia (+386)</option>
													<option value="677">Solomon Islands (+677)</option>
													<option value="252">Somalia (+252)</option>
													<option value="27">South Africa (+27)</option>
													<option value="34">Spain (+34)</option>
													<option value="94">Sri Lanka (+94)</option>
													<option value="290">St. Helena (+290)</option>
													<option value="1869">St. Kitts (+1869)</option>
													<option value="1758">St. Lucia (+1758)</option>
													<option value="249">Sudan (+249)</option>
													<option value="597">Suriname (+597)</option>
													<option value="268">Swaziland (+268)</option>
													<option value="46">Sweden (+46)</option>
													<option value="41">Switzerland (+41)</option>
													<option value="963">Syria (+963)</option>
													<option value="886">Taiwan (+886)</option>
													<option value="7">Tajikstan (+7)</option>
													<option value="66">Thailand (+66)</option>
													<option value="228">Togo (+228)</option>
													<option value="676">Tonga (+676)</option>
													<option value="1868">Trinidad &amp; Tobago (+1868)</option>
													<option value="216">Tunisia (+216)</option>
													<option value="90">Turkey (+90)</option>
													<option value="7">Turkmenistan (+7)</option>
													<option value="993">Turkmenistan (+993)</option>
													<option value="1649">Turks &amp; Caicos Islands (+1649)</option>
													<option value="688">Tuvalu (+688)</option>
													<option value="256">Uganda (+256)</option>
													<option value="44">UK (+44)</option>
													<option value="380">Ukraine (+380)</option>
													<option value="971">United Arab Emirates (+971)</option>
													<option value="598">Uruguay (+598)</option>
													<option value="1">USA (+1)</option>
													<option value="7">Uzbekistan (+7)</option>
													<option value="678">Vanuatu (+678)</option>
													<option value="379">Vatican City (+379)</option>
													<option value="58">Venezuela (+58)</option>
													<option value="84">Vietnam (+84)</option>
													<option value="84">Virgin Islands - British (+1284)</option>
													<option value="84">Virgin Islands - US (+1340)</option>
													<option value="681">Wallis &amp; Futuna (+681)</option>
													<option value="969">Yemen (North)(+969)</option>
													<option value="967">Yemen (South)(+967)</option>
													<option value="260">Zambia (+260)</option>
													<option value="263">Zimbabwe (+263)</option>
												</select>
											</div>
											<div class="col-md-6 mb-4">
												<input name="ctl00$ContentPlaceHolder1$txtRegistrantFax" type="text" id="ctl00_ContentPlaceHolder1_txtRegistrantFax" class="form-control" placeholder="Fax">
											</div>
										</div>
									</div> -->

									<div id="ctl00_ContentPlaceHolder1_up2" class="upload_doc_div">
										<div id="ctl00_ContentPlaceHolder1_Panel1">
											<h4 class="text-17 fw-bold">{$LANG.registarIdDoc}</h4>
											<div class="col-12 col-sm-12 col-md-6 col-lg-6 mb-2">
												{$LANG.registarIdUpload}
												<input type="file" name="upload_doc" id="ctl00_ContentPlaceHolder1_FileUpload1" 
													   class="form-control upload_doc"
													   accept=".pdf, .doc, .docx, .jpeg, .jpg, .png" />
											</div>
										</div>
										<div id="file-upload-error" style="color: red; font-size: 0.9em; margin-top: 5px;"></div>
									</div>
									
									
									<h4 class="text-17 fw-bold">{$LANG.registarSignIn}</h4>

									<div class="col-12 col-sm-12 col-md-6 col-lg-6 mb-2">
										<input type="email" name="email" id="inputEmail" class="field form-control" placeholder="{lang key='orderForm.emailAddress'}"  value="{$clientemail}">
									</div>
									<div class="clearfix"></div>

									<div id="containerPassword" class="row{if $remote_auth_prelinked && $securityquestions} hidden{/if}">
										<div id="passwdFeedback" class="alert alert-info text-center col-sm-12 w-hidden"></div>
										<div class="col-md-6">
											<div class="form-group prepend-icon">
												<input type="password" name="password" id="inputNewPassword1" data-error-threshold="{$pwStrengthErrorThreshold}" data-warning-threshold="{$pwStrengthWarningThreshold}" class="field form-control" placeholder="{lang key='clientareapassword'}" autocomplete="off"{if $remote_auth_prelinked} value="{$password}"{/if}>
											</div>
										</div>
										<div class="col-md-6">
											<div class="form-group prepend-icon">
												<input type="password" name="password2" id="inputNewPassword2" class="field form-control" placeholder="{lang key='clientareaconfirmpassword'}" autocomplete="off"{if $remote_auth_prelinked} value="{$password}"{/if}>
											</div>
										</div>
										<div class="col-md-6">
											<div class="form-group mt-2">
												<button type="button" class="btn btn-default btn-sm btn-sm-block generate-password" data-targetfields="inputNewPassword1,inputNewPassword2">
													{lang key='generatePassword.btnLabel'}
												</button>
											</div>
										</div>
										<div class="col-md-6 mt-2">
											<div class="password-strength-meter">
												<div class="progress">
													<div class="progress-bar bg-success bg-striped" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" id="passwordStrengthMeterBar">
													</div>
												</div>
												<p class="text-center small text-muted" id="passwordStrengthTextLabel">{lang key='pwstrength'}: {lang key='pwstrengthenter'}</p>
											</div>
										</div>
									</div>

									<div class="col-md-12 mb-4">
										{include file="$template/includes/captcha.tpl"}
									</div>

									<div class="col-md-12 contact_button">
										<button class="btn btn-lg btn-primary{$captcha->getButtonClass($captchaForm)}" id="submit_register" value="">{$LANG.registarCreateNew}</button>
									</div>
									
								</div>
							</div>

						</div>

					</div>

				</div>
			</form>
        </div>
    </div>

{/if}


<script>
    $(document).ready(function () {

        function toggleUploadDocDiv() {
            const selectedCountry = $('#inputCountry').val();
            if (selectedCountry === 'IN') {
                $('#ctl00_ContentPlaceHolder1_up2').hide();
            } else {
                $('#ctl00_ContentPlaceHolder1_up2').show();
            }
        }

        toggleUploadDocDiv()
        $('#inputCountry').on('change', function () {
            toggleUploadDocDiv();
        });

	
    });
	

</script>
<script>

    // document.getElementById('inputCountry').addEventListener('change', function () {
	// const stateInput = document.getElementById('stateinput'); // State input field
	// const stateInputError = document.getElementById('stateinput-error'); // State input error label
	// const stateSelect = document.getElementById('stateselect'); // State dropdown
	// const stateSelectError = document.getElementById('stateselect-error'); // State dropdown error label

	// 	// Reset error messages
	// 	stateInputError.innerHTML = '';
	// 	stateSelectError.innerHTML = '';

	// 	// Check which field is active and validate
	// 	if (stateInput.style.display === 'block') { 
	// 		if (stateInput.value.trim() === '') {
	// 			stateInputError.innerHTML = 'State is required';
	// 		}
	// 	} else if (stateSelect.style.display === 'block') {
	// 		if (stateSelect.value.trim() === '') {
	// 			stateSelectError.innerHTML = 'State is required';
	// 		}
	// 	}
	// });

	document.addEventListener('DOMContentLoaded', function () {
		const countryField = document.getElementById('inputCountry'); // Country dropdown
		const stateInput = document.getElementById('stateinput'); // State input field
		const stateInputError = document.getElementById('stateinput-error'); // State input error label
		const stateSelect = document.getElementById('stateselect'); // State dropdown
		const stateSelectError = document.getElementById('stateselect-error'); // State dropdown error label

		// Add change event listener to the country field
		if (countryField) {
			countryField.addEventListener('change', function () {
				console.log('sss');
				// Clear previous errors
				if (stateInputError) stateInputError.innerHTML = '';
				if (stateSelectError) stateSelectError.innerHTML = '';

				// Validate state input or select based on visibility
				if (stateInput && stateInput.style.display === 'block') {
	
					if (stateSelectError) stateSelectError.style.display = 'none';
					
					if (stateInput.value.trim() === '') {
						if (stateInputError) stateInputError.innerHTML = 'State is required1';
					}
				// } else if (stateSelect && stateSelect.style.display === 'block') {
					} else if (stateSelect) {
					console.log('555');
					// Hide the state input error
					if (stateInputError) stateInputError.style.display = 'none';
					
					if (stateSelect.value.trim() === '') {
						if (stateSelectError) stateSelectError.innerHTML = 'State is required2';
					}
				}
			});
		}
	});



</script>
