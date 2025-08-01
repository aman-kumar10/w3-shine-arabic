{include file=$tplVar.header}

<h4>Setting</h4>


<form class='genral-setting-form' action="" method="post">
    {if $tplVar['status']}
        <div class="successbox"><strong><span class="title">Changes Saved Successfully!</span></strong><br>{$tplVar['status']}</div>
    {/if}


    <table class="form" width="100%" border="0" cellspacing="2" cellpadding="3">
        <tbody>
            <tr>
                <td class="fieldlabel" style="min-width:200px; width: 426px;">Enable Login Email OTP</td>
                <td class="fieldarea"><input type='checkbox' name='EmailOTP'
                        {if $tplVar['getGeneralSettingData']['EmailOTP'] == 'on'}checked{/if}></td>
            </tr>
            <tr>
                <td class="fieldlabel">Login Email OTP Template</td>
                <td class="fieldarea"><select name='otpTemplate' class='form-control select-inline' style="min-width: 411px;">
                        {foreach from=$tplVar['getEmailTemplate'] item=item key=key name=name}
                            <option value='{$key}'
                                {if $tplVar['getGeneralSettingData']['otpTemplate'] == $key}selected{/if}>
                                {$item}</option>
                        {/foreach}
                    </select>
                    <i class="fas fa-info-circle" data-toggle="tooltip" data-placement="right" title=""
                    data-original-title='The custom email template must use the { $otp } parameter in the email template for OTP.'></i>
                    </td>
            </tr>
            <tr>
                <td class="fieldlabel">OTP Token Expire</td>
                <td class="fieldarea"><select name='otpToken' class='form-control select-inline' style="min-width: 411px;">
                        <option value='2' {if $tplVar['getGeneralSettingData']['otpToken'] == 2}selected{/if}>2 minutes.
                        </option>
                        <option value='5' {if $tplVar['getGeneralSettingData']['otpToken'] == 5}selected{/if}>5 minutes.
                        </option>
                        <option value='10' {if $tplVar['getGeneralSettingData']['otpToken'] == 10}selected{/if}>10
                            minutes.
                        </option>
                        <option value='15' {if $tplVar['getGeneralSettingData']['otpToken'] == 15}selected{/if}>15
                            minutes.
                        </option>
                        <option value='30' {if $tplVar['getGeneralSettingData']['otpToken'] == 30}selected{/if}>30
                            minutes.
                        </option>
                        <option value='45' {if $tplVar['getGeneralSettingData']['otpToken'] == 45}selected{/if}>45
                            minutes.
                        </option>
                        <option value='60' {if $tplVar['getGeneralSettingData']['otpToken'] == 60}selected{/if}>1 Hour
                        </option>
                    </select></td>
            </tr>
        </tbody>
    </table>

    <div class="btn-container">
        <input type='submit' class='btn btn-success' value="Save Changes">
    </div>

</form>