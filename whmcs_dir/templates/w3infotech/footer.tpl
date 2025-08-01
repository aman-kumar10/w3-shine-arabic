                    </div>

                    </div>
                    {if !$inShoppingCart && $secondarySidebar->hasChildren() && !in_array($templatefile, ["supportticketslist", "viewticket"])}
                    <div class="d-lg-none sidebar sidebar-secondary">
                            {include file="$template/includes/sidebar.tpl" sidebar=$secondarySidebar}
                        </div>
                    {/if}
                <div class="clearfix"></div>
            </div>
        </div>
    </section>

   <!--  <footer id="footer" class="footer">
        <div class="container">
            <ul class="list-inline mb-7 text-center float-lg-right">
                {include file="$template/includes/social-accounts.tpl"}
                    {if $languagechangeenabled && count($locales) > 1 || $currencies}
                        <li class="list-inline-item">
                            <button type="button" class="btn" data-toggle="modal" data-target="#modalChooseLanguage">
                                <div class="d-inline-block align-middle">
                                    <div class="iti-flag {if $activeLocale.countryCode === '001'}us{else}{$activeLocale.countryCode|lower}{/if}"></div>
                                </div>
                                {$activeLocale.localisedName}
                                /
                                {$activeCurrency.prefix}
                                {$activeCurrency.code}
                            </button>
                        </li>
                    {/if}
            </ul>

            <ul class="nav justify-content-center justify-content-lg-start mb-7">
                <li class="nav-item">
                    <a class="nav-link" href="{$WEB_ROOT}/contact.php">
                        {lang key='contactus'}
                    </a>
                </li>
                {if $acceptTOS}
                    <li class="nav-item">
                        <a class="nav-link" href="{$tosURL}" target="_blank">{lang key='ordertos'}</a>
                    </li>
                {/if}
            </ul>

            <p class="copyright mb-0">
                {lang key="copyrightFooterNotice" year=$date_year company=$companyname}
            </p>
        </div>
    </footer> -->

    <footer>
            <div class="container">
                <div class="row">
                    <div class="col-md-12 mb-5">
                        <a href="{$WEB_ROOT}/index.php">
                            <img class="me-3" src="{$WEB_ROOT}/templates/{$template}/images/logo.png" title="logo" alt="logo" /></a>
                    </div>
                    <div class="clearfix"></div>


                    <div class="col-md-3 col-sm-6 footer-col">
                        <div class="email-f mb-4">{$LANG.footerEmail} <a href="mailto:{$LANG.footerEmailInfo}">{$LANG.footerEmailInfo}</a></div>
                        <div class="contact-f mb-4"><span class="icon-phone"></span><a href="tel:+97466703103">+974 66 703 103</a></div>
                    </div>

                    <div class="col-md-4 col-sm-6 footer-col mb-4">
                        <h3>{$LANG.footerQuickLinks}</h3>

                        <div class="row">
                            <div class="footer-widget col-md-6">
                                <ul>
                                    <li><a href="{$WEB_ROOT}/about-us.php">{$LANG.footerAboutROUTEDGE}</a></li>
                                    <li><a href="{$WEB_ROOT}/whois-lookup.php">{$LANG.WhoisLookup}</a></li>
                                    <li><a href="{$WEB_ROOT}/faq.php">{$LANG.faq}</a></li>
                                    <li><a href="{$WEB_ROOT}/cart.php?a=add&domain=transfer">{$LANG.footerTransferDomain}</a></li>
                                </ul>
                            </div>
                            <div class="footer-widget col-md-6">
                                <ul>
                                    <li><a href="{$WEB_ROOT}/submitticket.php?step=2&deptid=1">{$LANG.supportTickets}</a></li>
                                    <li><a href="{$WEB_ROOT}/policies.php">{$LANG.policies}</a></li>
                                    <li><a href="http://blog.w3infotech.com/" target="_blank">{$LANG.ourBlog}</a></li>
                                    <li><a href="{$WEB_ROOT}/contact-us.php">{$LANG.ContactROUTEDGE}</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <div class="footer-widget col-md-2 col-sm-6 footer-col mb-4">
                        <h3>{$LANG.downloads}</h3>
                        <div class="row">
                            <div class="col-md-12">
                                <ul>
                                    <li><a href="{$WEB_ROOT}/templates/{$template}/images/documents/w3infotech-brochure.pdf" target="_blank">{$LANG.companyBrochure}</a></li>
                                    <li><a href="{$WEB_ROOT}/templates/{$template}/images/documents/terms-and-conditions.pdf" target="_blank">{$LANG.termsAndConditions}</a></li>
                                    <li><a href="{$WEB_ROOT}/templates/{$template}/images/documents/refund-policy.pdf" target="_blank">{$LANG.refundPolicy}</a></li>
                                    <li><a href="{$WEB_ROOT}/templates/{$template}/images/documents/privacy-policy.pdf" target="_blank">{$LANG.privacyPolicy}</a></li>
                                    
                                </ul>
                            </div>
                        </div>
                    </div>

                    <div class="footer-widget col-md-3 col-sm-6 footer-col">
                        <h3>{$LANG.socialMedia}</h3>
                        <div class="row">
                            <div class="col-md-12">
                                <ul class="social-media">
                                    <li><a href="https://www.instagram.com/routedge_wll/"><span class="icon-instagram"><i class="fab fa-instagram"></i></span></a></li>
                                    <li><a href="https://twitter.com/routedge_wll/"><span class="icon-twitters"><i class="fab fa-twitter"></i></span></a></li>
                                    <li><a href="https://www.facebook.com/Routedge/"><span class="icon-youtube"><i class="fab fa-facebook"></i></span></a></li>
                                </ul>
                            </div>
                        </div>
                    </div>

                </div>

                <hr>

                <div class="row pt-4 pb-4">
                    <div class="col-md-6 copyright">{lang key="copyrightFooterNotice" year=$date_year company=$companyname}</div>
                    <div class="col-md-6 mtext-right">
                        <img src="{$WEB_ROOT}/templates/{$template}/images/payment.png" title="payment" alt="title" />
                    </div>
                </div>

            </div>
        </footer>

    <!--  <div id="fullpage-overlay" class="w-hidden">
        <div class="outer-wrapper">
            <div class="inner-wrapper">
                <img src="{$WEB_ROOT}/assets/img/overlay-spinner.svg" alt="">
                <br>
                <span class="msg"></span>
            </div>
        </div>
    </div> -->

    <div class="modal system-modal fade" id="modalAjax" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"></h5>
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">&times;</span>
                        <span class="sr-only">{lang key='close'}</span>
                    </button>
                </div>
                <div class="modal-body">
                    {lang key='loading'}
                </div>
                <div class="modal-footer">
                    <div class="float-left loader">
                        <i class="fas fa-circle-notch fa-spin"></i>
                        {lang key='loading'}
                    </div>
                    <button type="button" class="btn btn-default" data-dismiss="modal">
                        {lang key='close'}
                    </button>
                    <button type="button" class="btn btn-primary modal-submit">
                        {lang key='submit'}
                    </button>
                </div>
            </div>
        </div>
    </div>

    <form method="get" action="{$currentpagelinkback}">
        <div class="modal modal-localisation" id="modalChooseLanguage" tabindex="-1" role="dialog">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-body">
                        <button type="button" class="close text-light" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>

                        {if $languagechangeenabled && count($locales) > 1}
                            <h5 class="h5 pt-5 pb-3">{lang key='chooselanguage'}</h5>
                            <div class="row item-selector">
                                <input type="hidden" name="language" data-current="{$language}" value="{$language}" />
                                {foreach $locales as $locale}
                                    <div class="col-4">
                                        <a href="#" class="item{if $language == $locale.language} active{/if}" data-value="{$locale.language}">
                                            {$locale.localisedName}
                                        </a>
                                    </div>
                                {/foreach}
                            </div>
                        {/if}
                        {if !$loggedin && $currencies}
                            <p class="h5 pt-5 pb-3">{lang key='choosecurrency'}</p>
                            <div class="row item-selector">
                                <input type="hidden" name="currency" data-current="{$activeCurrency.id}" value="">
                                {foreach $currencies as $selectCurrency}
                                    <div class="col-4">
                                        <a href="#" class="item{if $activeCurrency.id == $selectCurrency.id} active{/if}" data-value="{$selectCurrency.id}">
                                            {$selectCurrency.prefix} {$selectCurrency.code}
                                        </a>
                                    </div>
                                {/foreach}
                            </div>
                        {/if}
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-default">{lang key='apply'}</button>
                    </div>
                </div>
            </div>
        </div>
    </form>

    {if !$loggedin && $adminLoggedIn}
        <a href="{$WEB_ROOT}/logout.php?returntoadmin=1" class="btn btn-return-to-admin" data-toggle="tooltip" data-placement="bottom" title="{if $adminMasqueradingAsClient}{lang key='adminmasqueradingasclient'} {lang key='logoutandreturntoadminarea'}{else}{lang key='adminloggedin'} {lang key='returntoadminarea'}{/if}">
            <i class="fas fa-redo-alt"></i>
            <span class="d-none d-md-inline-block">{lang key="admin.returnToAdmin"}</span>
        </a>
    {/if}

    {include file="$template/includes/generate-password.tpl"}

    {$footeroutput}


</body>
</html>
