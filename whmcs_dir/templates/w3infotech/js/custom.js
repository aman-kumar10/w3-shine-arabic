$(document).ready(function () {

    $('.select_currency').on('change', function () {
        var currency = $(this).val();
        var currentUrl = window.location.href;
        var currentUrl = window.location.href.split('#')[0];
        if (currentUrl.indexOf('?') === -1) {
            window.location.href = currentUrl + '?currency=' + currency;
        } else if (currentUrl.indexOf('currency=') !== -1) {
            window.location.href = currentUrl.replace(/(currency=)[^\&]+/, '$1' + currency);
        } else {
            window.location.href = currentUrl + '&currency=' + currency;
        }
    });

    $('.select_language').on('change', function () {
        var language = $(this).val();
        var currentUrl = window.location.href;
        var currentUrl = window.location.href.split('#')[0];
        if (currentUrl.indexOf('?') === -1) {
            window.location.href = currentUrl + '?language=' + language;
        } else if (currentUrl.indexOf('language=') !== -1) {
            window.location.href = currentUrl.replace(/(language=)[^\&]+/, '$1' + language);
        } else {
            window.location.href = currentUrl + '&language=' + language;
        }
    });

    $('.userCustom').each(function() {
        var dataValue = $(this).data('value');
        var input = $(this).find('input');
        input.attr('placeholder', dataValue);
    });
    
    $('.icon-align-left').click(function(){
        $('body').addClass("offcanvas-menu");
    });
     
    $('.icon-close2').click(function(){
        $('body').removeClass("offcanvas-menu");
    });

    
    
});
$(document).ready(function() {
    function searchDomain() {
        var whois_domain = $('#whois_domain').val();
        var captchaResponse = grecaptcha.getResponse();

        $('#domain-error').hide();
            $('#invalid-domain-error').hide(); 
        $('#captchaError').hide();

        if (whois_domain.trim() === "") {
            $('#domain-error').show();
            return false;
        }

        
        var domainPattern = /^[a-zA-Z0-9-]+\.[a-zA-Z]{2,}$/;  // Simple domain validation regex
        if (!domainPattern.test(whois_domain)) {
            $('#invalid-domain-error').show();
            return false;
        }

        //Validate reCAPTCHA
        if (!captchaResponse) {
            $('#captchaError').show();
            return false;
        }


        $('#search_domain').html('loading..<i class="fa fa-spinner fa-spin"></i>');
        
        $.ajax({
            type: "POST",
            url: '',
            data: { domain: whois_domain, action: "whois_domain", ajaxcall: true,recaptcha_response: captchaResponse },
            success: function(data) {
                $('#search_domain').html("Search Now");
                $('.domain-result').html(data);
                grecaptcha.reset();
            }
        });
    }

    $(document).on('click', '#search_domain', function() {
        
        searchDomain();
    });

    $('#whois_domain').keypress(function(event) {
        if (event.which == 13) {
            event.preventDefault();
            searchDomain();
        }
    });
});
