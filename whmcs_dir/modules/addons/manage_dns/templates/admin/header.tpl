
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
    <li class="{if $geturl=='' || $geturl=='dashboard'  } active {/if}"><a class="tab-top " href="/admin/addonmodules.php?module=manage_dns"  id="tabLink1">Manage DNS</a></li>
</ul>