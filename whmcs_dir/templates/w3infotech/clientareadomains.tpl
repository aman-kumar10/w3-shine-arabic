{if $warnings}
    {include file="$template/includes/alert.tpl" type="warning" msg=$warnings textcenter=true}
{/if}

<div class="container">
<div class="tab-content">
    <div class="tab-pane fade show active" id="tabOverview">
        {include file="$template/includes/tablelist.tpl" tableName="DomainsList" noSortColumns="0, 1" startOrderCol="2" filterColumn="5"}
        <script>
            jQuery(document).ready(function () {
                
                var table = jQuery('#tableDomainsList').show().DataTable();

                {if $orderby == 'domain'}
                    table.order(2, '{$sort}');
                {elseif $orderby == 'regdate' || $orderby == 'registrationdate'}
                    table.order(3, '{$sort}');
                {elseif $orderby == 'nextduedate'}
                    table.order(4, '{$sort}');
                {elseif $orderby == 'autorenew'}
                    table.order(5, '{$sort}');
                {elseif $orderby == 'status'}
                    table.order(6, '{$sort}');
                {/if}
                table.draw();
                jQuery('#tableLoading').hide();
            });
        </script>
        <form id="domainForm" method="post" action="clientarea.php?action=bulkdomain">  

            <div class="custom-tabs theme-default flextabs">

                <div class="view-nav-btns">
                    <a href="#tab-1" class="ft-tab active"><i class="fa fa-align-right" aria-hidden="true" data-type="all"></i>All</a>
                    <a href="#tab-2" class="ft-tab"><i class="fa fa-registered" aria-hidden="true" data-status="Active"></i>Active</a>
                    <a href="#tab-3" class="ft-tab"><i class="fa fa-exclamation" aria-hidden="true" data-status="Pending"></i>Pending</a>
                    <a href="#tab-4" class="ft-tab"><i class="fa fa-exclamation-triangle" aria-hidden="true" data-status="Expired"></i>Expired</a>
                    <a href="#tab-5" class="ft-tab"><i class="fa fa-cogs" aria-hidden="true" data-type="service"></i>Services</a>
                    <a href="#tab-6" class="ft-tab"><i class="fa fa-cogs" aria-hidden="true" data-type="Domain Transfer"></i>Transfer</a>
                </div>
                
            </div>

            <div class="table-container clearfix">
                <table id="tableDomainsList" class="table table-list w-hidden">
                    <thead>
                        <tr>
                            <th class="d-none"></th>
                            <th></th>
                            <th>Domain Name</th>
                            <th>Services</th>
                            <th>{lang key='clientareahostingregdate'}</th>
                            <th>{lang key='clientareahostingnextduedate'}</th>
                            <th>{lang key='domainstatus'}</th>
                            <th>{lang key='domainaction'}</th>
                        </tr>
                    </thead>
                    <tbody>
                    {foreach $services_and_domains as $domain}
                        <tr>
                            <td class="d-none">
                                <a>{$domain.type}</a>
                            </td>
                            <td class="text-center ssl-info" data-element-id="{$domain.id}" data-type="domain" data-domain="{$domain.domain}">
                                {if $domain.sslStatus}
                                    <img src="{$domain.sslStatus->getImagePath()}" width="25" data-toggle="tooltip" title="{$domain.sslStatus->getTooltipContent()}" class="{$domain.sslStatus->getClass()}" width="25">
                                {elseif !$domain.isActive}
                                    <img src="{$BASE_PATH_IMG}/ssl/ssl-inactive-domain.png" width="25" data-toggle="tooltip" title="{lang key='sslState.sslInactiveDomain'}" width="25">
                                {/if}
                            </td>
                            <td>
                                <a>{$domain.domain}</a>
                                {if $domain.type == 'domain'}
                                    <small {if $domain.autorenew} class="renew_successs" {else} class="renew_danger" {/if}>               
                                        {lang key='domainsautorenew'}
                                    </small>
                                {/if}
                            </td>
                            <td>
                                <a>{$domain.services}</a>
                            </td>
                            <td><span class="w-hidden">{$domain.normalisedRegistrationDate}</span>{$domain.registrationdate}</td>
                            <td><span class="w-hidden">{$domain.normalisedNextDueDate}</span>{$domain.nextduedate}</td>
                            <td>
                                <span class="label status status-{$domain.statusClass}">{$domain.statustext}</span>
                                <span class="w-hidden">
                                    {if $domain.expiringSoon}<span>{lang key="domainsExpiringSoon"}</span>{/if}
                                </span>
                            </td>
                            <td>
                                {if $domain.type == 'domain'}
                                <a href="/clientarea.php?action=domaindetails&id={$domain.id}" type="button" class="btn btn-default">
                                    {lang key='domainmanage'}
                                </a>
                                {else}
                                <a href="clientarea.php?action=productdetails&id={$domain.id}" type="button" class="btn btn-default">
                                    {lang key='domainmanage'}
                                </a>
                                {/if}
                            </td>
                        </tr>
                    {/foreach}
                    </tbody>
                </table>
                <div class="text-center" id="tableLoading">
                    <p><i class="fas fa-spinner fa-spin"></i> {lang key='loading'}</p>
                </div>
            </div>
        </form>
    </div>
</div>
</div>

<script>
    jQuery(document).ready(function () {

        if (!jQuery.fn.DataTable.isDataTable('#tableDomainsList')) {
            jQuery('#tableDomainsList').DataTable({
                responsive: true,
                autoWidth: false,
            });
        }

        jQuery(".view-nav-btns a").click(function (e) {
            e.preventDefault();

            var $this = jQuery(this),
                dataType = $this.find("i").data("type") || null,
                dataStatus = $this.find("i").data("status") || null,
                dataTable = jQuery('#tableDomainsList').DataTable();

            jQuery('.view-nav-btns a').removeClass('active');
            $this.addClass('active');
            dataTable.search('').columns().search('');

            if (dataType === "all") {
                dataTable.draw();
            } else if (dataType === "service") {
                dataTable.column(0).search('service', true, false).draw();
            } else if (dataType === "Domain Transfer") {
                dataTable.column(3).search('Domain Transfer', true, false).draw();
            } else if (dataStatus) {
                dataTable.column(6).search(dataStatus, true, false).draw();
            } else {
                dataTable.draw();
            }
        });
    });
</script>




