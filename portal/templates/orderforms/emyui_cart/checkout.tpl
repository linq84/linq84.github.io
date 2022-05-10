<script>
    // Define state tab index value
    var statesTab = 10;
    // Do not enforce state input client side
    var stateNotRequired = true;
</script>
{include file="orderforms/standard_cart/common.tpl"}
<script type="text/javascript" src="{$BASE_PATH_JS}/StatesDropdown.js"></script>
<script type="text/javascript" src="{$BASE_PATH_JS}/PasswordStrength.js"></script>
<script>
    window.langPasswordStrength = "{$LANG.pwstrength}";
    window.langPasswordWeak = "{$LANG.pwstrengthweak}";
    window.langPasswordModerate = "{$LANG.pwstrengthmoderate}";
    window.langPasswordStrong = "{$LANG.pwstrengthstrong}";
</script>

<div id="order-standard_cart">

<div class="row justify-content-center mb-10 px-5 mt-5">
	<div class="orderform-step-form-wizard-group col-12 d-flex white-bg justify-content-center border-opacity rounded-20 overflow-hidden">
	
	<a href="#" class="orderform-step-form-wizard-item d-flex align-items-center position-relative pl-6 pr-10 py-7 mr-12 active">
	<i class="feather icon-globe"></i>
	<span class="coodiv-text-11 font-weight-bold color-blackish-blue"><small class="d-block font-weight-light mb-n2 color-blackish-blue-opacity">step 1/3</small>{$LANG.cartproductconfig}</span>
	<div class="left-triangle-border"></div>
	</a>
	
	<a href="#" class="orderform-step-form-wizard-item d-flex align-items-center position-relative pl-6 pr-10 py-7 mr-12 active">
	<i class="feather icon-file-text"></i>
	<span class="coodiv-text-11 font-weight-bold color-blackish-blue"><small class="d-block font-weight-light mb-n2 color-blackish-blue-opacity">step 2/3</small>{$LANG.cartreviewcheckout}</span>
	<div class="left-triangle-border"></div>
	</a>
	
	<a href="#" class="orderform-step-form-wizard-item d-flex align-items-center position-relative pl-6 pr-10 py-7 active">
	<i class="feather icon-check"></i>
	<span class="coodiv-text-11 font-weight-bold color-blackish-blue"><small class="d-block font-weight-light mb-n2 color-blackish-blue-opacity">step 3/3</small>{$LANG.store.addon.wptk.proceedToCheckout}</span>
	<div class="left-triangle-border"></div>
	</a>
	
	</div>
	</div>
	
	<div  class="white-bg border-opacity rounded-20 pb-15">
    <div class="row justify-content-center mt-15 mb-10">
                        <div class="col-md-9 col-lg-9">
                            <div class="hero-content dark-mode-texts mb-15 mb-lg-5 text-center pt-0 position-relative coodiv-z-index-1">
                                <h4 class="pre-title text-green coodiv-text-12 text-uppercase mb-3">{$LANG.cartreviewcheckout}</h4>
                                <h1 class="coodiv-text-6 mb-2 color-blackish-blue">
								{$LANG.orderForm.checkout}
								</h1>
                                <p class="coodiv-text-9 px-7 mb-0 color-blackish-blue-opacity">
								{lang key='orderForm.enterPersonalDetails'}
                                </p>
								
								<div class="already-registered clearfix mt-6">
                    			<button type="button" class="btn coodiv-text-11 rounded-20 py-2 mx-0 btn-primary{if $loggedin || !$loggedin && $custtype eq "existing"} w-hidden{/if}" id="btnAlreadyRegistered">
                        			{$LANG.orderForm.alreadyRegistered}
                    			</button>
                    			<button type="button" class="btn coodiv-text-11 rounded-20 py-2 mx-0 btn-warning{if $loggedin || $custtype neq "existing"} w-hidden{/if}" id="btnNewUserSignup">
                        			{$LANG.orderForm.createAccount}
                    			</button>
            			        </div>
			
			
                            </div>
                        </div>
    </div>

    <div class="row justify-content-center">
        <div class="col-11">
		
            {if $errormessage}
                <div class="alert alert-danger checkout-error-feedback mb-14" role="alert">
                    <p>{$LANG.orderForm.correctErrors}:</p>
                    <ul>
                        {$errormessage}
                    </ul>
                </div>
                <div class="clearfix"></div>
            {/if}

            <form method="post" action="{$smarty.server.PHP_SELF}?a=checkout" name="orderfrm" id="frmCheckout">
                <input type="hidden" name="submit" value="true" />
                <input type="hidden" name="custtype" id="inputCustType" value="{$custtype}" />

                {if $custtype neq "new" && $loggedin}
				<div class="register-area-box-checkout position-relative">
                    <span class="register-area-box-checkout-title">{lang key='switchAccount.title'}</span>
                 
                    <div id="containerExistingAccountSelect" class="row account-select-container">
                        {foreach $accounts as $account}
                            <div class="col-sm-{if $accounts->count() == 1}12{else}6{/if}">
                                <div class="account{if $selectedAccountId == $account->id} active{/if}">
                                    <label class="radio-inline" for="account{$account->id}">
                                        <input id="account{$account->id}" class="account-select{if $account->isClosed || $account->noPermission || $inExpressCheckout} disabled{/if}" type="radio" name="account_id" value="{$account->id}"{if $account->isClosed || $account->noPermission || $inExpressCheckout} disabled="disabled"{/if}{if $selectedAccountId == $account->id} checked="checked"{/if}>
                                        <span class="address">
                                            <strong>
                                                {if $account->company}{$account->company}{else}{$account->fullName}{/if}
                                            </strong>
                                            {if $account->isClosed || $account->noPermission}
                                                <span class="label label-default">
                                                    {if $account->isClosed}
                                                        {lang key='closed'}
                                                    {else}
                                                        {lang key='noPermission'}
                                                    {/if}
                                                </span>
                                            {elseif $account->currencyCode}
                                                <span class="label label-info">
                                                    {$account->currencyCode}
                                                </span>
                                            {/if}
                                            <br>
                                            <span class="small">
                                                {$account->address1}{if $account->address2}, {$account->address2}{/if}<br>
                                                {if $account->city}{$account->city},{/if}
                                                {if $account->state} {$account->state},{/if}
                                                {if $account->postcode} {$account->postcode},{/if}
                                                {$account->countryName}
                                            </span>
                                        </span>
                                    </label>
                                </div>
                            </div>
                        {/foreach}
                        <div class="col-sm-12">
                            <div class="account border-bottom{if !$selectedAccountId || !is_numeric($selectedAccountId)} active{/if}">
                                <label class="radio-inline">
                                    <input class="account-select" type="radio" name="account_id" value="new"{if !$selectedAccountId || !is_numeric($selectedAccountId)} checked="checked"{/if}{if $inExpressCheckout} disabled="disabled" class="disabled"{/if}>
                                    {lang key='orderForm.createAccount'}
                                </label>
                            </div>
                        </div>
                    </div>
				</div>
                {/if}

                <div class="register-area-box-checkout position-relative {if $loggedin || $custtype neq "existing"} w-hidden{/if}" id="containerExistingUserSignin">
				

                    <span class="register-area-box-checkout-title">{$LANG.orderForm.existingCustomerLogin}</span>

                    <div class="alert alert-danger w-hidden" id="existingLoginMessage">
                    </div>

                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group prepend-icon">
                                <label for="inputLoginEmail" class="field-icon">
                                    <i class="fas fa-envelope"></i>
                                </label>
                                <input type="text" name="loginemail" id="inputLoginEmail" class="field form-control" placeholder="{$LANG.orderForm.emailAddress}" value="{$loginemail}">
                            </div>
                        </div>
                        <div class="col-sm-4 pl-0">
                            <div class="form-group prepend-icon">
                                <label for="inputLoginPassword" class="field-icon">
                                    <i class="fas fa-lock"></i>
                                </label>
                                <input type="password" name="loginpassword" id="inputLoginPassword" class="field form-control" placeholder="{$LANG.clientareapassword}">
                            </div>
                        </div>
						
						<div class="col-sm-2 px-0">
                        <button style="display: block;width: 100%;min-width: auto;" type="button" id="btnExistingLogin" class="btn coodiv-text-10 btn-primary btn-md py-2 rounded-20">
                            <span id="existingLoginButton">{lang key='login'}</span>
                            <span id="existingLoginPleaseWait" class="w-hidden">{lang key='pleasewait'}</span>
                        </button>
                        </div>
                    </div>

                    

                    {include file="orderforms/standard_cart/linkedaccounts.tpl" linkContext="checkout-existing"}
                </div>

                <div id="containerNewUserSignup"{if $custtype === 'existing' || (is_numeric($selectedAccountId) && $selectedAccountId > 0) || ($loggedin && $accounts->count() > 0 && $selectedAccountId !== 'new')} class="w-hidden"{/if}>

                    <div{if $loggedin} class="w-hidden"{/if}>
                        {include file="orderforms/standard_cart/linkedaccounts.tpl" linkContext="checkout-new"}
                    </div>
					
					<div class="register-area-box-checkout position-relative">

                    <span class="register-area-box-checkout-title">{$LANG.orderForm.personalInformation}</span>
                    

                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group prepend-icon">
                                <label for="inputFirstName" class="field-icon">
                                    <i class="fas fa-user"></i>
                                </label>
                                <input type="text" name="firstname" id="inputFirstName" class="field form-control" placeholder="{$LANG.orderForm.firstName}" value="{$clientsdetails.firstname}" autofocus>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group prepend-icon">
                                <label for="inputLastName" class="field-icon">
                                    <i class="fas fa-user"></i>
                                </label>
                                <input type="text" name="lastname" id="inputLastName" class="field form-control" placeholder="{$LANG.orderForm.lastName}" value="{$clientsdetails.lastname}">
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group prepend-icon">
                                <label for="inputEmail" class="field-icon">
                                    <i class="fas fa-envelope"></i>
                                </label>
                                <input type="email" name="email" id="inputEmail" class="field form-control" placeholder="{$LANG.orderForm.emailAddress}" value="{$clientsdetails.email}">
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group prepend-icon">
                                <label for="inputPhone" class="field-icon">
                                    <i class="fas fa-phone"></i>
                                </label>
                                <input type="tel" name="phonenumber" id="inputPhone" class="field form-control" placeholder="{$LANG.orderForm.phoneNumber}" value="{$clientsdetails.phonenumber}">
                            </div>
                        </div>
                    </div>
					</div>
					
					<div class="register-area-box-checkout position-relative">

                    <span class="register-area-box-checkout-title">{$LANG.orderForm.billingAddress}</span>


                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group prepend-icon">
                                <label for="inputCompanyName" class="field-icon">
                                    <i class="fas fa-building"></i>
                                </label>
                                <input type="text" name="companyname" id="inputCompanyName" class="field form-control" placeholder="{$LANG.orderForm.companyName} ({$LANG.orderForm.optional})" value="{$clientsdetails.companyname}">
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="form-group prepend-icon">
                                <label for="inputAddress1" class="field-icon">
                                    <i class="far fa-building"></i>
                                </label>
                                <input type="text" name="address1" id="inputAddress1" class="field form-control" placeholder="{$LANG.orderForm.streetAddress}" value="{$clientsdetails.address1}">
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="form-group prepend-icon">
                                <label for="inputAddress2" class="field-icon">
                                    <i class="fas fa-map-marker-alt"></i>
                                </label>
                                <input type="text" name="address2" id="inputAddress2" class="field form-control" placeholder="{$LANG.orderForm.streetAddress2}" value="{$clientsdetails.address2}">
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="form-group prepend-icon">
                                <label for="inputCity" class="field-icon">
                                    <i class="far fa-building"></i>
                                </label>
                                <input type="text" name="city" id="inputCity" class="field form-control" placeholder="{$LANG.orderForm.city}" value="{$clientsdetails.city}">
                            </div>
                        </div>
                        <div class="col-sm-5">
                            <div class="form-group prepend-icon">
                                <label for="state" class="field-icon" id="inputStateIcon">
                                    <i class="fas fa-map-signs"></i>
                                </label>
                                <label for="stateinput" class="field-icon" id="inputStateIcon">
                                    <i class="fas fa-map-signs"></i>
                                </label>
                                <input type="text" name="state" id="inputState" class="field form-control" placeholder="{$LANG.orderForm.state}" value="{$clientsdetails.state}">
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group prepend-icon">
                                <label for="inputPostcode" class="field-icon">
                                    <i class="fas fa-certificate"></i>
                                </label>
                                <input type="text" name="postcode" id="inputPostcode" class="field form-control" placeholder="{$LANG.orderForm.postcode}" value="{$clientsdetails.postcode}">
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="form-group prepend-icon">
                                <label for="inputCountry" class="field-icon" id="inputCountryIcon">
                                    <i class="fas fa-globe"></i>
                                </label>
                                <select name="country" id="inputCountry" class="field form-control">
                                    {foreach $countries as $countrycode => $countrylabel}
                                        <option value="{$countrycode}"{if (!$country && $countrycode == $defaultcountry) || $countrycode eq $country} selected{/if}>
                                            {$countrylabel}
                                        </option>
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                        {if $showTaxIdField}
                            <div class="col-sm-12">
                                <div class="form-group prepend-icon">
                                    <label for="inputTaxId" class="field-icon">
                                        <i class="fas fa-building"></i>
                                    </label>
                                    <input type="text" name="tax_id" id="inputTaxId" class="field form-control" placeholder="{$taxLabel} ({$LANG.orderForm.optional})" value="{$clientsdetails.tax_id}">
                                </div>
                            </div>
                        {/if}
                    </div>
					</div>

                    {if $customfields}
					
					<div class="register-area-box-checkout position-relative">

                    <span class="register-area-box-checkout-title">{$LANG.orderadditionalrequiredinfo}</span>
                        <p class="coodiv-text-10 text-center">{lang key='orderForm.requiredField'}</p>
                        
                        <div class="field-container">
                            <div class="row">
                                {foreach $customfields as $customfield}
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="customfield{$customfield.id}">{$customfield.name} {$customfield.required}</label>
                                            {$customfield.input}
                                            {if $customfield.description}
                                                <span class="field-help-text">
                                                    {$customfield.description}
                                                </span>
                                            {/if}
                                        </div>
                                    </div>
                                {/foreach}
                            </div>
                        </div>
						</div>
                    {/if}

                </div>

                {if $domainsinorder}
				
				    <div class="register-area-box-checkout position-relative">

                    <span class="register-area-box-checkout-title">{$LANG.domainregistrantinfo}</span>

              
                    <p class="coodiv-text-11 text-muted">{$LANG.orderForm.domainAlternativeContact}</p>

                    <div class="row margin-bottom">
                        <div class="col-sm-6 col-sm-offset-3 offset-sm-3">
                            <select name="contact" id="inputDomainContact" class="field form-control">
                                <option value="">{$LANG.usedefaultcontact}</option>
                                {foreach $domaincontacts as $domcontact}
                                    <option value="{$domcontact.id}"{if $contact == $domcontact.id} selected{/if}>
                                        {$domcontact.name}
                                    </option>
                                {/foreach}
                                <option value="addingnew"{if $contact == "addingnew"} selected{/if}>
                                    {$LANG.clientareanavaddcontact}...
                                </option>
                            </select>
                        </div>
                    </div>

                    <div{if $contact neq "addingnew"} class="w-hidden"{/if}>
                        <div class="row" id="domainRegistrantInputFields">
                            <div class="col-sm-6">
                                <div class="form-group prepend-icon">
                                    <label for="inputDCFirstName" class="field-icon">
                                        <i class="fas fa-user"></i>
                                    </label>
                                    <input type="text" name="domaincontactfirstname" id="inputDCFirstName" class="field form-control" placeholder="{$LANG.orderForm.firstName}" value="{$domaincontact.firstname}">
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group prepend-icon">
                                    <label for="inputDCLastName" class="field-icon">
                                        <i class="fas fa-user"></i>
                                    </label>
                                    <input type="text" name="domaincontactlastname" id="inputDCLastName" class="field form-control" placeholder="{$LANG.orderForm.lastName}" value="{$domaincontact.lastname}">
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group prepend-icon">
                                    <label for="inputDCEmail" class="field-icon">
                                        <i class="fas fa-envelope"></i>
                                    </label>
                                    <input type="email" name="domaincontactemail" id="inputDCEmail" class="field form-control" placeholder="{$LANG.orderForm.emailAddress}" value="{$domaincontact.email}">
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group prepend-icon">
                                    <label for="inputDCPhone" class="field-icon">
                                        <i class="fas fa-phone"></i>
                                    </label>
                                    <input type="tel" name="domaincontactphonenumber" id="inputDCPhone" class="field form-control" placeholder="{$LANG.orderForm.phoneNumber}" value="{$domaincontact.phonenumber}">
                                </div>
                            </div>
                            <div class="col-sm-12">
                                <div class="form-group prepend-icon">
                                    <label for="inputDCCompanyName" class="field-icon">
                                        <i class="fas fa-building"></i>
                                    </label>
                                    <input type="text" name="domaincontactcompanyname" id="inputDCCompanyName" class="field form-control" placeholder="{$LANG.orderForm.companyName} ({$LANG.orderForm.optional})" value="{$domaincontact.companyname}">
                                </div>
                            </div>
                            <div class="col-sm-12">
                                <div class="form-group prepend-icon">
                                    <label for="inputDCAddress1" class="field-icon">
                                        <i class="far fa-building"></i>
                                    </label>
                                    <input type="text" name="domaincontactaddress1" id="inputDCAddress1" class="field form-control" placeholder="{$LANG.orderForm.streetAddress}" value="{$domaincontact.address1}">
                                </div>
                            </div>
                            <div class="col-sm-12">
                                <div class="form-group prepend-icon">
                                    <label for="inputDCAddress2" class="field-icon">
                                        <i class="fas fa-map-marker-alt"></i>
                                    </label>
                                    <input type="text" name="domaincontactaddress2" id="inputDCAddress2" class="field form-control" placeholder="{$LANG.orderForm.streetAddress2}" value="{$domaincontact.address2}">
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="form-group prepend-icon">
                                    <label for="inputDCCity" class="field-icon">
                                        <i class="far fa-building"></i>
                                    </label>
                                    <input type="text" name="domaincontactcity" id="inputDCCity" class="field form-control" placeholder="{$LANG.orderForm.city}" value="{$domaincontact.city}">
                                </div>
                            </div>
                            <div class="col-sm-5">
                                <div class="form-group prepend-icon">
                                    <label for="inputDCState" class="field-icon">
                                        <i class="fas fa-map-signs"></i>
                                    </label>
                                    <input type="text" name="domaincontactstate" id="inputDCState" class="field form-control" placeholder="{$LANG.orderForm.state}" value="{$domaincontact.state}">
                                </div>
                            </div>
                            <div class="col-sm-3">
                                <div class="form-group prepend-icon">
                                    <label for="inputDCPostcode" class="field-icon">
                                        <i class="fas fa-certificate"></i>
                                    </label>
                                    <input type="text" name="domaincontactpostcode" id="inputDCPostcode" class="field form-control" placeholder="{$LANG.orderForm.postcode}" value="{$domaincontact.postcode}">
                                </div>
                            </div>
                            <div class="col-sm-12">
                                <div class="form-group prepend-icon">
                                    <label for="inputDCCountry" class="field-icon" id="inputCountryIcon">
                                        <i class="fas fa-globe"></i>
                                    </label>
                                    <select name="domaincontactcountry" id="inputDCCountry" class="field form-control">
                                        {foreach $countries as $countrycode => $countrylabel}
                                            <option value="{$countrycode}"{if (!$domaincontact.country && $countrycode == $defaultcountry) || $countrycode eq $domaincontact.country} selected{/if}>
                                                {$countrylabel}
                                            </option>
                                        {/foreach}
                                    </select>
                                </div>
                            </div>
                            <div class="col-sm-12">
                                <div class="form-group prepend-icon">
                                    <label for="inputDCTaxId" class="field-icon">
                                        <i class="fas fa-building"></i>
                                    </label>
                                    <input type="text" name="domaincontacttax_id" id="inputDCTaxId" class="field form-control" placeholder="{$taxLabel} ({$LANG.orderForm.optional})" value="{$domaincontact.tax_id}">
                                </div>
                            </div>
                        </div>
                    </div>
				</div>

                {/if}

                {if !$loggedin}
				 

                    <div class="register-area-box-checkout position-relative {if (!$loggedin && $custtype eq "existing") || ($remote_auth_prelinked && !$securityquestions)} w-hidden{/if}" id="containerNewUserSecurity">
						
						<span class="register-area-box-checkout-title">{$LANG.orderForm.accountSecurity}</span>

                        <div id="containerPassword" class="row{if $remote_auth_prelinked && $securityquestions} w-hidden{/if}">
                            <div id="passwdFeedback" class="alert alert-info text-center col-sm-12 w-hidden"></div>
                            <div class="col-sm-6">
                                <div class="form-group prepend-icon position-relative">
                                    <label for="inputNewPassword1" class="field-icon">
                                        <i class="fas fa-lock"></i>
                                    </label>
                                    <input type="password" name="password" id="inputNewPassword1" data-error-threshold="{$pwStrengthErrorThreshold}" data-warning-threshold="{$pwStrengthWarningThreshold}" class="field form-control" placeholder="{$LANG.clientareapassword}"{if $remote_auth_prelinked} value="{$password}"{/if}>
                                    <button type="button" class="generate-password button-input-generate" data-targetfields="inputNewPassword1,inputNewPassword2">
                                    <i class="feather icon-lock"></i>
                                    </button>
								</div>
                            </div>
                            <div class="col-sm-6">
                                <div class="form-group prepend-icon">
                                    <label for="inputNewPassword2" class="field-icon">
                                        <i class="fas fa-lock"></i>
                                    </label>
                                    <input type="password" name="password2" id="inputNewPassword2" class="field form-control" placeholder="{$LANG.clientareaconfirmpassword}"{if $remote_auth_prelinked} value="{$password}"{/if}>
                                </div>
                            </div>
                            
                            <div class="col-sm-6">
                                <div class="password-strength-meter">
                                    <div class="progress">
                                        <div class="progress-bar progress-bar-success progress-bar-striped" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" id="passwordStrengthMeterBar">
                                        </div>
                                    </div>
                                    <p class="text-center small text-muted" id="passwordStrengthTextLabel">{$LANG.pwstrength}: {$LANG.pwstrengthenter}</p>
                                </div>
                            </div>
                        </div>
                        {if $securityquestions}
                            <div class="row">
                                <div class="col-sm-6">
                                    <select name="securityqid" id="inputSecurityQId" class="field form-control">
                                        <option value="">{$LANG.clientareasecurityquestion}</option>
                                        {foreach $securityquestions as $question}
                                            <option value="{$question.id}"{if $question.id eq $securityqid} selected{/if}>
                                                {$question.question}
                                            </option>
                                        {/foreach}
                                    </select>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group prepend-icon">
                                        <label for="inputSecurityQAns" class="field-icon">
                                            <i class="fas fa-lock"></i>
                                        </label>
                                        <input type="password" name="securityqans" id="inputSecurityQAns" class="field form-control" placeholder="{$LANG.clientareasecurityanswer}">
                                    </div>
                                </div>
                            </div>
                        {/if}

                    </div>

                {/if}

                {foreach $hookOutput as $output}
                    <div class="register-area-box-checkout position-relative">
					{$output}
                    </div>
                {/foreach}
				
				
                <div class="register-area-box-checkout position-relative">
				
				<span class="register-area-box-checkout-title">{$LANG.orderForm.paymentDetails}</span>
				
             
                <div class="alert alert-success text-center large-text" role="alert" id="totalDueToday">
                    {$LANG.ordertotalduetoday}: &nbsp; <strong id="totalCartPrice">{$total}</strong>
                </div>

                <div id="applyCreditContainer" class="apply-credit-container{if !$canUseCreditOnCheckout} w-hidden{/if}" data-apply-credit="{$applyCredit}">
                    <p>{lang key='cart.availableCreditBalance' amount=$creditBalance}</p>

                    <label class="radio">
                        <input id="useCreditOnCheckout" type="radio" name="applycredit" value="1"{if $applyCredit} checked{/if}>
                        <span id="spanFullCredit"{if !($creditBalance->toNumeric() >= $total->toNumeric())} class="w-hidden"{/if}>
                            {lang key='cart.applyCreditAmountNoFurtherPayment' amount=$total}
                        </span>
                        <span id="spanUseCredit"{if $creditBalance->toNumeric() >= $total->toNumeric()} class="w-hidden"{/if}>
                            {lang key='cart.applyCreditAmount' amount=$creditBalance}
                        </span>
                    </label>
                    <label class="radio">
                        <input id="skipCreditOnCheckout" type="radio" name="applycredit" value="0"{if !$applyCredit} checked{/if}>
                        {lang key='cart.applyCreditSkip' amount=$creditBalance}
                    </label>
                </div>

                {if !$inExpressCheckout}
                    <div id="paymentGatewaysContainer" class="form-group">
                        <p class="small text-muted">{$LANG.orderForm.preferredPaymentMethod}</p>

                        <div class="text-left payment-gateways-container">
                            {foreach $gateways as $gateway}
                                <label class="radio-inline">
                                    <input type="radio"
                                           name="paymentmethod"
                                           value="{$gateway.sysname}"
                                           data-payment-type="{$gateway.payment_type}"
                                           data-show-local="{$gateway.show_local_cards}"
                                           data-remote-inputs="{$gateway.uses_remote_inputs}"
                                           class="payment-methods{if $gateway.type eq "CC"} is-credit-card{/if}"
                                            {if $selectedgateway eq $gateway.sysname} checked{/if}
                                    />
                                    {$gateway.name}
                                </label>
                            {/foreach}
                        </div>
                    </div>

                    <div class="alert alert-danger text-center gateway-errors w-hidden"></div>

                    <div class="clearfix"></div>

                    <div class="cc-input-container{if $selectedgatewaytype neq "CC"} w-hidden{/if}" id="creditCardInputFields">
                        {if $client}
                            <div id="existingCardsContainer" class="existing-cc-grid">
                                {include file="orderforms/standard_cart/includes/existing-paymethods.tpl"}
                            </div>
                        {/if}
                        <div class="row cvv-input" id="existingCardInfo">
                            <div class="col-lg-3 col-sm-4">
                                <div class="form-group prepend-icon">
                                    <label for="inputCardCVV2" class="field-icon">
                                        <i class="fas fa-barcode"></i>
                                    </label>
                                    <div class="input-group">
                                        <input type="tel" name="cccvv" id="inputCardCVV2" class="field form-control" placeholder="{$LANG.creditcardcvvnumbershort}" autocomplete="cc-cvc">
                                        <span class="input-group-btn input-group-append">
                                            <button type="button" class="btn btn-default" data-toggle="popover" data-placement="bottom" data-content="<img src='{$BASE_PATH_IMG}/ccv.gif' width='210' />">
                                                ?
                                            </button>
                                        </span>
                                    </div>
                                    <span class="field-error-msg">{lang key="paymentMethodsManage.cvcNumberNotValid"}</span>
                                </div>
                            </div>
                        </div>

                        <ul>
                            <li>
                                <label class="radio-inline">
                                    <input type="radio" name="ccinfo" value="new" id="new" {if !$client || $client->payMethods->count() === 0} checked="checked"{/if} />
                                    &nbsp;
                                    {lang key='creditcardenternewcard'}
                                </label>
                            </li>
                        </ul>

                        <div class="row" id="newCardInfo">
                            <div id="cardNumberContainer" class="col-sm-6 new-card-container">
                                <div class="form-group prepend-icon">
                                    <label for="inputCardNumber" class="field-icon">
                                        <i class="fas fa-credit-card"></i>
                                    </label>
                                    <input type="tel" name="ccnumber" id="inputCardNumber" class="field form-control cc-number-field" placeholder="{$LANG.orderForm.cardNumber}" autocomplete="cc-number" data-message-unsupported="{lang key='paymentMethodsManage.unsupportedCardType'}" data-message-invalid="{lang key='paymentMethodsManage.cardNumberNotValid'}" data-supported-cards="{$supportedCardTypes}" />
                                    <span class="field-error-msg"></span>
                                </div>
                            </div>
                            <div class="col-sm-3 new-card-container">
                                <div class="form-group prepend-icon">
                                    <label for="inputCardExpiry" class="field-icon">
                                        <i class="fas fa-calendar-alt"></i>
                                    </label>
                                    <input type="tel" name="ccexpirydate" id="inputCardExpiry" class="field form-control" placeholder="MM / YY{if $showccissuestart} ({$LANG.creditcardcardexpires}){/if}" autocomplete="cc-exp">
                                    <span class="field-error-msg">{lang key="paymentMethodsManage.expiryDateNotValid"}</span>
                                </div>
                            </div>
                            <div class="col-sm-3" id="cvv-field-container">
                                <div class="form-group prepend-icon">
                                    <label for="inputCardCVV" class="field-icon">
                                        <i class="fas fa-barcode"></i>
                                    </label>
                                    <div class="input-group position-relative">
                                        <input type="tel" name="cccvv" id="inputCardCVV" class="field form-control" placeholder="{$LANG.creditcardcvvnumbershort}" autocomplete="cc-cvc">
                                        <button type="button" class="inputcardcvv-button" data-toggle="popover" data-placement="bottom" data-content="<img src='{$BASE_PATH_IMG}/ccv.gif' width='210' />">
                                         ?
                                        </button>
                                         
                                    </div>
                                    <span class="field-error-msg">{lang key="paymentMethodsManage.cvcNumberNotValid"}</span>
                                </div>
                            </div>
                            {if $showccissuestart}
                                <div class="col-sm-3 col-sm-offset-6 new-card-container offset-sm-6">
                                    <div class="form-group prepend-icon">
                                        <label for="inputCardStart" class="field-icon">
                                            <i class="far fa-calendar-check"></i>
                                        </label>
                                        <input type="tel" name="ccstartdate" id="inputCardStart" class="field form-control" placeholder="MM / YY ({$LANG.creditcardcardstart})" autocomplete="cc-exp">
                                    </div>
                                </div>
                                <div class="col-sm-3 new-card-container">
                                    <div class="form-group prepend-icon">
                                        <label for="inputCardIssue" class="field-icon">
                                            <i class="fas fa-asterisk"></i>
                                        </label>
                                        <input type="tel" name="ccissuenum" id="inputCardIssue" class="field form-control" placeholder="{$LANG.creditcardcardissuenum}">
                                    </div>
                                </div>
                            {/if}
                        </div>
                        <div id="newCardSaveSettings">
                            <div class="row form-group new-card-container">
                                <div id="inputDescriptionContainer" class="col-md-6">
                                    <div class="prepend-icon">
                                        <label for="inputDescription" class="field-icon">
                                            <i class="fas fa-pencil"></i>
                                        </label>
                                        <input type="text" class="field form-control" id="inputDescription" name="ccdescription" autocomplete="off" value="" placeholder="{$LANG.paymentMethods.descriptionInput} {$LANG.paymentMethodsManage.optional}" />
                                    </div>
                                </div>
                                {if $allowClientsToRemoveCards}
                                    <div id="inputNoStoreContainer" class="col-md-6" style="line-height: 32px;">
                                        <input type="hidden" name="nostore" value="1">
                                        <input type="checkbox" class="toggle-switch-success no-icheck" data-size="mini" checked="checked" name="nostore" id="inputNoStore" value="0" data-on-text="{lang key='yes'}" data-off-text="{lang key='no'}">
                                        <label for="inputNoStore" class="checkbox-inline no-padding">
                                            &nbsp;&nbsp;
                                            {$LANG.creditCardStore}
                                        </label>
                                    </div>
                                {/if}
                            </div>
                        </div>
                    </div>
                {else}
                    {if $expressCheckoutOutput}
                        {$expressCheckoutOutput}
                    {else}
                        <p align="center">
                            {lang key='paymentPreApproved' gateway=$expressCheckoutGateway}
                        </p>
                    {/if}
                {/if}

                {if $shownotesfield}
			</div>
                 
				 
				 
				 <div class="register-area-box-checkout position-relative">
				
				    <span class="register-area-box-checkout-title">{$LANG.orderForm.additionalNotes}</span>
                    

                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <textarea style="min-height:120px" name="notes" class="field form-control" rows="4" placeholder="{$LANG.ordernotesdescription}">{$orderNotes}</textarea>
                            </div>
                        </div>
                    </div>
					</div>

                {/if}

                {if $showMarketingEmailOptIn}

                    <div class="marketing-email-optin register-area-box-checkout position-relative">
					<span class="register-area-box-checkout-title">{lang key='emailMarketing.joinOurMailingList'}</span>
                    <p class="coodiv-text-10">{$marketingEmailOptInMessage}</p>
                    <input type="checkbox" name="marketingoptin" value="1"{if $marketingEmailOptIn} checked{/if} class="no-icheck toggle-switch-success" data-size="small" data-on-text="{lang key='yes'}" data-off-text="{lang key='no'}">
                    </div>
                {/if}

                <div class="text-center">
                    {if $accepttos}
                        <p>
                            <label class="checkbox-inline">
                                <input type="checkbox" name="accepttos" id="accepttos" />
                                &nbsp;
                                {$LANG.ordertosagreement}
                                <a href="{$tosurl}" target="_blank">{$LANG.ordertos}</a>
                            </label>
                        </p>
                    {/if}
                    {if $captcha}
                        <div class="text-center margin-bottom">
                            {include file="$template/includes/captcha.tpl"}
                        </div>
                    {/if}

                    <button type="submit"
                            id="btnCompleteOrder"
                            class="btn btn-primary rounded-20 coodiv-text-10 btn-lg disable-on-click spinner-on-click{if $captcha}{$captcha->getButtonClass($captchaForm)}{/if}"
                            {if $cartitems==0}disabled="disabled"{/if}
                    >
                        {if $inExpressCheckout}{$LANG.confirmAndPay}{else}{$LANG.completeorder}{/if}
                       
                    </button>
                </div>
            </form>

            {if $servedOverSsl}
                <div class="alert alert-warning checkout-security-msg">
                    <i class="fas fa-lock"></i>
                    {$LANG.ordersecure} (<strong>{$ipaddress}</strong>) {$LANG.ordersecure2}
                    <div class="clearfix"></div>
                </div>
            {/if}
        </div>
    </div>
</div>

<script type="text/javascript" src="{$BASE_PATH_JS}/jquery.payment.js"></script>
<script>
    var hideCvcOnCheckoutForExistingCard = '{if $canUseCreditOnCheckout && $applyCredit && ($creditBalance->toNumeric() >= $total->toNumeric())}1{else}0{/if}';
</script>
