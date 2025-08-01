<section class="page-title forget-page">
    <div class="container">
        <div class="title-text ms-5 text-15">
            <h1>{$LANG.passwordReset}</h1>
        </div>
    </div>
</section>


<div class="customPaswwordReset">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-6">
                <div class="card-body px-md-5 py-5">
                    {if $loggedin && $innerTemplate}
                        {include file="$template/includes/alert.tpl" type="error" msg="{lang key='noPasswordResetWhenLoggedIn'}"
                        textcenter=true}
                    {else}
                        {if $successMessage}
                            {include file="$template/includes/alert.tpl" type="success" msg=$successTitle textcenter=true}
                            <p>{$successMessage}</p>
                        {else}
                            {if $innerTemplate}
                                {include file="$template/password-reset-$innerTemplate.tpl"}
                            {/if}
                        {/if}
                    {/if}
                </div>
            </div>
            <div class="col-md-6">
                <img src="{$WEB_ROOT}/templates/{$template}/images/forgot_i.png">
        
        </div>
    </div>
</div>