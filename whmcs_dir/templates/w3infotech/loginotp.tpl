<div class="verify-otp">
    <form action="" method="post" >
        <h3>Validate OTP</h3>
        <div class='error-container'>
        {if $error != ''}
            <div class="alert alert-danger" role="alert">{$error}</div>
        {/if}
        </div>
        <input type='text' maxlength="6" minlength="6" name='validateotp' class='form-control' placeholder="Enter Six Digit OTP "><br>
            <input type='submit' class='btn btn-success' value='Validate OTP'>
            <input type='button' class='btn btn-primary' value='Resend OTP' id='resend_otp' disabled>    
       
        
    </form>
</div>

<script>
   $(document).ready(function() {
    var countdown = 30;
    $('#resend_otp').prop('disabled', true);
    var timer = setInterval(function() {
        countdown--;
        $('#resend_otp').val('Resend OTP (' + countdown + 's)');
        if (countdown <= 0) {
            clearInterval(timer);
            $('#resend_otp').prop('disabled', false);
            $('#resend_otp').val('Resend OTP');
        }
    }, 1000);


    $('#resend_otp').click(function() {
        $.ajax({
            type: "POST",
            url: "", // Set the correct endpoint
            data: { action: 'resend_otp' },
            dataType: "json",
            success: function(data) {
                $('.error-container').html(' <div class="alert alert-success" role="alert">'+data.message+'</div>');
            },
        });
    });
});
</script>