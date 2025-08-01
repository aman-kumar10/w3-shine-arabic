$(document).ready(function () {
    
    $('#submit_register').click(function(event) {
        event.preventDefault();
        if ($("#frmCheckout").valid()) {
            $("#frmCheckout").submit();
        } else {
            $('html, body').animate({
                scrollTop: $(".error").first().offset().top - 100
            }, 100);
        }
    });

    if ($.fn.validate) {

        $.validator.addMethod("fileSize", function (value, element) {
            console.log(element.files); // Check the files object
            if (element.files && element.files[0]) {
                var fileSize = element.files[0].size;
                var maxSize = 5 * 1024 * 1024; // 5 MB
                return this.optional(element) || fileSize <= maxSize;
            }
            return true;
        }, "The file size must be less than 5 MB.");

        jQuery.validator.addMethod("fileExtension", function (value, element, param) {
            if (element.files.length === 0) {
                return true;
            }   
            const allowedExtensions = param.split('|');
            const fileName = element.files[0].name;
            const fileExtension = fileName.split('.').pop().toLowerCase(); // Extract file extension
    
            return allowedExtensions.includes(fileExtension);
        }, "Invalid file type. Allowed types are: {0}.");

        jQuery.validator.addMethod("regex", function(value, element, regexp) {
            if (regexp.constructor != RegExp) {
                regexp = new RegExp(regexp);
            } else if (regexp.global) {
                regexp.lastIndex = 0;
            }
        
            return this.optional(element) || regexp.test(value);
        }, "Invalid value");

      

        jQuery.validator.addMethod("passwordStrength", function(value, element) {
            if (!/[0-9]/.test(value)) {
                $.validator.messages.passwordStrength = "Password must contain at least one digit";
                return false;
            }
            if (!/[A-Z]/.test(value)) {
                $.validator.messages.passwordStrength = "Password must contain at least one uppercase letter";
                return false;
            }
            if (!/[@#$%^&*()_+!-]/.test(value)) {
                $.validator.messages.passwordStrength = "Password must contain at least one special character";
                return false;
            }
            return true;
        }, "Password is not strong enough");
    

        $("#frmCheckout").validate({
            rules: {
                "firstname": {
                    required: true,
                },
                "lastname": {
                    required: true,
                },
                "city": {
                    required: true,
                },
                "address1": {
                    required: true,
                },
                "state": {
                    required: true,
                },
                "country": {
                    required: true,
                },
                "postcode": {
                    required: true,
                },
                "phonenumber": {
                    required: true,
                    regex: /^[0-9]+$/,
                },
                "email": {
                    required: true,
                    email: true,
                    regex: /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/,
                },
                "password": {
                    required: true,
                    minlength: 8,
                    passwordStrength: true,
                    // regexp: /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/
                },
                "password2": {
                    required: true, 
                    equalTo: "#inputNewPassword1"
                },
                "upload_doc": {
                    // required: true,
                    fileExtension: "doc|docx|pdf|jpeg|jpg|png", 
                    fileSize: true
                }
            },
            messages: {
                "firstname": {
                    required: "First Name is required",
                },
                "lastname": {
                    required: "Last Name is required",
                },
                "city": {
                    required: "City is required",
                },
                "address1": {
                    required: "Street Address is required",
                },
                "state": {
                    required: "State is required",
                },
                "country": {
                    required: "Country selection is required",
                },
                "postcode": {
                    required: "Postcode is required",
                },
                "phonenumber": {
                    required: "Phone Number is required",
                    regex: 'Please enter a valid Number.',
                },
                "email": {
                    required: "Email Address is required",
                    email: "Please enter a valid Email Address",
                    regex: 'Please enter a valid Email Address.',
                },
                "password": {
                    required: "Password is required",
                    minlength: "Password must be at least 8 characters long",
                    regexp: "Password must contain at least one alphabet, one number, and one special character."
                },
                "password2": {
                    required: "Password confirmation is required",
                    equalTo: "Passwords do not match"
                },
                "upload_doc": {  // Custom message for file upload
                     required: "Please select a file",
                   fileExtension: "Only doc, docx, pdf, jpeg, jpg, and png files are allowed.",
                    fileSize: "The file size must be less than 5 MB."
                }
            },
            errorPlacement: function (error, element) {
                error.insertAfter(element);
            }
        });

    }


});