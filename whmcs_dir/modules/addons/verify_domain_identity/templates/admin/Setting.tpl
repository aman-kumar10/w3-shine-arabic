{include file=$tplVar.header}

{if $tplVar['status'] == 'success'}
    <div class="successbox"><strong><span class="title">Changes Saved Successfully!</span></strong><br>Your changes have been saved.</div>
{/if}

<div style="margin-top: 30px;">
    <form action="" method="post">
        <table class="form" width="100%" border="0" cellspacing="2" cellpadding="3">
            <tbody>
                <tr>
                    <td width="15%" class="fieldlabel">Verify email template</td>
                    <td class="fieldarea">
                        <select name='verify_email_template' class='form-control select-inline'>
                            {foreach from=$tplVar['getVerifyTemplate'] item=item key=key name=name}
                                <option value='{$item->id}' {if  $tplVar['getSelectedEmailTemplate']['verify_email_template'] == $item->id }selected{/if}>{$item->name}</option>
                            {/foreach}
                        </select>
                        <font color="#444"><small>Selected email template to send when a document is verified.</small></font>
                    </td>
                </tr>
                <tr>
                    <td width="15%" class="fieldlabel">Reject email template</td>
                    <td class="fieldarea">
                        <select name='reject_email_template'  class='form-control select-inline'>
                            {foreach from=$tplVar['getRejectTemplate'] item=item key=key name=name}
                                <option value='{$item->id}' {if  $tplVar['getSelectedEmailTemplate']['reject_email_template'] == $item->id }selected{/if}>{$item->name}</option>
                            {/foreach}
                        </select>
                        <font color="#444"><small>Selected email template to send when a document is rejected.</small></font>
                        <font color="red"><small>[Note: Available merge field tags: { reject_reason } ]</small>
                    </td>
                </tr>

            </tbody>
        </table>
        <div class="btn-container">
            <input type="submit" value="Save Changes" class="btn btn-primary" tabindex="53">
        </div>
    </form>
</div>