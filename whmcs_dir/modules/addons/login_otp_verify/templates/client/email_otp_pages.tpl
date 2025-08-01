 <div class='error-container-otp'>
        {if $error != ''}
            <div class="alert alert-danger" role="alert">{$error}</div>
        {/if}
</div>
<div class="verify-otp">
    <form action="" method="post" style='width:530px; margin:50px auto;'>
        <h3>Validate OTP</h3>
        <input type='text' maxlength="6" minlength="6" name='validateotp' class='form-control' placeholder="Enter Six Digit OTP "><br>

       <div class="loginotp-btn">
            <button class='btn btn-success' value='' id='submitotp'>Validate OTP</button>
            <input type='button' class='btn btn-primary' value='Resend OTP' id='resend_otp' disabled>
       </div>
        
    </form>
</div>

<script>
   $(document).ready(function() {


    // Resend Otp 
    var countdown = localStorage.getItem('otpCountdown') || 30;
    if (countdown > 0) startTimer(countdown);

    $('#resend_otp').click(function() {
        countdown = 30;
        $('#resend_otp').prop('disabled', true);
        startTimer(countdown);
        localStorage.setItem('otpCountdown', countdown);
    });

    function startTimer(time) {
        var timer = setInterval(function() {
            time--;
            $('#resend_otp').val('Resend OTP (' + time + 's)');
            localStorage.setItem('otpCountdown', time);
            if (time <= 0) {
                clearInterval(timer);
                $('#resend_otp').prop('disabled', false).val('Resend OTP');
                localStorage.removeItem('otpCountdown');
            }
        }, 1000);
    }

    if (countdown <= 0) $('#resend_otp').prop('disabled', false).val('Resend OTP');
    // Resend Otp


   extime = {$extime};
   intervalId = setInterval(function () {
                clearInterval(intervalId);
                $('#submitotp').prop('disabled', 'disabled');
                $('.error-container').html(' <div class="alert alert-danger" role="alert">OTP expired; please resend the OTP.</div>');
    },  extime*1000);

    $('#resend_otp').click(function() {
      
        $.ajax({
            type: "POST",
            url: "", // Set the correct endpoint
            data: { action: 'resend_otp' },
            dataType: "json",
            success: function(data) {
                extime = (data.token)*60;
                $('#submitotp').prop('disabled',false);
                $('.error-container').html(' <div class="alert alert-success" role="alert">'+data.message+'</div>');

                intervalId = setInterval(function () {
                            clearInterval(intervalId);
                            $('#submitotp').prop('disabled', 'disabled');
                            $('.error-container').html(' <div class="alert alert-danger" role="alert">OTP expired; please resend the OTP.</div>');
                },  extime*1000);
            },
        });
    });
});

</script>