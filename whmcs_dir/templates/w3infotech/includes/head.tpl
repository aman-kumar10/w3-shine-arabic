<!-- Styling -->
{\WHMCS\View\Asset::fontCssInclude('open-sans-family.css')}
<link href="{assetPath file='all.min.css'}?v={$versionHash}" rel="stylesheet">
<!-- all-min-css -->
<!-- <link href="{assetPath file='theme.min.css'}?v={$versionHash}" rel="stylesheet"> -->

<link href="{$WEB_ROOT}/assets/css/fontawesome-all.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/icomoon@1.0.0/style.min.css" rel="stylesheet">
{assetExists file="custom.css"}
<link href="{$__assetPath__}" rel="stylesheet">
{/assetExists}
{assetExists file="bootstrap.min.css"}
<link href="{$__assetPath__}" rel="stylesheet">
{/assetExists}
{assetExists file="slick.css"}
<link href="{$__assetPath__}" rel="stylesheet">
{/assetExists}
{assetExists file="base.css"}
<link href="{$__assetPath__}" rel="stylesheet">
{/assetExists}
{assetExists file="style.css"}
<link href="{$__assetPath__}" rel="stylesheet">
{/assetExists}
{assetExists file="responsive_custom.css"}
<link href="{$__assetPath__}" rel="stylesheet">
{/assetExists}
<!-- {debug} -->

<script>
    var csrfToken = '{$token}',
        markdownGuide = '{lang|addslashes key="markdown.title"}',
        locale = '{if !empty($mdeLocale)}{$mdeLocale}{else}en{/if}',
        saved = '{lang|addslashes key="markdown.saved"}',
        saving = '{lang|addslashes key="markdown.saving"}',
        whmcsBaseUrl = "{\WHMCS\Utility\Environment\WebHelper::getBaseUrl()}";
    {if $captcha}{$captcha->getPageJs()}{/if}
</script>


 


{if $templatefile == 'clientregister' || $templatefile == 'domain-renewals' || $templatefile == 'clientareaemails' || $templatefile == 'user-security' || $templatefile == 'supportticketsubmit-steptwo' || $templatefile == 'viewticket' || $templatefile == 'supportticketslist' || $templatefile == 'clientareadomains' || $templatefile == 'clientareaproducts' || $templatefile == 'user-password' || ($templatefile == 'viewcart' && $action != 'checkout') || $templatefile == 'clientareainvoices' || $templatefile == 'clientareaquotes'|| $templatefile == 'masspay'}
  <script src="{assetPath file='scripts.min.js'}?v={$versionHash}"></script>
  <script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.5/dist/jquery.validate.js"></script>
  <script src="{$WEB_ROOT}/templates/{$template}/js/validate.js"></script>
  <script src="{assetPath file='slick.js'}"></script>
  <script src="{assetPath file='custom.js'}?v={$versionHash}"></script>
{else}
  <script src="{assetPath file='scripts.min.js'}?v={$versionHash}"></script>
  <script src="https://cdn.jsdelivr.net/npm/jquery-validation@1.19.5/dist/jquery.validate.js"></script>
  <script src="{$WEB_ROOT}/templates/{$template}/js/validate.js"></script>
  <script src="{assetPath file='bootstrap.bundle.min.js'}"></script>
  <script src="{assetPath file='jquery.min.js'}"></script>
  <script src="{assetPath file='slick.js'}"></script>
  <script src="{assetPath file='custom.js'}?v={$versionHash}"></script>
  <script src="{assetPath file='bootstrap.min.js'}"></script>
{/if}


{if $templatefile == "viewticket" && !$loggedin}
  <meta name="robots" content="noindex" />
{/if}
