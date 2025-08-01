
{$geturl = $smarty.get.action}

<style>
    th,td {
        text-align: center;
    }
    td{
        vertical-align: middle !important;
    }
</style>

<ul class="nav nav-tabs admin-tabs" >
    <li class="{if $geturl=='' || $geturl=='dashboard' } active {/if}"><a class="tab-top " href="/admin/addonmodules.php?module=verify_domain_identity"  id="tabLink1">Domain Identity</a></li>
    <li class="{if $geturl=='change_registrar_details' } active {/if}"><a class="tab-top " href="/admin/addonmodules.php?module=verify_domain_identity&action=change_registrar_details"  id="tabLink3">Change Registrar Details</a></li>
    <li class="{if $geturl=='setting'} active {/if}"><a class="tab-top " href="/admin/addonmodules.php?module=verify_domain_identity&action=setting"  id="tabLink2">Settings</a></li>
</ul>