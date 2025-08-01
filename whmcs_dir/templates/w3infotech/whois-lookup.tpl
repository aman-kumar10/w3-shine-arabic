<!-- 
  <div class="inner-banner whois-lookup-sec">
        <div class="whois">
            <div class="container">
                <h1>{$LANG.whoisCheck}</h1>
                <div class="site-pagination">
                    <a href="{$WEB_ROOT}/index.php"><i class="fa fa-home" aria-hidden="true"></i>{$LANG.whoisHome}</a> -<i class="fa fa-arrow-circle-o-right" aria-hidden="true"></i>{$LANG.whoisLookup}
                </div>
            </div>
        </div>
    </div> -->
    <!--end banner-->

<section class="page-title whois-lookup-sec" >
    <div class="container">
        <div class="whois">
        <h1>{$LANG.whoisCheck}</h1>
        </div>
    </div>
</section>

        
    <div class="inner-cnt">
        <div class="container animate-box">
            <h2>{$LANG.whoisSearch}</h2>
            <div class="row">
                <div class="col-md-6">
                    <div class="w-search">

                        <div class="FormReg">
                            <input type="text" name="domain" value="" class="checker" id="whois_domain" required placeholder="{$LANG.whoisSearchPlaceholder}">
                            <span id="domain-error" class="text-danger" style="display:none;">Domain name cannot be empty.</span>
                            <span id="invalid-domain-error" class="text-danger" style="display:none;">Invalid domain name.</span>
                        </div>
                        <label>{$LANG.whoisName}</label>
                        <div class="clearfix">
                        </div>
                        <br>

                             
                             <div class="g-recaptcha" data-sitekey="6LdxZowqAAAAAObbdHAtlTUA6jrM1lACAs_EUu8Q"></div>
                             <div id="captchaError" class="text-danger" style="display:none;">Please verify that you are not a robot.</div><br>

                             
                             
                        <!-- {if $captcha}
                            <div class="text-center margin-bottom">
                                {include file="$template/includes/captcha.tpl"}
                            </div>
                        {/if} -->

                        <div class="FormReg">
                            <button name="Button4" id="search_domain" class="che-sub">{$LANG.whoisSearchNow}</button>
                        </div>

                    </div>

                </div>
                <div class="col-md-6">

                </div>
            </div>

            <div class="domain-result">

            </div>

        </div>
    </div>


    <script src="https://www.google.com/recaptcha/api.js" async defer></script>
    <script>
        
    </script>