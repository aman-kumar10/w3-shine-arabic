
<section class="page-title service-banner"  >
    <div class="container">

        <div class="title-text text-2">
            <h1>My Documents</h1>
        </div>

    </div>
</section>

<div class="inner-cnt">
    <div class="container">

        <div class="add_documents">
            <h2>Upload Documents</h2>
            <form action="" method="post" enctype="multipart/form-data">
                <div class="row">
                    <!-- Company Documents -->
                    <div class="form-group col-md-4">
                        <label for="company_documents">Document Type</label>
                        <select class="domain_select select_domain_doc form-control" id="company_documents" name="company_documents">
                            <option value="Trade License">{$LANG.configDomainTradeLicense}</option>
                            <option value="Trademark">{$LANG.configDomainTrademark}</option>
                            <option value="Passport">{$LANG.configDomainPassport}</option>
                            <option value="Qatar ID">{$LANG.configDomainQatarId}</option>
                            <option value="Other">{$LANG.configDomainOther}</option>
                        </select>
                        <input type="text" class="domain_select select_domain_val form-control d-none" name="company_document[{$domain.domain}]" placeholder="Enter other document details">
                    </div>
        
                    <div class="form-group col-md-4">
                        <label for="upload_document">Upload Document</label>
                        <input type="file" class="domain_select form-control" id="upload_document" name="upload_document">
                    </div>
        
                    <div class="form-group col-md-4">
                        <label for="expiry_date">Document Expiery Date</label>
                        <input type="date" class="domain_select form-control" id="expiry_date" name="expirey_date">
                    </div>
                </div>
        
                <div class="form-group text-center mt-3">
                    <button type="submit" class="btn btn-primary">Submit</button>
                </div>
            </form>
        </div>
        
        <div class="view_documents">
            <h2>Documents</h2>
            <table id="summaryDomains" class="table table-themed dataTable" style="width: 100%">
                <thead>
                    <tr role="row">
                        <th>Company Name</th>
                        <th>Document/Expirey Date</th>
                    </tr>
                </thead>
                <tbody>
                    {foreach $my_domain_details as $item}
                    <tr>
                        <td>Company Document</td>
                        <td>{$item->company_document}</td>
                    </tr>
                    <tr>
                        <td>Trade Mark</td>
                        <td>{$item->trade_mark}</td>
                    </tr>
                    <tr>
                        <td>Expiry Date</td>
                        <td>{$item->expirey_date}</td>
                    </tr>
                    <tr>
                        <td>Company Name</td>
                        <td>{$item->company_name}</td>
                    </tr>

                    {foreach $item->files as $file}
                        <tr>
                            <td>{$file}</td>
                            <td><a class='' href='/modules/addons/verify_domain_identity/uploadfile/{$file}' download>
                                <span>{$file} <i class="fas fa-download"></i></span></a>
                            </td>
                        </tr>
                    {/foreach}

                    {/foreach}
                </tbody>
            </table>
        </div>

    </div>
</div>