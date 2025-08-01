jQuery(document).ready(function(){
	if(!clientLoggedIn){
		if(jQuery("#order-standard_cart").find(".cart-sidebar").find(".panel-sidebar").length > 0){
			jQuery("#order-standard_cart").find(".cart-sidebar").find(".panel-sidebar").find(".card-header").find(".panel-title").each(function(){
				if(jQuery(this).find("i.panel-minimise").hasClass("minimised")){
					jQuery(this).find("i.panel-minimise").click();
				}        
			});
		}
	}
});
function triggerSearchButtonToggle(obj){
	if(jQuery(obj).find("i").hasClass("fa-search")){
		jQuery(".form-knowldegbase-20i").removeClass("w-hidden");
		jQuery(obj).find("i").removeClass("fas fa-search fa-fw").addClass("fas fa-times fa-fw");
	}else if(jQuery(obj).find("i").hasClass("fa-times")){
		jQuery(".form-knowldegbase-20i").addClass("w-hidden");
		jQuery(obj).find("i").removeClass("fas fa-times fa-fw").addClass("fas fa-search fa-fw");
	}
}
function triggerSearchButtonToggleWithoutLogin(obj){
	if(jQuery(obj).find("i").hasClass("fa-search")){
		jQuery("#nav").addClass("w-hidden");
		jQuery(".form-knowldegbase-20i-without-login").removeClass("w-hidden");
		jQuery(obj).find("i").removeClass("fas fa-search fa-fw").addClass("fas fa-times fa-fw");
	}else if(jQuery(obj).find("i").hasClass("fa-times")){
		jQuery(".form-knowldegbase-20i-without-login").addClass("w-hidden");
		jQuery("#nav").removeClass("w-hidden");
		jQuery(obj).find("i").removeClass("fas fa-times fa-fw").addClass("fas fa-search fa-fw");
	}
}
