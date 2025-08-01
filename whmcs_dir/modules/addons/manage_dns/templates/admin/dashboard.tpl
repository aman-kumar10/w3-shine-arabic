{include file=$tplVar.header}

{if $tplVar['status']['status'] == "Error" }
    <div class="errorbox"><strong><span class="title">{$tplVar['status']['title']}</span></strong><br>{$tplVar['status']['message']}</div>
{elseif $tplVar['status']['status'] == "success"}
    <div class="successbox"><strong><span class="title">{$tplVar['status']['title']}</span></strong><br>{$tplVar['status']['message']}</div>
    {* <div class="successbox"><strong><span class="title">Changes Saved Successfully!</span></strong><br>Your changes have been saved.</div> *}
{/if}

<div style="margin-top: 30px;">
    lets go dashboard..
</div>
