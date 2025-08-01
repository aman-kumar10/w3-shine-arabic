

<div class="providerLinkingFeedback"></div>
        
<!--banner-->
<section class="page-title login-banner">
    <div class="container">
        <div class="title-text text-11">
            <h1>{$LANG.loginTitle}</h1>
        </div>
    </div>
</section>
<!--end banner-->
        

<div class="inner-cnt">
    <div class="container">

        <div class="row">
            <div class="col-md-6 d-flex justify-content-start">
                <div class="login col-12 col-sm-12 col-md-10 col-lg-10 mb-5">
                    <h3>{$LANG.loginCustomerLogin}</h3>
                    <h6 class="mb-3">{$LANG.loginHaveAccount}</h6>
                    
                    <form method="post" action="{routePath('login-validate')}" class="login-form" role="form">

                        {include file="$template/includes/flashmessage.tpl"}
                        <div class="row">
                            <div class="col-md-12">
                                <input type="email" class="form-control" name="username" id="inputEmail" placeholder="name@example.com" autofocus>
                            </div>
                            <div class="col-md-12">
                                <input type="password" class="form-control pw-input" name="password" id="inputPassword" placeholder="{lang key='clientareapassword'}" autocomplete="off">
                                <!-- <div class="input-group-append">
                                    <button class="btn btn-default btn-reveal-pw" type="button" tabindex="-1">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </div> -->
                            </div>

                            <div class="row form-group">
                                <div class="col-md-12">
                                    <label class="font-weight-bold" for="email2" ><span style="font-weight:bold;">OTP</span> {$LANG.loginHaveMandatory}</label><br />
                                    {if $emailotp=='on'}
                                        <span class="chk font-weight-normal"><input id="ctl00_ContentPlaceHolder1_rdEmail" type="radio" name="ctl00$ContentPlaceHolder1$otp" value="rdEmail" checked="checked" class='otpsend' /><label for="ctl00_ContentPlaceHolder1_rdEmail">{$LANG.loginEmail}</label></span>
                                    {/if}
                                    {if $phoneotp=='on'}
                                        <span disabled="disabled" class="chk font-weight-normal"><input id="ctl00_ContentPlaceHolder1_rdPhone" type="radio" name="ctl00$ContentPlaceHolder1$otp" value="rdPhone" class='otpsend'  /><label for="ctl00_ContentPlaceHolder1_rdPhone">{$LANG.loginPhone}</label></span>
                                    {/if} 
                                </div>
                            </div>


                            {if $captcha->isEnabled()}
                                {include file="$template/includes/captcha.tpl"}
                            {/if}

                            <div class="row form-group">
                                <div class="col-md-12">
                                    <label>
                                        <input type="checkbox" class="form-check-input" name="rememberme" />
                                        {lang key='loginrememberme'}
                                    </label>
                                </div>
                            </div>

                            <div class="col-md-12 contact_button login-box">
                                <button id="login" type="submit" class="btn btn-sea-blue btn-primary{$captcha->getButtonClass($captchaForm)}">
                                    {lang key='loginbutton'}
                                </button>
                            </div>

                        </div>

                    </form>

                    <div class="link-st"><a href="{routePath('password-reset-begin')}">{$LANG.loginForgotPwd}</a></div>
                </div>

                {include file="$template/includes/linkedaccounts.tpl" linkContext="login" customFeedback=true}
            </div>

            <div class="col-md-6 center-align h-100 d-flex justify-content-end">
                <div class="login_right p-5 col-12 col-sm-12 col-md-10 col-lg-10 text-center">
                    <h3>{$LANG.loginNewCustomer}</h3>
                    <h6 class="my-5">{$LANG.loginNewRegister}</h6>
                    <a href="{$WEB_ROOT}/register.php" class="btn btn-white-color">{$LANG.loginNewCreate} </a>
                </div>
            </div>

        </div>
    </div>
</div>

<script>
    document.cookie = "sendotp=rdEmail;path=/;";
    $(document).ready(function(){
        $('.otpsend').click(function(){
            document.cookie = "sendotp="+$(this).val()+";path=/;";
        });
    });
</script>