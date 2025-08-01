<div class="row">
   <h2 class="text-center">{$newVariable} {$LANG.webAndEmailHosting} <span class="cart-i"><span class="icon-cart ms-2"></span><span class="number">2</span></span></h2>
   <div class="wrapper">
      <div class="buy-table100 mb-4">
         <div id="UpdatePanel1">
            <div>
               <table class="buy-table" cellspacing="0" rules="all" border="1" id="GridView2" style="width:100%;border-collapse:collapse;">
                  <tr class="buy-row buy-header">
                     <th class="cell" scope="col">{$LANG.getSericeServices}</th>
                     <th class="cell" scope="col">{$LANG.getSericePlan}</th>
                     <th class="cell" scope="col">{$LANG.getSericeQuantity}</th>
                     <th class="cell" scope="col">{$LANG.getSericeSubscriptionPeriod}</th>
                     <th class="cell" scope="col">{$LANG.getSericePrice}</th>
                  </tr>
                  {foreach $groupProductArray as $key => $groupProduct}
                    <tr class="buy-row {if $groupProduct['group_name'] eq 'DNS Management'} d-none {/if}">
                       <td class="cell" data-title="Services">
                          <span class="text-wr"><input id="GridView2_ctl0{$key}_CheckBox2" class="check_product" type="checkbox" data-id="{$groupProduct['gid']}" name="GridView2$ctl0{$key}$CheckBox2"><label for="GridView2_ctl0{$key}_CheckBox2">{$groupProduct['group_name']}</label></span>
                       </td>
                       <td class="cell" data-title="Plan">
                          <select class="domain_select select_product_plan" id="select_product_plan_{$groupProduct['gid']}">
                              {foreach $groupProduct['products'] as $product}
                                    <option data-price="{$product['pricing'][{$currency->code}]['annually']}" data-period="annually" value="{$product['pid']}">{$product['name']}</option>
                              {/foreach}
                          </select>
                       </td>
                       <td class="cell" data-title="Quantity">
                           <select id="GridView2_ctl0{$groupProduct['gid']}_Quantity" class="domain_select select_product_quantity">
                              <option selected="selected" value="1">1</option>
                              <option value="2">2</option>
                              <option value="3">3</option>
                              <option value="4">4</option>
                              <option value="5">5</option>
                           </select>
                       </td>
                       <td class="cell" data-title="Subscription Period">
                          <select name="GridView2$ctl0{$key}$SubscriptionPeriod" id="GridView2_ctl0{$groupProduct['gid']}_SubscriptionPeriod" class="domain_select select_product_period">
                             <!-- <option selected="selected" data-price="" value="monthly">Monthly</option>
                             <option data-price="" value="quarterly">Quarterly</option>
                             <option data-price="" value="semiannually">Semi-Annually</option> -->
                             <option selected="selected" data-price="" value="annually">Annually</option>
                             <option data-price="" value="biennially">Biennially</option>
                             <option data-price="" value="triennially">Triennially</option>
                          </select>
                       </td>
                       <td class="cell" data-title="Price">
                          <span id="GridView2_ctl0{$key}_lblUnitPrice" class="show_product_plan select_price_{$groupProduct['gid']}" value="{$groupProduct['products'][0]['pricing'][{$currency->code}]['annually']}">{$groupProduct['products'][0]['pricing'][{$currency->code}]['annually']} {$currency->code}</span>
                       </td>
                    </tr>
                  {/foreach}
               </table>
            </div>
            <div class="buy-total">
               <div class="price-grid my-4">
               {$LANG.getSericeTotal}: <span class="total_cart_price">0.00 {$currency->code}</span>
               </div>
               <span class="service_error d-none" style="color:red;">Please select at least one hosting option</span>
            </div>
         </div>
      </div>
      <div class="buy-total">
         <div class="p-sub text-center">
            <button type="submit" name="Button3" id="Button3" class="btn btn-yellow submit_product">{$LANG.getSericeContinue}</button>
         </div>
      </div>
   </div>
</div>

<script>
  $(document).ready(function () {

      var code = '{$currency->code}';
      var systemurl = '{$systemurl}';
      var total_cart_price = 0.00;

      $('.submit_product').on('click', function () {
         
         $(this).html('<i class="fa fa-spinner fa-spin"></i>');
         var groupIds = [];
         var productIds = [];
         var billing_cycles = [];
         var product_quantities = [];

         $('.check_product:checked').each(function() {
            groupIds.push($(this).data('id'));
         });

         if (groupIds.length === 0) {
            $('.service_error').removeClass('d-none');
            $(this).html('Continue');
            return;
         }

         groupIds.forEach(element => {
            var pid = $('#select_product_plan_'+element).find('option:selected').val();
            var billing_period = $('#GridView2_ctl0'+element+'_SubscriptionPeriod').find('option:selected').val();
            var product_quantity = $('#GridView2_ctl0' + element +'_Quantity').find('option:selected').val();
            productIds.push(pid);
            billing_cycles.push(billing_period);
            product_quantities.push(product_quantity);
         });

         var prodcut_val_price = total_cart_price+ ' '+code;

         $.ajax({
            url: '',
            type: 'POST',
            data: { productIds: productIds, total_cart_price:prodcut_val_price, billing_cycles:billing_cycles,product_quantities: product_quantities, action: "insert_products", ajaxcall: true },
            success: function (data) {
               var data = JSON.parse(data);
               
               var redirectUrl = systemurl + 'index.php/store/smarter-mail-cloud/international-5gb-mail-boxes';
               //var redirectUrl = systemurl + 'cart.php?a=view';
               window.location.href = redirectUrl;
            },
            error: function (xhr, status, error) {
               console.error('Failed to load content:', error);
            }
         });

      });

      function updateTotalPrice() {
         var selectedIds = [];
         total_cart_price = 0.00;
         $('.check_product:checked').each(function() {
            selectedIds.push($(this).data('id'));
         });

         if (selectedIds.length > 0) {
            $('.service_error').addClass('d-none');
         }

         selectedIds.forEach(element => {
            var total_price = $('.select_price_' + element).attr('value');
            total_price = parseFloat(total_price);
            if (!isNaN(total_price)) {
               total_cart_price += total_price;
            }
         });
         $('.total_cart_price').text(total_cart_price.toFixed(2) + ' '+code);
      }

      $('.check_product').on('change', function () {
         updateTotalPrice();
      });

      function updatePrice(element, total_price) {
         var formattedPrice = total_price.toFixed(2) + ' '+code;
         var priceSpan = element.closest('tr').find('.show_product_plan');
         priceSpan.text(formattedPrice);
         priceSpan.attr('value', total_price);
         updateTotalPrice();
      }

      function getSelectedPrice(element) {
         var selectedPeriod = element.closest('tr').find('.select_product_period').find('option:selected');
         var selectedPeriodVal = selectedPeriod.val();
         var selectedOption = element.closest('tr').find('.select_product_plan').find('option:selected');
         var selectedPrice;
         if (selectedPeriodVal === "annually") {
            selectedPrice = parseFloat(selectedOption.data('price'));
         } else {
            var pid = selectedOption.val();
            ajaxResponse(pid,selectedPeriodVal);
            return;
         }
         return selectedPrice;
      }

      function handleChange(element) {
         var selectedQuantity = parseFloat(element.closest('tr').find('.select_product_quantity').val());
         var selectedPrice = getSelectedPrice(element);
         if (selectedPrice !== undefined && selectedPrice !== null) {
            var total_price = selectedPrice * selectedQuantity;
            updatePrice(element, total_price);
         }
      }

      $('.select_product_plan').on('change', function () {
         handleChange($(this));
      });

      $('.select_product_quantity').on('change', function () {
         handleChange($(this));
      });

      $('.select_product_period').on('change', function () {
         var selectedPeriod = $(this).val();
         var pid = $(this).closest('tr').find('.select_product_plan').find('option:selected').val();
         $this = $(this);

         var priceSpan = $this.closest('tr').find('.show_product_plan').html('<i class="fa fa-spinner fa-spin"></i>');
         //$('.total_cart_price').html('<i class="fa fa-spinner fa-spin"></i>');
         ajaxResponse(pid,selectedPeriod);
      });

      function ajaxResponse(pid, selectedPeriod) {
         $.ajax({
            url: '',
            type: 'POST',
            data: { pid: pid, selectedPeriod:selectedPeriod, action: "select_period", ajaxcall: true },
            success: function (data) {

            var data = JSON.parse(data);
            var periodPrice = data.price;
            if(periodPrice == "-1.00"){
               periodPrice = 0.00;
            }

            periodPrice = parseFloat(periodPrice);
            $this.find('option:selected').attr('data-price', periodPrice);
            var selectedQuantity = $this.closest('tr').find('.select_product_quantity').val();
            var total_price = periodPrice * selectedQuantity;
            updatePrice($this, total_price);

            },
            error: function (xhr, status, error) {
               console.error('Failed to load content:', error);
            }
         });
      }

  });
</script>