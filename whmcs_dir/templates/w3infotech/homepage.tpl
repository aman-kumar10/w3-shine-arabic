<div class="banner">
   <div class="container">
      <div class="row">
         <div class="col-md-7">
            <div class="bannerf-left">
               <ul class="nav nav-tabs" id="myTab" role="tablist">
                  <li class="nav-item search-nav" role="presentation">
                     <a class="nav-link active" id="home-tab" data-bs-toggle="tab" data-bs-target="#home" type="button" role="tab" aria-controls="home" aria-selected="true">
                        {$LANG.searchDomain}<br>
                     </a>
                  </li>
                  <li class="nav-item" role="presentation">
                     <a class="nav-link" id="profile-tab" data-bs-toggle="tab" data-bs-target="#profile" type="button" role="tab" aria-controls="profile" aria-selected="false">.QA - .COM.QA - .NET.QA... <br><span>قطر., .NAME.QA</span></a>
                  </li>
               </ul>
               <div class="transfer-domain">
                  <a href="{$WEB_ROOT}/cart.php?a=add&domain=transfer">{$LANG.transferDomain}<br><span>{$LANG.transferToRoutedge}</span></a>
               </div>
            </div>
            <div class="tab-content" id="myTabContent">
               <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
                  <div id="Search" class="ft-content active">
                     <div class="searchFrame">
                        <div class="searchBox">
                           <input name="txtDomainName" type="text" placeholder="{$LANG.searchPlaceholder}" id="txtDomainName" class="searchFrametxt" required>
                        </div>
                        <span class="searchFrameSub">
                           <button type="submit" id="Button1" class="searchFrameSubmit">{$LANG.search}</button>
                        </span>
                     </div>
                  </div>
               </div>
               <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">
                  <div class="searchFrame1">
                     <div class="searchBox">
                        <input name="txtIDNDomainName" type="text" id="txtIDNDomainName" placeholder="Type name and choose extension from menu" class="searchFrametxt">
                     </div>
                     <div class="checker">
                        <select name="ddlIDNTLDs" id="ddlIDNTLDs" class="idn-select">
                            <option value=".qa">.qa</option>
                            <option value=".com.qa">.com.qa</option>
                            <option value=".net.qa">.net.qa</option>
                            <option value=".name.qa">.name.qa</option>
                            <option value="قطر.">قطر.</option>
                           <!--
                           <option value=".ഭാരതം">.ഭാരതം</option>
                           <option value=".भारत">.भारत</option>
                           <option value=".ভারত">.ভারত</option>
                           <option value=".భారత్">.భారత్</option>
                           <option value=".ભારત">.ભારત</option>
                           <option value=".بھارت">.بھارت</option>
                           <option value=".இந்தியா">.இந்தியா</option>
                           <option value=".ਭਾਰਤ">.ਭਾਰਤ</option>
                           <option value=".कंपनी.भारत">.कंपनी.भारत</option>
                           <option value=".কোম্পানি.ভারত">.কোম্পানি.ভারত</option>
                           <option value=".కంపెనీ.భారత్">.కంపెనీ.భారత్</option>
                           <option value=".કંપની.ભારત">.કંપની.ભારત</option>
                           <option value=".کمپنی.بھارت">.کمپنی.بھارت</option>
                           <option value=".நிறுவனம்.இந்தியா">.நிறுவனம்.இந்தியா</option>
                           <option value=".ਕੰਪਨੀ.ਭਾਰਤ">.ਕੰਪਨੀ.ਭਾਰਤ</option>
                           <option value=".ಭಾರತ">.ಭಾರತ</option>
                           <option value=".ଭାରତ">.ଭାରତ</option>
                           <option value=".ভাৰত">.ভাৰত</option>
                           <option value=".भारतम्">.भारतम्</option>
                           <option value=".भारोत">.भारोत</option>
                           <option value=".بارت">.بارت</option>
                           <option value=".بھارت">.بھارت</option>
                           <option value=".5g.in">.5g.in</option>
                           <option value=".6g.in">.6g.in</option>
                           <option value=".ai.in">.ai.in</option>
                           <option value=".am.in">.am.in</option>
                           <option value=".bihar.in">.bihar.in</option>
                           <option value=".biz.in">.biz.in</option>
                           <option value=".business.in">.business.in</option>
                           <option value=".cn.in">.cn.in</option>
                           <option value=".co.in">.co.in</option>
                           <option value=".com.in">.com.in</option>
                           <option value=".coop.in">.coop.in</option>
                           <option value=".cs.in">.cs.in</option>
                           <option value=".delhi.in">.delhi.in</option>
                           <option value=".dr.in">.dr.in</option>
                           <option value=".er.in">.er.in</option>
                           <option value=".firm.in">.firm.in</option>
                           <option value=".gen.in">.gen.in</option>
                           <option value=".gujarat.in">.gujarat.in</option>
                           <option value=".in">.in</option>
                           <option value=".ind.in">.ind.in</option>
                           <option value=".info.in">.info.in</option>
                           <option value=".int.in">.int.in</option>
                           <option value=".internet.in">.internet.in</option>
                           <option value=".io.in">.io.in</option>
                           <option value=".me.in">.me.in</option>
                           <option value=".net.in">.net.in</option>
                           <option value=".org.in">.org.in</option>
                           <option value=".pg.in">.pg.in</option>
                           <option value=".post.in">.post.in</option>
                           <option value=".pro.in">.pro.in</option>
                           <option value=".travel.in">.travel.in</option>
                           <option value=".tv.in">.tv.in</option>
                           <option value=".uk.in">.uk.in</option>
                           <option value=".up.in">.up.in</option>
                           <option value=".us.in">.us.in</option>
                           -->
                        </select>
                     </div>
                     <span class="searchFrameSub">
                        <button type="submit" id="Button2" class="searchFrameSubmit">{$LANG.searchFrame}</button>
                     </span>
                  </div>
               </div>
            </div>
            <span id="domain_search_error" class="d-none">Please Enter the domain</span>
            <div class="advance-search mt-4 mb-4">
               <a href="#advance" class="toggle-button" aria-controls="toggle-content">{$LANG.advanceSearch} <span class="fas fa-angle-down"></span></a>
            </div>
         </div>
         <div class="col-md-5">
            <div class="banner-right">
               <div class="accredited">
                  <img src="{$WEB_ROOT}/templates/{$template}/images/accredited-registrar.png">
               </div>
               <div class="slider">
                  <div class="single-item">
                     <div class="item">
                        <img src="{$WEB_ROOT}/templates/{$template}/images/slide1.png">
                     </div>
                     <div class="item">
                        <img src="{$WEB_ROOT}/templates/{$template}/images/slide2.png">
                     </div>
                     <div class="item">
                        <img src="{$WEB_ROOT}/templates/{$template}/images/slide3.svg">
                     </div>
                     <div class="item">
                        <img src="{$WEB_ROOT}/templates/{$template}/images/slide4.png">
                     </div>
                     <div class="item">
                        <img src="{$WEB_ROOT}/templates/{$template}/images/slide5.png">
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </div>
   </div>
</div>
<div class="s-division">
   <div class="container">
      <div class="row">
         <div class="col-12 col-sm-12 col-md-10 col-lg-12 col-xl-9 margin-center">
            <div class="col-6 col-sm-6 col-md-4 col-lg-3 s-icon">
               <h5><span class="portability">
                  <img src="{$WEB_ROOT}/templates/{$template}/images/portability.svg"></span> {$LANG.portability}
               </h5>
            </div>
            <div class="col-6 col-sm-6 col-md-4 col-lg-3 s-icon">
               <h5><span class="portability">
                  <img src="{$WEB_ROOT}/templates/{$template}/images/price_stability.svg"></span> {$LANG.priceStability}
               </h5>
            </div>
            <div class="col-6 col-sm-6 col-md-4 col-lg-3 s-icon">
               <h5><span class="portability">
                  <img src="{$WEB_ROOT}/templates/{$template}/images/free_DNS.svg"></span> {$LANG.advanceDns}
               </h5>
            </div>
            <div class="col-6 col-sm-6 col-md-4 col-lg-3 s-icon">
               <h5><span class="portability">
                  <img src="{$WEB_ROOT}/templates/{$template}/images/free_forwarding.svg"></span> {$LANG.webForwarding}
               </h5>
            </div>
         </div>
      </div>
   </div>
</div>
{include file="$template/includes/filter-domains.tpl"}
<div class="w3-offer">
   <div class="container">
      <div class="row">
         <div class="col-md-5 mb-4">
            <img src="{$WEB_ROOT}/templates/{$template}/images/mic-lady.svg" alt="" title="" class="img-fluid">
         </div>
         <div class="col-md-7">
            <h2>{$LANG.weOffer} <span>{$LANG.bestPrice}</span></h2>
            <p>{$LANG.WeOfferParagraph}</p>
            <div class="ext-spec">
               <p><b>{$LANG.qualtiyassurance}</b></p>
               <ul>
                  <li class="color1">QA QAR <span><i class="icon-rupee-indian"></i>
                     <i class="fa fa-inr"></i>QAR.60/-</span>
                  </li>
                  <li class="color2">.COM.QA <span><i class="icon-rupee-indian"></i>
                     <i class="fa fa-inr"></i>QAR.60/-</span>
                  </li>
                  <li class="color3">.NET.QA <span><i class="icon-rupee-indian"></i>
                     <i class="fa fa-inr"></i>QAR.60/-</span>
                  </li>
                  <li class="color4">.NAME.QA <span><i class="icon-rupee-indian"></i>
                     <i class="fa fa-inr"></i>QAR.60/-</span>
                  </li>
                  <li class="color5">.قطر <span><i class="icon-rupee-indian"></i>
                     <i class="fa fa-inr"></i>QAR.15/-</span>
                  </li>
                  <li class="color2">.COM <span><i class="icon-rupee-indian"></i>
                     <i class="fa fa-inr"></i>QAR.60/-</span>
                  </li>
                  <li class="color6">.NET <span><i class="icon-rupee-indian"></i>
                     <i class="fa fa-inr"></i>QAR.75/-</span>
                  </li>
                  <li class="color7">.ORG <span><i class="icon-rupee-indian"></i>
                     <i class="fa fa-inr"></i>QAR.75/-</span>
                  </li>
                  <li class="color3">.AE <span><i class="icon-rupee-indian"></i>
                     <i class="fa fa-inr"></i>QAR.150/-</span>
                  </li>
                  <li class="color2">.SA <span><i class="icon-rupee-indian"></i>
                     <i class="fa fa-inr"></i>QAR.150/-</span>
                  </li>
                  <li class="color4">.IN <span><i class="icon-rupee-indian"></i>
                     <i class="fa fa-inr"></i>QAR.50/-</span>
                  </li>
                  <li class="color5">.ER.IN <span><i class="icon-rupee-indian"></i>
                     <i class="fa fa-inr"></i>QAR.30/-</span>
                  </li>
               </ul>
            </div>
         </div>
      </div>
   </div>
</div>

<div id="buy" class="hosting-services">
   <div class="container">
      {include file="$template/includes/get-services.tpl"}
   </div>
</div>
<div class="core-area">
   <div class="container">
      <div class="pic_2">
         <img src="{$WEB_ROOT}/templates/{$template}/images/pic_2.svg" class="img-fluid" />
      </div>
      <div class="core-cont">
         <div class="row flex-center h-100">
            <div class="col-12 col-xl-12">
               <div class="row">
                  <div class="col-12 col-sm-6 col-md-3 col-lg-3 px-3 py-3">
                     <div class="card py-4 shadow-sm h-100 hover-top">
                        <div class="text-center">
                           <img src="{$WEB_ROOT}/templates/{$template}/images/domain-reg_i.svg" height="75" alt="">
                           <div class="card-body pt-4 px-4">
                              <h5 class="fw-bold text-1">{$LANG.domainRegistrarQA}</h5>
                              <p class="mb-0">{$LANG.qaPricesStarting} <span>{$LANG.qarPrices}</span></p>
                           </div>
                        </div>
                     </div>
                  </div>
                  <div class="col-12 col-sm-6 col-md-3 col-lg-3 px-3 py-3">
                     <div class="card py-4 shadow-sm h-100 hover-top">
                        <div class="text-center">
                           <img src="{$WEB_ROOT}/templates/{$template}/images/700IDN_i.svg" height="75" alt="">
                           <div class="card-body pt-4 px-4">
                              <h5 class="fw-bold text-2">{$LANG.domainRegistrarCOM}</h5>
                              <p class="mb-0 card-text">{$LANG.comPricesStarting}</p>
                           </div>
                        </div>
                     </div>
                  </div>
                  <div class="col-12 col-sm-6 col-md-3 col-lg-3 px-3 py-3">
                     <div class="card py-4 shadow-sm h-100 hover-top">
                        <div class="text-center">
                           <img src="{$WEB_ROOT}/templates/{$template}/images/cld.png" height="75" alt="">
                           <div class="card-body pt-4 px-4">
                              <h5 class="fw-bold text-7">{$LANG.cloudDocumentationSolution}</h5>
                              <p class="mb-0 card-text">"{$LANG.cloudDocumentationPtag}"</p>
                           </div>
                        </div>
                     </div>
                  </div>
                  <div class="col-12 col-sm-6 col-md-3 col-lg-3 px-3 py-3">
                     <div class="card py-4 shadow-sm h-100 hover-top">
                        <div class="text-center">
                           <img src="{$WEB_ROOT}/templates/{$template}/images/reseller_i.svg" height="75" alt="">
                           <div class="card-body pt-4 px-4">
                              <h5 class="fw-bold text-5">{$LANG.resellerHostingServices}</h5>
                              <p class="mb-0 card-text">{$LANG.resellerHostingServicesPrice}</p>
                           </div>
                        </div>
                     </div>
                  </div>
                  <div class="col-12 col-sm-6 col-md-3 col-lg-3 px-3 py-3">
                     <div class="card py-4 shadow-sm h-100 hover-top">
                        <div class="text-center">
                           <img src="{$WEB_ROOT}/templates/{$template}/images/professional-cloud_i.svg" height="75" alt="">
                           <div class="card-body pt-4 px-4">
                              <h5 class="fw-bold text-6">{$LANG.professionalCloud}</h5>
                              <p class="mb-0 card-text">{$LANG.professionalCloudPtag}</p>
                           </div>
                        </div>
                     </div>
                  </div>
                  <div class="col-12 col-sm-6 col-md-3 col-lg-3 px-3 py-3">
                     <div class="card py-4 shadow-sm h-100 hover-top">
                        <div class="text-center">
                           <img src="{$WEB_ROOT}/templates/{$template}/images/vps_i.svg" height="75" alt="">
                           <div class="card-body pt-4 px-4">
                              <h5 class="fw-bold text-7">{$LANG.vpsServer}</h5>
                              <p class="mb-0 card-text">{$LANG.vpsServerPricesStarting}</p>
                           </div>
                        </div>
                     </div>
                  </div>
                  <div class="col-12 col-sm-6 col-md-3 col-lg-3 px-3 py-3">
                     <div class="card py-4 shadow-sm h-100 hover-top">
                        <div class="text-center">
                           <img src="{$WEB_ROOT}/templates/{$template}/images/ae-qa_i.svg" height="75" alt="">
                           <div class="card-body pt-4 px-4">
                              <h5 class="fw-bold text-6">{$LANG.aeAndSadomainRegis}</h5>
                              <p class="mb-0 card-text">{$LANG.aeAndSadomainRegisPtag}</p>
                           </div>
                        </div>
                     </div>
                  </div>
                  <div class="col-12 col-sm-6 col-md-3 col-lg-3 px-3 py-3">
                     <div class="card py-4 shadow-sm h-100 hover-top">
                        <div class="text-center">
                           <img src="{$WEB_ROOT}/templates/{$template}/images/ssl-certificate_i.svg" height="75" alt="">
                           <div class="card-body pt-4 px-4">
                              <h5 class="fw-bold text-4">{$LANG.sslCertificates}</h5>
                              <p class="mb-0 card-text">{$LANG.sslCertificatesPrice}</p>
                           </div>
                        </div>
                     </div>
                  </div>
                  <div class="col-md-12">
                     <div class="container">
                        <div class="col-md-12 text-center r-more"><a href="#">{$LANG.readMore}</a></div>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </div>
   </div>
</div>
<script>
   $(document).ready(function () {
   
      $('.single-item').slick({
         autoplay: true,
         slidesToScroll: 1,
         dots: true,
         fade:true,
         cssEase: 'linear',
         speed: 400,
         padding:10,
      });
   
   });
</script>