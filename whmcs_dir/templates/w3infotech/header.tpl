<!doctype html>
<html lang="en">
<head>
    <meta charset="{$charset}" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>{if $kbarticle.title}{$kbarticle.title} - {/if}{$pagetitle} - {$companyname}</title>
	<link rel="icon" type="image/x-icon" href="{$WEB_ROOT}/templates/{$template}/images/favicon.ico">
    <link rel="shortcut icon" href="{$WEB_ROOT}/templates/{$template}/images/favicon.ico" type="image/x-icon">
    {include file="$template/includes/head.tpl"}
	{assetExists file="overrides.css"}
		<link href="{$__assetPath__}" rel="stylesheet">
	{/assetExists}
	<script src="{assetPath file='script-twenty-x.js'}"></script>
    {$headoutput}
	{if $loggedin}
        <script>var clientLoggedIn = true;</script>
	{else}
	    <script>var clientLoggedIn = false;</script>
	{/if}
    <!-- {debug} -->
</head>
<body class="primary-bg-color w3custombody {if $LANG.locale == 'ar_AR' || $LANG.locale == 'fa_IR' || $LANG.locale == 'he_IL'}body-rtl {/if}" data-phone-cc-input="{$phoneNumberInputStyle} ">
    {$headeroutput}
	{if $LANG.locale == 'ar_AR' || $LANG.locale == 'fa_IR' || $LANG.locale == 'he_IL'}
		<link href="{$WEB_ROOT}/templates/{$template}/css/style-rtl.css" rel="stylesheet">
	{/if}
   
    <header class="header">
            <div class="top_bar">
                <div class="top_bar_container">
                    <div class="container">
                        <div class="row">
                            <div class="top_bar_contact_list col-md-6">
                                <ul>
                                    <li><a href="mailto:{$LANG.headerSupportEmail}">{$LANG.headerSupportEmail}</a></li>
                                    <li>{$LANG.headerSales} : <a href="tel:+97455032337">+974 550 32 337</a></li>
                                    <li>{$LANG.headerSupport} : <a href="tel:+97466703103">+974 66 703 103</a></li>
                                </ul>
                            </div>

                            <div class="top_bar_login col-md-6">
                                <ul>
                                    {if $loggedin}
                                        {include file="$template/includes/navbar.tpl" navbar=$secondaryNavbar rightDrop=true}
                                    {else}
                                        <li><a href="{$WEB_ROOT}/register.php"><i class="fa fa-user" aria-hidden="true"></i>{$LANG.headerSignUp}</a></li>
                                        <li><a href="{$WEB_ROOT}/login.php" class="bor-n"><i class="fa fa-lock" aria-hidden="true"></i>{$LANG.headerLogin}</a></li>
                                    {/if}
                                    <li class="dropdown-list">
                                        <i class="far fa-usd-circle"></i>
                                        <a class="dropdown-toggle currency_dropdown" href="#" id="dropdown" data-bs-toggle="dropdown" aria-expanded="false">{$LANG.headerCurrency}</a>                                      
                                        <select name="dlPrice" id="dlPrice" class="select_currency">
                                            {foreach $currencies as $selectCurrency}
                                                <option {if $activeCurrency.id == $selectCurrency.id} selected{/if} value="{$selectCurrency.id}">{$selectCurrency.code}</option>
                                            {/foreach}
                                        </select>                                     
                                    </li>
                                    <li class="dropdown-list">
                                        <i class="fas fa-globe"></i>
                                        <a class="dropdown-toggle" href="#" id="dropdown" data-bs-toggle="dropdown" aria-expanded="false">{$LANG.headerLanguage}</a>
                                   
                                        <select name="dlLanguage" id="dlLanguage" class="select_language">
											{if $languagechangeenabled && count($locales) > 1}
												{foreach $locales as $locale}
													<option {if $language == $locale.language} selected{/if} value="{$locale.language}">{$locale.localisedName}</option>
												{/foreach}
											{/if}
										</select>
                                    </li>
                                    <li class="shopping_cart">
                                        <a class="nav-link cart-btn" href="/cart.php?a=view">
                                            <i class="far fa-shopping-cart fa-fw"></i>
                                            <span id="cartItemCount" class="badge badge-info">{$cartitemcount}</span>
                                            <span class="sr-only">Shopping Cart</span>
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Header Content -->
            <div class="header_container pt-2 pb-2">
                <div class="container">
                    <div class="row">

                        <div class="header_content">

                            <div class="logo_container col-sm-6 col-md-6 col-lg-4 d-flex justify-content-start">
                                <a href="{$WEB_ROOT}/index.php">
                                    <div class="logo_content">
                                        <div class="logo_img me-4">
                                            <img src="{$WEB_ROOT}/templates/{$template}/images/logo.png" class="img-fluid" title="logo" alt="logo" />
                                        </div>
                                    </div>
                                </a>
                            </div>

                            <div class="site-wrap">
                                <div class="site-mobile-menu">
                                    <div class="site-mobile-menu-header">
                                        <div class="site-mobile-menu-close mt-3">
                                            <span class="icon-close2 js-menu-toggle">
                                                <i class="fal fa-times"></i>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="site-mobile-menu-body">
                                        <ul class="site-nav-wrap">
                                            <li {if $templatefile == 'homepage'}class="active"{/if}>
                                                <a href="{$WEB_ROOT}/index.php">{$LANG.headerHome}</a>
                                            </li>
                                            <li {if $templatefile == 'about-us'}class="active"{/if}>
                                                <a href="{$WEB_ROOT}/about-us.php">{$LANG.headerAboutUs}</a>
                                            </li>
                                            <li {if $templatefile == 'services'}class="active"{/if} ><a href="{$WEB_ROOT}/services.php">{$LANG.headerServices}</a></li>

                                            <li><a href="#buy">{$LANG.headerBuyHosting}</a></li>

                                            <li class="{if in_array($templatefile, ['clientareadomains','domaintransfer', 'support-documents','supportticketsubmit-steptwo','whois-lookup','clientareaproducts'])} active {/if} has-children"><span class="arrow-collapse collapsed" data-bs-toggle="collapse" data-bs-target="#collapseItem0" role="button"></span>
                                                <a href="#">{$LANG.headerManageDomain}</a>
                                                <ul class="collapse" id="collapseItem0">
                                                    <li><a href="{$WEB_ROOT}/clientarea.php?action=domains">{$LANG.headerMyDomain}</a></li>
                                                    <li><a href="{$WEB_ROOT}/clientarea.php?action=domains">{$LANG.headerRetrieveDomainPassword}</a></li>
                                                    <li><a href="{$WEB_ROOT}/clientarea.php?action=domains">{$LANG.headerRegistrantChange}</a></li>
                                                    <li><a href="{$WEB_ROOT}/cart.php?a=add&domain=transfer">{$LANG.headerTransferDomainToUs}</a></li>
                                                    <li><a href="{$WEB_ROOT}/support-documents.php">{$LANG.headerSupportDocuments}</a></li>
                                                    <li><a href="{$WEB_ROOT}/submitticket.php">{$LANG.headerSupportTickets}</a></li>
                                                    <li><a href="{$WEB_ROOT}/whois-lookup.php">{$LANG.headerWhoisLookup}</a></li>
                                                    <li><a href="{$WEB_ROOT}/clientarea.php?action=services">My Services</a></li>
                                                </ul>
                                            </li>
                                            <li {if $templatefile == 'fdf'}class="active"{/if} class="has-children"><span class="arrow-collapse collapsed" data-bs-toggle="collapse" data-bs-target="#collapseItem1" role="button"></span>
                                                <a href="#">Billing</a>
                                                <ul class="collapse" id="collapseItem1">
                                                    <li><a href="{$WEB_ROOT}/clientarea.php?action=invoices">My Invoices</a></li>
                                                    <li><a href="{$WEB_ROOT}/clientarea.php?action=quotes">My Quotes</a></li>
                                                    <li><a href="{$WEB_ROOT}/clientarea.php?action=masspay&all=true">Mass Payment</a></li>
                                                </ul>
                                            </li>
                                            <li {if $templatefile == 'reseller'}class="active"{/if}><a href="{$WEB_ROOT}/login.php">{$LANG.headerReseller}</a></li>
                                            <li {if $templatefile == 'contact-us'}class="active"{/if}><a href="{$WEB_ROOT}/contact-us.php">{$LANG.headerContactUs}</a></li>
                                        </ul>
                                    </div>
                                    <div class="site-mobile-menu-footer">
                                        <img src="{$WEB_ROOT}/templates/{$template}/images/accredit-log1.png" class="img-fluid" title="Accredited Registrar" alt="Accredited Registrar" />
                                    </div>
                                </div>
                                <div class="site-navbar bg-white">
                                    <nav class="site-navigation text-right" role="navigation">
                                        <div class="d-inline-block d-lg-none ml-md-0 mr-auto py-4">
                                        <a href="#" class="site-menu-toggle js-menu-toggle text-black">
                                        <span class="icon-align-left h3"><i class="fas fa-bars"></i></span></a>
                                        </div>
                                        <ul class="site-menu js-clone-nav d-none d-lg-block">
                                            
                                            <li {if $templatefile == 'homepage'}class="active"{/if}><a href="{$WEB_ROOT}/index.php">{$LANG.headerHome}</a></li>
                                            <li {if $templatefile == 'about-us'}class="active"{/if} ><a href="{$WEB_ROOT}/about-us.php">{$LANG.headerAboutUs}</a>
                                            <li {if $templatefile == 'services'}class="active"{/if}><a href="{$WEB_ROOT}/services.php">{$LANG.headerServices}</a></li>
                                            <li><a href="#buy">{$LANG.headerBuyHosting}</a></li>

                                            <li class="{if in_array($templatefile, ['clientareadomains','domaintransfer', 'support-documents','supportticketsubmit-steptwo','whois-lookup','clientareaproducts'])} active {/if} has-children">
                                                <a href="#">{$LANG.headerManageDomain}</a>
                                                <ul class="dropdown arrow-top">
                                                    <li {if $templatefile == 'clientareadomains'}class="active"{/if}><a href="{$WEB_ROOT}/clientarea.php?action=domains">{$LANG.headerMyDomain}</a></li>
                                                    <li {if $templatefile == 'clientareadomains'}class="active"{/if}><a href="{$WEB_ROOT}/clientarea.php?action=domains">{$LANG.headerRetrieveDomainPassword}</a></li>
                                                    <li {if $templatefile == ''}class="active"{/if}><a href="{$WEB_ROOT}/clientarea.php?action=domains">{$LANG.headerRegistrantChange}</a></li>
                                                    <li {if $templatefile == 'domaintransfer'}class="active"{/if}><a href="{$WEB_ROOT}/cart.php?a=add&domain=transfer">{$LANG.headerTransferDomainToUs}</a></li>
                                                    <li {if $templatefile == 'support-documents'}class="active"{/if}><a href="{$WEB_ROOT}/support-documents.php">{$LANG.headerSupportDocuments}</a></li>
                                                    <li {if $templatefile == 'supporttickets'}class="active"{/if}><a href="{$WEB_ROOT}/supporttickets.php">{$LANG.headerSupportTickets}</a></li>
                                                    <!--li {if $templatefile == 'supportticketsubmit-steptwo'}class="active"{/if}><a href="{$WEB_ROOT}/submitticket.php?step=2&deptid=1">{$LANG.headerSupportTickets}</a></li-->
                                                    <li {if $templatefile == 'whois-lookup'}class="active"{/if}><a href="{$WEB_ROOT}/whois-lookup.php">{$LANG.headerWhoisLookup}</a></li>
                                                    <li {if $templatefile == 'clientareaproducts'}class="active"{/if}><a href="{$WEB_ROOT}/clientarea.php?action=services">My Services</a></li>
                                                </ul>
                                            </li>
                                            <li class="has-children">
                                                <a href="#">Billing</a>
                                                <ul class="dropdown arrow-top">
                                                    <li><a href="{$WEB_ROOT}/clientarea.php?action=invoices">My Invoices</a></li>
                                                    <li><a href="{$WEB_ROOT}/clientarea.php?action=quotes">My Quotes</a></li>
                                                    <li><a href="{$WEB_ROOT}/clientarea.php?action=masspay&all=true">Mass Payment</a></li>
                                                </ul>
                                            </li>
                                            <li {if $templatefile == 'reseller'}class="active"{/if}><a href="{$WEB_ROOT}/login.php">{$LANG.headerReseller}</a></li>
                                            <li {if $templatefile == 'contact-us'}class="active"{/if}><a href="{$WEB_ROOT}/contact-us.php">{$LANG.headerContactUs}</a></li>
                                        </ul>
                                    </nav>
                                </div>

                            </div>

                        </div>

                    </div>
                </div>
            </div>

    </header>
    {include file="$template/includes/network-issues-notifications.tpl"}

    {include file="$template/includes/verifyemail.tpl"}

        <section id="main-body" {if $templatefile != 'homepage'}class="body-background-20i"{/if}>

            {if $module == "smartermail2" || in_array($templatefile, ['clientareacancelrequest','supportticketsubmit-steptwo','two-factor-challenge', 'clientareainvoices', 'clientareaquotes', 'masspay','addons','clientareadomainaddons','domain-renewals','domaintransfer','clientareaproductdetails','clientareaproducts', 'account-contacts-manage', 'bulkdomainmanagement', 'configureproductdomain'])}
            <div class="container domaindetails-sec">
                    <div class="row">
            {else}
            <div class="">
                <div class="">
            {/if}
            {if $module == "smartermail2" || !$inShoppingCart && ($primarySidebar->hasChildren() || $secondarySidebar->hasChildren()) && $templatefile|in_array:['clientareainvoices','clientareaproductdetails', 'clientareaquotes','clientareaproducts', 'masspay']}
            <div class="col-lg-4 col-xl-3">
                <div class="sidebar">
                    {include file="$template/includes/sidebar.tpl" sidebar=$primarySidebar}
                </div>
                {if !$inShoppingCart && $secondarySidebar->hasChildren()}
                    <div class="d-none d-lg-block sidebar">
                        {include file="$template/includes/sidebar.tpl" sidebar=$secondarySidebar}
                    </div>
                {/if}
            </div>
            {/if}
            <div class="{if !$inShoppingCart && ($primarySidebar->hasChildren() || $secondarySidebar->hasChildren()) && $templatefile !== 'clientregister'} col-lg-8 {if $module == 'smartermail2' || $templatefile|in_array:['clientareainvoices','clientareaproductdetails', 'clientareaquotes','clientareaproducts', 'masspay']} col-xl-9 {else} col-xl-12 {/if}{else}{if !$skipMainBodyContainer || $templatefile == 'clientregister'}col-12{/if}{/if} primary-content {if $templatefile == 'clientareadomainregisterns'} domain_private_primary{/if}">