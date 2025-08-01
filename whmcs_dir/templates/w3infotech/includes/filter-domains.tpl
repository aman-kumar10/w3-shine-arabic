<div id="serarchID" class="search-grid d-none">

    <div class="container">
        <h3 class="err" id="show_domain_result">

        </h3>
        <div id="UpdatePanel2">

        </div>

        <div id="divTotal" class="total d-none">
           <div class="price-grid mb-4">{$LANG.filerTotal}: <span data-price="0.00" class="total_domain_price">{$currency->code} 0.00</span></div>
            <div class="p-sub text-center">
                <button type="submit" name="Button5" id="Button5" class="btn btn-yellow submit_domain">{$LANG.filerPayAndContn}</button>
            </div>
        </div>

        <span class="domain_submit_error d-none" style="color:red;">Please select at least one domain</span>

    </div>
  
</div>

<div id="advance" class="advance-search-wrap">
    <div class="container">

        <div id="toggle-content" class="toggle-content" aria-hidden="true">

            <div class="toggle-title text-center mb-3">
                <h2 class="mb-2">{$LANG.filerAdvanced} <span>{$LANG.filerSearch}</span></h2>
                <h6> {$LANG.filerEnterDesc} </h6>
            </div>

            <div class="serchr">
                <div class="searchboxr">
                    <input name="advanceSearchDomain" type="text" id="txtDomain" placeholder="Enter Desired Name & Choose Extension below" class="advancer advanceSearchDomain"/>
                    <span id="_submit" style="color:red;"></span>
                </div>
            </div>  

            <div class="clearfix"></div>
            <div id="Panel1">
                <div id="extension" class="panel-group horizontal dark-gray-bg animate-box" data-animate-effect="fadeInBottom">
                    {assign var="counter" value=1}
                    {foreach $tldDomains as $key => $tldDomain}
                        <div class="panel" {if $counter == 1}style="width: 100% !important;"{/if}>
                            <div id="heading{$key}" class="panel-heading acc{$counter}">
                                <a class="collapsed" href="#collapse{$key}" data-toggle="collapse" data-parent="#extension" 
                                   aria-expanded="{if $counter == 1}true{else}false{/if}" role="button">
                                    <h5 class="panel-title">{$key}</h5>
                                </a>
                            </div>
                            <div id="collapse{$key}" class="panel-collapse collapse panel{$key} {if $counter == 1}in{/if}">
                                <div class="panel-body">
                                    {foreach $tldDomain as $item => $tld}
                                    <div class="ticker">
                                        <input name="{$tld}" type="checkbox" class="domainChecks" id="{$item}"/><span>{$tld}</span>
                                    </div>
                                    {/foreach}
                                </div>
                            </div>
                        </div>
                        {assign var="counter" value=$counter+1}
                    {/foreach}
                </div>                
            </div>
            <div class="col-md-12">
                <div class="row">
                    <div class="subbr col-12 col-sm-12 col-md-12 col-lg-12 d-flex justify-content-center">
                        <button type="submit" name="Button4" id="Button4" class="btn btn-yellow advance_search">{$LANG.filerSearchNow}</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>

$(document).ready(function () {

    var code = '{$currency->code}';
    var prefix = '{$currency->prefix}';
    var systemurl = '{$systemurl}';

    var availableDomainData = [];
    var allDomainData = [];
    var displayCounter = 0;
    var suggestionBatchSize = 10;
    var dtype = 'first';

    // First Domain Search

    async function triggerFirstDomainSearch(){
        $(this).html('<i class="fa fa-spinner fa-spin"></i>');
        var domainValue = $('#txtDomainName').val();

        if(domainValue == ""){
            $('#domain_search_error').removeClass('d-none');
            return
        }else{
            $('#domain_search_error').addClass('d-none');
        }

        $('#serarchID').removeClass('d-none');
        $('html, body').animate({
            scrollTop: $('#serarchID').offset().top
        }, 100);

        try {
            await wgsCallAjaxDomainResult(csrfToken, domainValue, 'domain', 'register', '', 10,'first');
            await wgsCallAjaxDomainResult(csrfToken, domainValue, 'suggestions', 'register', '', 10,'first');
        } catch (error) {
            console.error('Error during domain search or suggestions', error);
        }
    }

    $('#Button1').on('click', async function(e) {
        e.preventDefault();
        await triggerFirstDomainSearch();
    });

    $('#txtDomainName').on('keydown', async function(e) {
        if (e.key === 'Enter') {
            e.preventDefault();
            await triggerFirstDomainSearch();
        }
    });


    // Second Domain Search

    async function triggerSecondDomainSearch(){
        $(this).html('<i class="fa fa-spinner fa-spin"></i>');
        var domainValue = $('#txtIDNDomainName').val();
        var checkedDomains = $('#ddlIDNTLDs').val();

        if(domainValue == ""){
            $('#domain_search_error').removeClass('d-none');
            return
        }else{
            $('#domain_search_error').addClass('d-none');
        }

        if(checkedDomains == "قطر."){
            var filterDomain = "قطر";
            domainValue = domainValue + "." +filterDomain;
        }else{
            domainValue = domainValue + checkedDomains;
        }

        $('#serarchID').removeClass('d-none');
        $('html, body').animate({
            scrollTop: $('#serarchID').offset().top
        }, 100);

        try {
            await wgsCallAjaxDomainResult(csrfToken, domainValue, 'domain', 'register', checkedDomains, 10 ,'second');
            await wgsCallAjaxDomainResult(csrfToken, domainValue, 'suggestions', 'register', checkedDomains, 10 ,'second');
        } catch (error) {
            console.error('Error during domain search or suggestions', error);
        }
    }

    $('#Button2').on('click', async function(e) {
        e.preventDefault();
        await triggerSecondDomainSearch();
    });

    $('#txtIDNDomainName').on('keydown', async function(e) {
        if (e.key === 'Enter') {
            e.preventDefault();
            await triggerSecondDomainSearch();
        }
    });

    // Advance Domain Search

    async function triggerAdvanceDomainSearch() {
        $("#_submit").html('');
        var domainValue = $('.advanceSearchDomain').val();
        if (domainValue == "") {
            $("#_submit").html('Please enter the domain name');
            return;
        }
        
        $('.advance_search').html('<i class="fa fa-spinner fa-spin"></i>');
        var checkedDomains = [];
        
        $('.domainChecks:checked').each(function() {
            checkedDomains.push($(this).attr('name'));
        });

        $('#serarchID').removeClass('d-none');
        $('html, body').animate({
            scrollTop: $('#serarchID').offset().top
        }, 100);

        try {
            await wgsCallAjaxDomainResult(csrfToken, domainValue, 'domain', 'register', checkedDomains.join(','), 10,'advance');
            await wgsCallAjaxDomainResult(csrfToken, domainValue, 'suggestions', 'register', checkedDomains.join(','), 10,'advance');
        } catch (error) {
            console.error('Error during domain search or suggestions', error);
        }
    }

    $('.advance_search').on('click', async function(e) {
        e.preventDefault();
        await triggerAdvanceDomainSearch();
    });

    $('.advanceSearchDomain').on('keydown', async function(e) {
        if (e.key === 'Enter') {
            e.preventDefault();
            await triggerAdvanceDomainSearch();
        }
    });


    // Domain suggestions

    $(document).on('click', '#moreSuggestions', function () {
        displayMoreSuggestions();
    });

    async function wgsCallAjaxDomainResult(tokenget, fullDomainName, domaintype, domainresponseFor, tlds, suggestionCounter,dtypeParam) {

        dtype = dtypeParam;

        $("#UpdatePanel2").html('<i class="fa fa-spinner fa-spin"></i>');
        $("#divTotal").addClass("d-none");
        return new Promise((resolve, reject) => {
            $.ajax({
                type: "POST",
                url: 'index.php?rp=/domain/check',
                data: {
                    'token': tokenget,
                    'a': 'checkDomain',
                    'domain': fullDomainName,
                    'type': domaintype,
                },
                success: function (data) {
                    $('#Button1').html('Search');
                    $('#Button2').html('Search');
                    $('.advance_search').html('{$LANG.filerSearchNow}');

                    const priorityList = [
                        "qa", "com.qa", "net.qa", "name.qa", "com", "ae", "in", "sa", "net", "biz", "org"
                    ];

                    if (domaintype === 'domain' || domaintype === 'suggestions') {
                        if (!Array.isArray(data.result)) {
                            data.result = Object.values(data.result);
                        }

                        data.result.sort((a, b) => {
                            const tldA = a.tld.toLowerCase();
                            const tldB = b.tld.toLowerCase();
                            const indexA = priorityList.indexOf(tldA);
                            const indexB = priorityList.indexOf(tldB);

                            if (indexA !== -1 && indexB !== -1) {
                                return indexA - indexB;
                            }

                            if (indexA !== -1) return -1;
                            if (indexB !== -1) return 1;

                            return tldA.localeCompare(tldB);
                        });

                    }

                    if (domaintype === 'domain') {

                        var html = "";


                        $.each(data.result, function (t, n) {

                            if (typeof n === 'string' && n.trim() !== '') {
                                console.log('Error: ' + n);
                                html += "<h3 class='err'><span style='font-style:italic; color:#ff0000;'>" + n + "</span></h3>";
                                $("#show_domain_result").html(html);
                                return;
                            }

                            const searchTld = fullDomainName.includes('.') ? fullDomainName.split('.').pop() : '';

                            if(searchTld !== ""){
                                availableDomainData = data.result;
                            }

                            if(n.isAvailable == false ){

                                if(searchTld !== n.tld && searchTld !== ""){
                                    html += "<h3 class='err'><span style='font-style:italic; color:#ff0000;'>Sorry! " + fullDomainName + " is currently unavailable.</span></h3>";
                                }else{
                                    html += "<h3 class='err'><span style='font-style:italic; color:#ff0000;'>Sorry! " + n.domainName + " is currently unavailable.</span></h3>";
                                }
                            }

                            if (n.isAvailable !== false) {
                                html += "<h3 class='err'><span style='font-style:italic; color:#008000;'>" + n.domainName + "</span> is Available</h3>";
                            }

                        });
                        $("#show_domain_result").html(html);
                    }

                    if (domaintype === 'suggestions') {
                        allDomainData = data.result;
             
                        displayCounter = 0;
                        displayMoreSuggestions();
                    }

                    resolve(data);

                },
                error: function (xhr, status, error) {
                    reject(error);
                }
            });
        });
    }


    function displayMoreSuggestions() {
        var html = "";

        if (displayCounter === 0) {
            html += "<div class='wrap-table100 mb-5'>" +
                        "<div>" +
                            "<table class='grid-table' cellspacing='0' rules='all' border='1' id='GridView1' style='width:100%;border-collapse:collapse;'>" +
                                "<tbody>" +
                                    "<tr class='grid-row grid-header'>" +
                                        "<th class='cell' scope='col'>Domain Name</th>" +
                                        "<th class='cell' scope='col'>Status</th>" +
                                        "<th class='cell' scope='col'>Subscription Period</th>" +
                                        "<th class='cell' scope='col'>Price</th>" +
                                    "</tr>";
        }

        var count_data = 0;
        var totalData = allDomainData.length;

        if (totalData == undefined) {
            allDomainData = Object.values(allDomainData);
        }

        if(availableDomainData.length > 0){
            if(availableDomainData[0].domainName !== allDomainData[0].domainName){
                allDomainData = [...availableDomainData, ...allDomainData];
            }
        }

        totalData = allDomainData.length;

        for (var i = displayCounter; i < displayCounter + suggestionBatchSize && i < totalData; i++) {

            var n = allDomainData[i];
            var dtld = n['tld'];
            var priceGet = n['pricing'][1].register;

            var domain_status = "Available";
            var disable = "";
            var color = "green";
            style = "";
            if (n.isAvailable === false) {
                disable = "disabled";
                domain_status = "Unavailable";
                color = "red";
                style = "cursor: not-allowed;"
            }

            var doptions = "";
            if (dtld === 'qa') {
                doptions += "<option value='1'>1 Year</option>" +
                        "<option value='2'>2 Years</option>" +
                        "<option value='3'>3 Years</option>" +
                        "<option value='4'>4 Years</option>" +
                        "<option value='5'>5 Years</option>";
            } else {
                doptions += "<option value='1'>1 Year</option>" +
                        "<option value='2'>2 Years</option>" +
                        "<option value='3'>3 Years</option>" +
                        "<option value='4'>4 Years</option>" +
                        "<option value='5'>5 Years</option>" +
                        "<option value='6'>6 Years</option>" +
                        "<option value='7'>7 Years</option>" +
                        "<option value='8'>8 Years</option>" +
                        "<option value='9'>9 Years</option>" +
                        "<option value='10'>10 Years</option>";
            }

            html += "<tr class='grid-row search_domain_result' data-tld='"+dtld+"' style='"+style+"'>" +
                        "<td class='cell' data-title='Domain Name'>" +
                            "<span class='text-wr'><input " + disable + " style='"+style+"' id='GridView1_ctl0" + i + "_CheckBox1' class='check_domain' data-id='" + i + "' data-name='" + n.domainName + "' type='checkbox' name='GridView1$ctl0" + i + "$CheckBox1'><label style='"+style+"' for='GridView1_ctl0" + i + "_CheckBox1'>" + n.domainName + "</label></span>" +
                        "</td>" +
                        "<td data-title='Status' class='cell'>" +
                            "<span id='GridView1_ctl0" + i + "_Label1' style='color:" + color + "; text-transform: capitalize;'>" + domain_status + "</span>" +
                        "</td>" +
                        "<td data-title='Subscription Period' class='cell'>" +
                           "<select " + disable + " style='" + style + "' name='GridView1$ctl0" + i + "$ddlYears' id='GridView1_ctl0" + i + "_ddlYears' class='domain_select'>" +
                            doptions +
                            "</select>" +
                        "</td>" +
                        "<td class='cell' data-title='Price'>" +
                            "<span id='GridView1_ctl0" + i + "_lblPrice' class='domain_price price' data-price='" + priceGet + "'>" + priceGet + "</span>" +
                        "</td>" +
                    "</tr>";
            count_data++;
        }

        displayCounter += count_data;

        if (count_data === 0) {
            html += "<tr class='grid-row'><td colspan='4' class='no-data'>Domain name suggestions are not available</td></tr>";
        }

        if (displayCounter === suggestionBatchSize) {
            html += "</tbody></table></div></div><div class='clearfix'></div>";
            $("#UpdatePanel2").html(html);
        } else {
            $("#UpdatePanel2 table tbody").append(html);
        }

        $(".more_suggestion").remove();

        if (displayCounter < totalData) {
            $("#UpdatePanel2").append("<div class='more_suggestion'><p style='cursor:pointer;' id='moreSuggestions'>Give me more suggestions!</p></div>");
        }

        $("#divTotal").removeClass("d-none");


        const firstCheckbox = $("#GridView1 .check_domain").first();
        const firstRowTld = firstCheckbox.closest('.grid-row').data('tld');

        if (firstRowTld === "qa") {
            if (!firstCheckbox.is(":disabled")) {
                firstCheckbox.prop("checked", true).trigger("change");
                const checkboxes = $("#GridView1 .check_domain");
                let qaCheckbox = null;
                let comQaCheckbox = null;
                checkboxes.each(function () {
                    const tld = $(this).closest('.grid-row').data('tld');
                    const isDisabled = $(this).is(":disabled");
                    if (tld === "qa" && !isDisabled) {
                        qaCheckbox = $(this);
                    }
                    if (tld === "com.qa" && !isDisabled) {
                        comQaCheckbox = $(this);
                    }
                });

                if (qaCheckbox) {
                    qaCheckbox.prop("checked", true).trigger("change");
                }
                if (comQaCheckbox) {
                    comQaCheckbox.prop("checked", true).trigger("change");
                }
            }
        } else {
            if (!firstCheckbox.is(":disabled")) {
                firstCheckbox.prop("checked", true).trigger("change");
            }
        }
        

    }

    function updateTotalPrice() {
        var selectedIds = [];
        total_cart_price = 0.00;
        $('.check_domain:checked').each(function() {
            selectedIds.push($(this).data('id'));
        });

        if (selectedIds.length > 0) {
            $('.domain_submit_error').addClass('d-none');
        }

        selectedIds.forEach(element => {
        var total_price = $('#GridView1_ctl0' + element + '_lblPrice').text();
        total_price = parseFloat(total_price.replace(/[^0-9.]/g, ''));
        if (!isNaN(total_price)) {
            total_cart_price += total_price;
        }
        });
        $('.total_domain_price').text(total_cart_price.toFixed(2) + ' '+code);
    }

    $(document).on('change', '.check_domain', function () {
        updateTotalPrice()
    });

    $(document).on('click', '.submit_domain', function () {
        $(this).html('<i class="fa fa-spinner fa-spin"></i>');
        var selectedIds = [];
        var domainNames = [];
        var domainYears = [];
        $('.check_domain:checked').each(function() {
            selectedIds.push($(this).data('id'));
        });

        if (selectedIds.length === 0) {
            $('.domain_submit_error').removeClass('d-none');
            $(this).html('PAY AND CONTINUE');
            return;
        }

        selectedIds.forEach(element => {
            var domain = $('#GridView1_ctl0'+element+'_CheckBox1').data('name');
            var selected_year = $('#GridView1_ctl0'+element+'_ddlYears').find('option:selected').val();
            domainNames.push(domain);
            domainYears.push(selected_year);
        });

        var total_domain = total_cart_price.toFixed(2);


        $.ajax({
            type: "POST",
            url: '',
            data: { domainNames: domainNames,total_domain:total_domain,domainYears: domainYears, action: "insert_domains", ajaxcall: true },
            success:function (data) {
                $('.submit_domain').html('PAY AND CONTINUE');
                localStorage.setItem('lastStep', 'step-1');
                var redirectUrl = systemurl + 'cart.php?a=confdomains';
                window.location.href = redirectUrl;
            }
        });

        return;

        var tokenget = csrfToken;




    });

    $(document).on('change', '.domain_select', function () {
        var selectedQuantity = $(this).val();
        var selectedPrice = $(this).closest('tr').find('.domain_price').data('price');
        if (selectedPrice !== undefined && selectedPrice !== null) {
        selectedPrice = parseFloat(selectedPrice.replace(/[^0-9.]/g, ''));
        var total_price = selectedPrice * selectedQuantity;
        $(this).closest('tr').find('.domain_price').text(prefix + total_price.toFixed(2) + ' '+code);
        updateTotalPrice();
        }
    });

    const button = document.querySelector('.toggle-button');
    button.addEventListener('click', () => {
        const content = document.querySelector('.toggle-content');
        const ariaHidden = content.getAttribute('aria-hidden');
        content.setAttribute('aria-hidden', ariaHidden === 'true' ? 'false' : 'true');
        const btnText = content.getAttribute('aria-hidden') === 'true' ? '' : 'Hide';
        button.innerHTML = btnText+ ' Advance search <span class="fas fa-angle-down"></span>';
    });

    function horizontalAccordion() {
        var panels = $('.panel-group.horizontal').find('.collapse');
        
        if ($(window).width() <= 992) {
            $.each(panels, function (idx, item) {
                $(item).removeClass('width');
                $(item).addClass('height');
                $(item).css({
                    'height': '',
                    'width': ''
                });
            });
        } else {
            $.each(panels, function (idx, item) {
                $(item).removeClass('height');
                $(item).addClass('width');
                $(item).css({
                    'height': '',
                    'width': ''
                });
            });

            var panelGroup = $('.panel-group.horizontal').find('.panel');
            panelGroup.unbind('shown.bs.collapse', handlePanelClick);
            panelGroup.on('shown.bs.collapse', handlePanelClick);
        }
    }

    function handlePanelClick() {
        var panelGroup = $('.panel-group.horizontal .panel');
        $.each(panelGroup, function (idx, panel) {
            $(panel).css('width', '');
        });
        var expandedPanel = $(this).closest('.panel');
        expandedPanel.width('100%');
    }

    function preventSelfCollapsed() {
        $('.panel-group.horizontal a[data-toggle="collapse"]').click(function (event) {
            var _this = $(this);
            var panel = $(_this[0].hash);
            if (panel.length && panel.hasClass('in')) {
                return false;
            } else {
                return true;
            }
        });
    }

    $(document).ready(function () {
        horizontalAccordion();
        preventSelfCollapsed();
    });

    $(window).resize(function () {
        horizontalAccordion();
    });

});

</script>


      