{if $login && $domainname != "" && $domainstatus == "1"}
    <link href="../modules/addons/manage_dns/assets/css/client.css" rel="stylesheet" type="text/css" />

    <div class="container">
        <div id="ctl00_ContentPlaceHolder1_pnlDNS">

            <div class="col-md-12">
                <div class="clearfix mb-4"></div>
                <br>
                <h2>{$LANG_VAR["edit_dns_records"]}</h2>
                <span id="ctl00_ContentPlaceHolder1_lblDNSMessage" style="color:Red;"></span>
                <div class="clearfix"></div>
                <input type="hidden" name="ctl00$ContentPlaceHolder1$HiddenField4" id="ctl00_ContentPlaceHolder1_HiddenField4">
                <input type="hidden" name="ctl00$ContentPlaceHolder1$HiddenField2" id="ctl00_ContentPlaceHolder1_HiddenField2">
                <h4>{$LANG_VAR["dns_hostname"]}</h4>
                <p>
                    {$domainname}
                </p>
        
                <div class="clearfix"></div>
                <br>
        
                <div class="records">
                    <h4 class="toggle-header">{$LANG_VAR["a_records"]}<div class="arrowDown"></div>
                        <div class="collapseIcon">+</div>
                    </h4>
                    <div class="data-block" style="display: none;">
                        <div id="ctl00_ContentPlaceHolder1_UpdatePanel6">
                            <p class="err">“ @ or * “ {$LANG_VAR["a_not_required"]}</p>
                            <table>
                                <tbody>
                                    <tr>
                                        <td data-label="Host Name">
                                            <div class="">
                                                <input name="a-record-hostname" type="text" id="a-record-hostname" class="dtext"
                                                    placeholder="{$LANG_VAR['a_host_name']}" onfocus="this.placeholder = ''"
                                                    onblur="this.placeholder = `{$LANG_VAR['a_host_name']}`" required>
                                                <span>{$domainname}</span>
                                            </div>
                                        </td>
                                        <td data-label="IP Address">
                                            <div class="">
                                                <input name="a-record-ipaddress" type="text" id="a-record-ipaddress"
                                                    class="dtext" placeholder="{$LANG_VAR['a_ip_address']}" onfocus="this.placeholder = ''"
                                                    onblur="this.placeholder = `{$LANG_VAR['a_ip_address']}`" required>
                                                <span id="add-a-ipaddress-required" style="color:Red;display:none;">{$LANG_VAR["a_enter_ip_address"]}</span>
                                                <input type="hidden" id="systemurl" value="{$systemurl}">
                                                <input type="hidden" id="domainname" value="{$domainname}">
                                                <input type="hidden" id="updatebutton" value="{$LANG_VAR['update_button']}">
                                                <input type="hidden" id="deletebutton" value="{$LANG_VAR['delete_button']}">
                                            </div>
                                        </td>
                                        <td data-label="TTL">
                                            <div class="">
                                                <select name="add-a-ttl" id="add-a-ttl" class="dtext" required>
                                                    <option value="">{$LANG_VAR['a_select_ttl']}</option>
                                                    <option value="60">60</option>
                                                    <option value="300">300</option>
                                                    <option value="900">900</option>
                                                    <option value="1800">1800</option>
                                                    <option value="3600">3600</option>
                                                    <option value="21600">21600</option>
                                                    <option value="43200">43200</option>
                                                    <option value="86400">86400</option>
                                                    <option value="172800">172800</option>
                                                    <option value="259200">259200</option>
                                                    <option value="604800">604800</option>
                                                    <option value="1209600">1209600</option>
                                                    <option value="2592000">2592000</option>
                                                </select>
                                                <span id="add-a-ttl-required" style="color:Red;display:none;">{$LANG_VAR["a_error_select_ttl"]}</span>
                                            </div>
                                        </td>
                                        <td data-label="Actions">
                                            <div class="">
                                                    <button type="button" class="add addarecord" id="addarecord"><span
                                                        id="addedarecordText">
                                                        {$LANG_VAR["add_a_record"]}
                                                    </span>
                                                    <span id="addedarecordLoading" class="hidden"> <i class="fas fa-spinner fa-spin"></i>
                                                        Loading...</span></button>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <div class="addarecordalert"></div>
                            <div class="rtitle">{$LANG_VAR["available_a_records"]}</div>
                            <div>
                                <table cellspacing="0" border="0" id=""
                                    style="border-collapse:collapse;">
                                    <thead id ="aRecordsTableHead">
                                        <tr>
                                            <th align="center" scope="col">{$LANG_VAR['a_host_name']}</th>
                                            <th scope="col">{$LANG_VAR['a_ip_address']}</th>
                                            <th align="left" scope="col">{$LANG_VAR['a_actions']}</th>
                                        </tr>
                                    </thead>
                                    <tbody id="dnsRecordsTableBody">
                                    </tbody>
                                </table>
                            </div>

                        </div>
                    </div>
                    <h4 class="toggle-header">{$LANG_VAR['mx_records']}<div class="arrowDown"></div>
                        <div class="collapseIcon">+</div>
                    </h4>
                    <div class="data-block" style="display: none;">
                        <div id="ctl00_ContentPlaceHolder1_UpdatePanel7">
        
                            <p class="err">“ @ or * “ {$LANG_VAR['mx_not_required']}</p>
        
                            <table>
        
                                <tbody>
                                    <tr>
                                        <td>
                                            <input name="maildomain" type="text"
                                                id="maildomain" class="dtext" placeholder="{$LANG_VAR['mx_mail_domain']}" onfocus="this.placeholder = ''"
                                                onblur="this.placeholder = `{$LANG_VAR['mx_mail_domain']}`"><span>.{$domainname}</span>
                                                
                                        </td>
                                        <td>
                                            <input name="mailexchanger" type="text"
                                                id="mailexchanger" class="ntext"
                                                autocomplete="off" placeholder="{$LANG_VAR['mx_mail_exchanger']}" onfocus="this.placeholder = ''"
                                                onblur="this.placeholder = `{$LANG_VAR['mx_mail_exchanger']}`">
                                                <span id="mailexchangerequired"
                                                style="color:Red;display:none;">{$LANG_VAR['mx_enter_mail']} </span>
                                            <input type="hidden"Exchanger
                                                name="mxdomain"
                                                id="mxdomain" value = "{$domainname}">
                                            <input type="hidden"
                                                name="mxsystemurl"
                                                id="mxsystemurl" value = "{$systemurl}">
                                        </td>
                                        <td>
                                            <input name="mailpriority" type="text"
                                                id="mailpriority" class="ntext" placeholder="{$LANG_VAR['mx_priority']}" onfocus="this.placeholder = ''"
                                                onblur="this.placeholder =`{$LANG_VAR['mx_priority']}`">
                                                <span id="mailpriorityrequired"
                                                style="color:Red;display:none;">{$LANG_VAR['mx_enter_priority']}</span>
                                        </td>
                                        <td data-label="TTL">
                                            <div class="">
                                                <select name="add-mx-ttl" id="add-mx-ttl" class="dtext" required>
                                                    <option value="">{$LANG_VAR['mx_select_ttl']}</option>
                                                    <option value="60">60</option>
                                                    <option value="300">300</option>
                                                    <option value="900">900</option>
                                                    <option value="1800">1800</option>
                                                    <option value="3600">3600</option>
                                                    <option value="21600">21600</option>
                                                    <option value="43200">43200</option>
                                                    <option value="86400">86400</option>
                                                    <option value="172800">172800</option>
                                                    <option value="259200">259200</option>
                                                    <option value="604800">604800</option>
                                                    <option value="1209600">1209600</option>
                                                    <option value="2592000">2592000</option>
                                                </select>
                                                <span id="add-mx-ttl-required" style="color:Red;display:none;">{$LANG_VAR['mx_select_ttl']}</span>
                                            </div>
                                        </td>
                                        <td>

                                            <button type="button" class="add addmxrecords" id="addmxrecords"><span
                                                id="addedmxrecordText">
                                                {$LANG_VAR['add_mx_record']}
                                            </span>
                                            <span id="addedmxrecordLoading" class="hidden"> <i class="fas fa-spinner fa-spin"></i>
                                                Loading...</span></button>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
        
                            <div class="addmxrecordalert"></div>
                            <div class="mxerroralert"></div>
                            <div class="rtitle">{$LANG_VAR['available_mx_records']}</div>
                            <div>
                                <table cellspacing="0" border="0" id=""
                                style="border-collapse:collapse;">
                                <thead id = "mxRecordsTableHead">
                                    <tr>
                                        <th align="center" scope="col">{$LANG_VAR['mx_mail_domain']}</th>
                                        <th scope="col">{$LANG_VAR['mx_mail_exchanger']}</th>
                                        <th scope="col">{$LANG_VAR['mx_priority']}</th>
                                        <th align="left" scope="col">{$LANG_VAR['mx_actions']}</th>
                                    </tr>
                                </thead>
                                <tbody id="mxRecordsTableBody">
                                </tbody>
                            </table>
                            </div>
        
                        </div>
        
                    </div>
        
                    <h4 class="toggle-header">{$LANG_VAR['txt_records']}<div class="arrowDown"></div>
                        <div class="collapseIcon">+</div>
                    </h4>
                    <div class="data-block" style="display: none;">
                        <div id="ctl00_ContentPlaceHolder1_UpdatePanel8">
        
                            <p class="err">“ @ or * “ {$LANG_VAR['txt_not_required']}</p>
                            <table>
                                <tbody>
                                    <tr>
                                        <td>
                                            <input name="txthostname" type="text"
                                                id="txthostname" class="dtext" placeholder="{$LANG_VAR['txt_host_name']}" onfocus="this.placeholder = ''"
                                                onblur="this.placeholder = `{$LANG_VAR['txt_host_name']}`">
                                            <span>
                                                .{$domainname}</span>
                                            <input type="hidden" name="txtdomain" id="txtdomain"  value="{$domainname}">
                                            <input type="hidden" name="txtsystem" id="txtsystem" value="{$systemurl}">
                                        </td>
                                        <td>
                                            <input name="txtrecordsname" type="text"
                                                id="txtrecordsname" class="ntext" placeholder="{$LANG_VAR['txt_records_data']}" onfocus="this.placeholder = ''"
                                                onblur="this.placeholder = `{$LANG_VAR['txt_records_data']}`">
                                            <span id="add-txt-Record-required" style="color:Red;display:none;">{$LANG_VAR['txt_enter_record']}</span>
                                        </td>
                                        <td data-label="TTL">
                                            <div class="">
                                                <select name="add-txt-ttl" id="add-txt-ttl" class="dtext" required>
                                                    <option value="">{$LANG_VAR['txt_select_ttl']}</option>
                                                    <option value="60">60</option>
                                                    <option value="300">300</option>
                                                    <option value="900">900</option>
                                                    <option value="1800">1800</option>
                                                    <option value="3600">3600</option>
                                                    <option value="21600">21600</option>
                                                    <option value="43200">43200</option>
                                                    <option value="86400">86400</option>
                                                    <option value="172800">172800</option>
                                                    <option value="259200">259200</option>
                                                    <option value="604800">604800</option>
                                                    <option value="1209600">1209600</option>
                                                    <option value="2592000">2592000</option>
                                                </select>
                                                <span id="add-txt-ttl-required" style="color:Red;display:none;">{$LANG_VAR['txt_select_ttl']}</span>
                                            </div>
                                        </td>
                                        <td>
                                            
                                            <button type="button" class="add addtxtrecord" id="addtxtrecord"><span
                                                id="addedtxtrecordText">
                                                {$LANG_VAR['add_txt_record']}
                                            </span>
                                            <span id="addedtxtrecordLoading" class="hidden"> <i class="fas fa-spinner fa-spin"></i>
                                                Loading...</span></button>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <div class="addtxtrecordalert"></div>
                            <div class="rtitle">{$LANG_VAR['available_txt_records']}</div>
                            <div>
                                <table cellspacing="0" border="0" id=""
                                    style="border-collapse:collapse;">
                                    <thead id="txtRecordsTableHead">
                                        <tr>
                                            <th align="left" scope="col">{$LANG_VAR['txt_host_name']}</th>
                                            <th scope="col">{$LANG_VAR['txt_records_data']}</th>
                                            <th align="left" scope="col">{$LANG_VAR['txt_actions']}</th>
                                        </tr>
                                    </thead>
                                    <tbody id="txtRecordsTableBody">
                                    
                                    </tbody>
                                </table>
                            </div>
        
                        </div>
                    </div>
        
        
                    <h4 class="toggle-header">{$LANG_VAR['cname_records']}<div class="arrowDown"></div>
                        <div class="collapseIcon">+</div>
                    </h4>
                    <div class="data-block" style="display: none;">
                        <div id="ctl00_ContentPlaceHolder1_UpdatePanel9">
        
                            <p class="err">“ @ or * “ {$LANG_VAR['cname_not_required']}</p>
                            <table>
                                <tbody>
                                    <tr>
                                        <td>
                                            <input name="cnamehostname" type="text"
                                                id="cnamehostname" class="dtext" placeholder="{$LANG_VAR['cname_host_name']}" onfocus="this.placeholder = ''"
                                                onblur="this.placeholder = `{$LANG_VAR['cname_host_name']}`"><span>
                                                .{$domainname}</span>
                                        </td>
                                        <td>
                                            <input name="cnameipaddress" type="text"
                                                id="cnameipaddress" class="ntext" placeholder="{$LANG_VAR['cname_record']}" onfocus="this.placeholder = ''"
                                                onblur="this.placeholder = `{$LANG_VAR['cname_record']}`">
                                                <span id="cnameipaddress-cname-required" style="color:Red;display:none;">{$LANG_VAR['enter_cname_record']}</span>
                                                <input type="hidden" name="cnamedomain" id="cnamedomain"  value="{$domainname}">
                                                <input type="hidden" name="cnamesystem" id="cnamesystem" value="{$systemurl}">
                                        </td>
                                        <td data-label="TTL">
                                            <div class="">
                                                <select name="add-cname-ttl" id="add-cname-ttl" class="dtext" required>
                                                    <option value="">{$LANG_VAR['cname_ssl_name']}</option>
                                                    <option value="60">60</option>
                                                    <option value="300">300</option>
                                                    <option value="900">900</option>
                                                    <option value="1800">1800</option>
                                                    <option value="3600">3600</option>
                                                    <option value="21600">21600</option>
                                                    <option value="43200">43200</option>
                                                    <option value="86400">86400</option>
                                                    <option value="172800">172800</option>
                                                    <option value="259200">259200</option>
                                                    <option value="604800">604800</option>
                                                    <option value="1209600">1209600</option>
                                                    <option value="2592000">2592000</option>
                                                </select>
                                                <span id="add-cname-ttl-required" style="color:Red;display:none;">{$LANG_VAR['cname_ssl_name']}</span>
                                            </div>
                                        </td>
                                        <td>

                                            <button type="button" class="add addcname-record" id="addcname-record"><span
                                            id="addedcnamerecordText">
                                            {$LANG_VAR['add_cname_record']}
                                            </span>
                                            <span id="addedcnamerecordLoading" class="hidden"> <i class="fas fa-spinner fa-spin"></i>
                                            Loading...</span></button>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <div class="addcnamerecordalert"></div>
                            <div class="rtitle">{$LANG_VAR['available_cname_records']}</div>
                            <div>
                                <table cellspacing="0" border="0" id=""
                                    style="border-collapse:collapse;">
                                    <thead id = "cnameRecordsTableHead">
                                        <tr>
                                            <th align="left" scope="col">{$LANG_VAR['cname_host_name']}</th>
                                            <th scope="col">{$LANG_VAR['cname_records']}</th>
                                            <th align="left" scope="col">{$LANG_VAR['cname_actions']}</th>
                                        </tr>
                                    </thead>
                                    <tbody id="cnameRecordsTableBody">
                                    
                                    </tbody>
                                </table>
                            </div>
        
                        </div>
                    </div>
        
                    <h4 class="toggle-header">{$LANG_VAR['srv_records']}<div class="arrowDown"></div>
                        <div class="collapseIcon">+</div>
                    </h4>
                    <div class="data-block" style="display: none;">
                        <div id="ctl00_ContentPlaceHolder1_UpdatePanel10">
        
                            <p class="err">“ @ or * “ {$LANG_VAR['srv_not_required']}</p>
                            <table>
                                <tbody>
                                    <tr>
                                        <td>
                                            <input name="srvhostname" type="text"
                                                id="srvhostname" class="dtext" placeholder="{$LANG_VAR['srv_host_name']}" onfocus="this.placeholder = ''" onblur="this.placeholder = `{$LANG_VAR['srv_host_name']}`">
                                            <span>
                                                .{$domainname}</span>
                                            
                                        </td>
                                        
                                        <td>
                                            <input name="srvweight" type="text" id="srvweight" class="ntext" placeholder="{$LANG_VAR['srv_wight']}" onfocus="this.placeholder = ''" onblur="this.placeholder = `{$LANG_VAR['srv_wight']}`">
                                            <span id="srvweight-srv-required" style="color: red; display: none;">{$LANG_VAR['enter_srv_weight']}</span>
                                        </td>
                                        <td>
                                            <input name="srvport" type="text" id="srvport" class="ntext" placeholder="{$LANG_VAR['srv_port']}" onfocus="this.placeholder = ''" onblur="this.placeholder = `{$LANG_VAR['srv_port']}`">
                                            <span id="srvport-srv-required" style="color: red; display: none;">{$LANG_VAR['enter_srv_port']}</span>
                                        </td>
                                    </tr>
                                    <tr>

                                        <td>
                                            <input name="srvPriority" type="text" id="srvPriority" class="ntext" placeholder="{$LANG_VAR['srv_priority']}" onfocus="this.placeholder = ''" onblur="this.placeholder = `{$LANG_VAR['srv_priority']}`">
                                            <span id="srvPriority-srv-required" style="color: red; display: none;">{$LANG_VAR['enter_srv_priority']}</span>
                                        </td>
                                        <td>
                                            <input name="srvrecord" type="text" id="srvrecord" class="ntext" placeholder="{$LANG_VAR['srv_records']}" onfocus="this.placeholder = ''" onblur="this.placeholder = `{$LANG_VAR['srv_records']}`">
                                            <span id="srvrecord-srv-required" style="color: red; display: none;">{$LANG_VAR['enter_srv_priority']}</span>
                                            <input type="hidden" name="srvdomain" id="srvdomain" value="{$domainname}">
                                            <input type="hidden" name="srvsystem" id="srvsystem" value="{$systemurl}">
                                        </td>

                                        <td data-label="SRV">
                                            <div class="">
                                                <select name="add-srv-ttl" id="add-srv-ttl" class="ntext" required>
                                                    <option value="">{$LANG_VAR['srv_select_ttl']}</option>
                                                    <option value="60">60</option>
                                                    <option value="300">300</option>
                                                    <option value="900">900</option>
                                                    <option value="1800">1800</option>
                                                    <option value="3600">3600</option>
                                                    <option value="21600">21600</option>
                                                    <option value="43200">43200</option>
                                                    <option value="86400">86400</option>
                                                    <option value="172800">172800</option>
                                                    <option value="259200">259200</option>
                                                    <option value="604800">604800</option>
                                                    <option value="1209600">1209600</option>
                                                    <option value="2592000">2592000</option>
                                                </select>
                                                <span id="add-srv-ttl-required" style="color:Red;display:none;">{$LANG_VAR['srv_select_ttl']}</span>
                                            </div>
                                        </td>
                                        
                                        <td>
                                            <button type="button" class="add addsrv-record" id="addsrv-record"><span id="addedsrvrecordText">
                                                {$LANG_VAR['add_srv_record']}
                                                </span>
                                                <span id="addedsrvrecordLoading" class="hidden"> <i class="fas fa-spinner fa-spin"></i>
                                                Loading...</span>
                                            </button>    
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <div class="addsrvrecordalert"></div>
                            <div class="addsrverrordalert"></div>
                            <div class="rtitle">{$LANG_VAR['available_srv_records']}</div>
                            <div>
                                <table cellspacing="0" border="0" id=""
                                    style="border-collapse:collapse;">
                                    <thead id = "srvRecordsTableHead">
                                        <tr>
                                            <th align="center" scope="col" style="width: 386px;">{$LANG_VAR['srv_host']}</th>
                                            <th scope="col" style="width: 122px;">{$LANG_VAR['srv_Weight']}</th>
                                            <th scope="col" style="width: 122px;">{$LANG_VAR['srv_Port']}</th>
                                            <th scope="col" style="width: 122px;">{$LANG_VAR['srv_Priority']}</th>
                                            <th scope="col" style="width: 213px;">{$LANG_VAR['srv_records']}</th>
                                            <th align="left" scope="col">{$LANG_VAR['srv_Actions']}</th>
                                        </tr>
                                    </thead>
                                    <tbody id="srvRecordsTableBody">
                                    </tbody>
                                </table>
                            </div>
        
                        </div>
                    </div>
                    <h4 class="toggle-header">{$LANG_VAR['spf_records']}<div class="arrowDown"></div>
                        <div class="collapseIcon">+</div>
                    </h4>
                    <div class="data-block" style="display: none;">
                        <div id="ctl00_ContentPlaceHolder1_UpdatePanel11">
        
                            <p class="err">“ @ or * “ {$LANG_VAR['spf_not_required']}</p>
                            <table>
                                <tbody>
                                    <tr>
                                        <td>
                                            <input name="spfhostname" type="text"
                                                id="spfhostname" class="dtext" placeholder="{$LANG_VAR['spf_host_name']}" onfocus="this.placeholder = ''"
                                                onblur="this.placeholder = `{$LANG_VAR['spf_host_name']}`">
                                            <span>
                                                .{$domainname}</span>
                                            
                                            
                                        </td>
                                        <td>
                                            <input name="spfipaddress" type="text"
                                                id="spfipaddress" class="ntext" placeholder="{$LANG_VAR['spf_records']}" onfocus="this.placeholder = ''"
                                                onblur="this.placeholder = `{$LANG_VAR['spf_records']}`">
                                            <span id="spfipaddress-required" style="color:Red;display:none;">{$LANG_VAR['enter_spf_record']}</span>
                                            <input type="hidden" name="spfdomain" id="spfdomain"  value="{$domainname}">
                                            <input type="hidden" name="spfsystem" id="spfsystem" value="{$systemurl}">
                                        </td>
                                        <td data-label="SPF">
                                            <div class="">
                                                <select name="add-ttl-spf" id="add-ttl-spf" class="dtext" required>
                                                    <option value="">{$LANG_VAR['spf_select_ttl']}</option>
                                                    <option value="60">60</option>
                                                    <option value="300">300</option>
                                                    <option value="900">900</option>
                                                    <option value="1800">1800</option>
                                                    <option value="3600">3600</option>
                                                    <option value="21600">21600</option>
                                                    <option value="43200">43200</option>
                                                    <option value="86400">86400</option>
                                                    <option value="172800">172800</option>
                                                    <option value="259200">259200</option>
                                                    <option value="604800">604800</option>
                                                    <option value="1209600">1209600</option>
                                                    <option value="2592000">2592000</option>
                                                </select>
                                                <span id="add-ttl-spf-required" style="color:Red;display:none;">{$LANG_VAR['spf_select_ttl']}</span>
                                            </div>
                                        </td>
                                        <td>
                                            <button type="button" class="add addspf-record" id="addspf-record"><span id="addedspfrecordText">
                                                {$LANG_VAR['add_spf_record']}
                                                </span>
                                                <span id="addedspfrecordLoading" class="hidden"> <i class="fas fa-spinner fa-spin"></i>
                                                Loading...</span></button>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
        
                            <div class="addspfrecordalert"></div>
                            <div class="addspferroralert"></div>
                            <div class="rtitle">{$LANG_VAR['available_spf_records']}</div>
                            <div>
                                <table cellspacing="0" border="0" id=""
                                    style="border-collapse:collapse;">
                                    <thead id="spfRecordsTableHead">
                                        <tr>
                                            <th align="center" scope="col">{$LANG_VAR['spf_host']}</th>
                                            <th scope="col">{$LANG_VAR['spf_records']}</th>
                                            <th align="left" scope="col">{$LANG_VAR['spf_actions']}</th>
                                        </tr>
                                    </thead>
                                    <tbody id="spfRecordsTableBody">
                                    </tbody>
                                </table>
                            </div>
        
                        </div>
                    </div>
                    <h4 class="toggle-header">{$LANG_VAR['soa_records']}<div class="arrowDown"></div>
                        <div class="collapseIcon">+</div>
                    </h4>
                    <div class="data-block" style="display: none;">
                        <table>
                            <thead>
                                <tr>
                                    <th scope="col">{$LANG_VAR['soa_Nameserver']}</th>
                                    <th scope="col">{$LANG_VAR['soa_administrator']}</th>
                                    <th scope="col">{$LANG_VAR['soa_expire']}</th>
                                    <th scope="col">{$LANG_VAR['soa_retry']}</th>
                                    <th scope="col">{$LANG_VAR['soa_refresh']}</th>
                                    <th scope="col">{$LANG_VAR['soa_ttl']}</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td data-label="Primary Nameserver">
                                        <div class="1">ns1.routedge.net</div>
                                    </td>
                                    <td data-label="Administrator Email">
                                        <div class="1">support@routedge.qa</div>
                                    </td>
                                    <td data-label="Expire">
                                        <div class="1">
                                            7200
                                        </div>
                                    </td>
                                    <td data-label="Retry">
                                        <div class="1">
                                            1800
                                        </div>
                                    </td>
                                    <td data-label="Refresh">
                                        <div class="1">
                                            1209600
                                        </div>
                                    </td>
                                    <td data-label="TTL">
                                        <div class="1">
                                            3600
                                        </div>
                                    </td>
                                </tr>
        
                            </tbody>
                        </table>
                    </div>
                </div>
        
        
            </div>
        
        </div>
    </div>

    <script src="..\modules\addons\manage_dns\templates\clients\js\ajax.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert@2.1.2/dist/sweetalert.min.js"></script>

{else}
    <div class="container">
        <div class="text-center p-5">

            <i class="fas fa-exclamation-circle display-1 font-weight-bold text-primary"></i>
            <h1 class="display-1 font-weight-bold text-primary line-height-reduced mb-5">
                {$LANG_VAR['oops']}
            </h1>
            <h3>{$LANG_VAR['error']}</h3>
            <p>{$LANG_VAR['go_back']}</p>

            <a href="{$systemURL}/clientarea.php?action=domains" class="go-back px-4">
                ‹‹ {$LANG_VAR['navigating']}
            </a>
        </div>
    </div>
{/if}


