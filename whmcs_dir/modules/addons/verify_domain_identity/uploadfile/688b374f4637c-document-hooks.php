<?php

use WHMCS\ClientArea;
use WHMCS\Authentication\CurrentUser;

if (!defined("WHMCS")) {
    exit("This file cannot be accessed directly");
}
define("avatar_manager_root", __DIR__);


add_hook("ClientAreaPage", 1000, function ($vars) {

    if ($vars["descreplies"]) {


        $admins = [];

        foreach (Illuminate\Database\Capsule\Manager::table("tbladmins")->select("id")->get() as $admin) {
            $admins[nnmgetadminname($admin->id)] = $admin->id;


        }
        $settings = avatar_manager_settings();


        $shape = "";
        if ($settings["avatar_shape"]) {
            $shape = ";border-radius:50px";
        }


        if ($settings["ticket_page"]) {

            foreach ($vars["descreplies"] as $k => $reply) {

                $rel_id = 0;
                $admin_key = "";
                if ($reply["admin"]) {
                    // die('tesr stop');
                    if (isset($admins[$reply["name"]])) {
                        $admin_key = md5($admins[$reply["name"]] . date("Y-m-d"));


                    } else {
                        $admin_key = md5(date("Y-m-d"));
                    }
                    $res[] = $admin_key;
                } elseif ($reply["userid"]) {


                    $client = Illuminate\Database\Capsule\Manager::table("tblclients")->where("id", $reply["userid"])->select("firstname", "id", "lastname", "email")->first();
                    $default_avatar = "client_name";
                    if ($settings["default_avatar"] != $default_avatar) {
                        $default_avatar = $settings["default_avatar"];
                    }
                    $exist_value = "name";
                    $cache_id = md5($client->firstname . " " . $client->lastname);

                    $exist_item = Illuminate\Database\Capsule\Manager::table("nnm_avatar_manager")->where("user_id", $client->id)->where("is_admin", 0)->first();

                    if (!$exist_item) {

                        $exist_value = $default_avatar;

                    } elseif ($exist_item->type == "gravatar") {
                        $cache_id = md5($client->email);
                        $exist_value = "gravatar";
                    } elseif ($exist_item->type == "local" && file_exists(avatar_manager_root . DIRECTORY_SEPARATOR . "uploads" . DIRECTORY_SEPARATOR . $exist_item->value)) {
                        $cache_id = md5(filesize(avatar_manager_root . DIRECTORY_SEPARATOR . "uploads" . DIRECTORY_SEPARATOR . $exist_item->value));
                        $exist_value = "local";
                    }
                }
                $url = rtrim(App::getSystemURL(), "/");


                if ($reply["userid"] && !$reply["admin"]) {

                    $exist_item = Illuminate\Database\Capsule\Manager::table("nnm_avatar_manager")->where("user_id", $client->id)->where("is_admin", 0)->first();



                    if (!$exist_item) {
                        $src = $url . "/modules/addons/avatar_manager/avatar.php?avatar_key=" . md5(date("Y-m-d"));
                        $vars["descreplies"][$k]["requestor"]["name"] = "<span  class=\"avatar_ticket_image\"><img style=\"width:" . (isset($settings["ticket_page_size"]) && $settings["ticket_page_size"] ? intval($settings["ticket_page_size"]) : "35") . "px" . $shape . "\" src=\"" . $src . "\" ></span>" . $vars["descreplies"][$k]["requestor"]["name"];

                    } else {
                        if ($exist_item->value) {
                            $src = $url . "/modules/addons/avatar_manager/avatar.php?cache_id=" . $cache_id . "&method=" . $exist_value;
                            $vars["descreplies"][$k]["requestor"]["name"] = "<span  class=\"avatar_ticket_image\"><img style=\"width:" . (isset($settings["ticket_page_size"]) && $settings["ticket_page_size"] ? intval($settings["ticket_page_size"]) : "35") . "px" . $shape . "\" src=\"" . $src . "\" ></span>" . $vars["descreplies"][$k]["requestor"]["name"];

                        } else {
                            $src = $url . "/modules/addons/avatar_manager/avatar.php?avatar_key=" . md5(date("Y-m-d"));
                            $vars["descreplies"][$k]["requestor"]["name"] = "<span  class=\"avatar_ticket_image\"><img style=\"width:" . (isset($settings["ticket_page_size"]) && $settings["ticket_page_size"] ? intval($settings["ticket_page_size"]) : "35") . "px" . $shape . "\" src=\"" . $src . "\" ></span>" . $vars["descreplies"][$k]["requestor"]["name"];
                        }
                    }

                }


            }
        }


        $exist_item = Illuminate\Database\Capsule\Manager::table("nnm_avatar_manager")->where("user_id", $client->id)->where("is_admin", 0)->first();



        if (!$exist_item) {

            $exist_value = $default_avatar;

        } elseif ($exist_item->type == "gravatar") {
            $cache_id = md5($client->email);
            $exist_value = "gravatar";
        } elseif ($exist_item->type == "local" && file_exists(avatar_manager_root . DIRECTORY_SEPARATOR . "uploads" . DIRECTORY_SEPARATOR . $exist_item->value)) {
            $cache_id = md5(filesize(avatar_manager_root . DIRECTORY_SEPARATOR . "uploads" . DIRECTORY_SEPARATOR . $exist_item->value));
            $exist_value = "local";
        }

        $url = rtrim(App::getSystemURL(), "/");

        $src = $url . "/modules/addons/avatar_manager/avatar.php?avatar_key=" . $res[0];



        return ["replies" => $vars["descreplies"], "descreplies" => $vars["descreplies"], "adminurl" => $src];


    }
});



add_hook("ClientAreaFooterOutput", 1, function ($vars) {

    $settings = avatar_manager_settings();
    if ($settings["ticket_page"] && App::getCurrentFilename() == "viewticket") {
        $file = "view-ticket.js";
        if (file_exists(__DIR__ . DIRECTORY_SEPARATOR . "assets" . DIRECTORY_SEPARATOR . "js" . DIRECTORY_SEPARATOR . "view-ticket-custom.js")) {
            $file = "view-ticket-custom.js";
        }
        $url = rtrim(App::getSystemURL(), "/");
        return "<script src=\"" . $url . "/modules/addons/avatar_manager/assets/js/" . $file . "\"></script>";
    }
});
add_hook("ClientAreaHeadOutput", 1, function ($vars) {

    $settings = avatar_manager_settings();
    if ($settings["ticket_page"] && App::getCurrentFilename() == "viewticket") {
        $file = "view-ticket.css";
        if (file_exists(__DIR__ . DIRECTORY_SEPARATOR . "assets" . DIRECTORY_SEPARATOR . "js" . DIRECTORY_SEPARATOR . "view-ticket-custom.css")) {
            $file = "view-ticket-custom.css";
        }
        $url = rtrim(App::getSystemURL(), "/");
        return "<link href=\"" . $url . "/modules/addons/avatar_manager/assets/css/" . $file . "\" rel=\"stylesheet\" type=\"text/css\" />";
    }
});

add_hook('ClientAreaPage', 1, function ($vars) {
    $CurrentUser = new WHMCS\Authentication\CurrentUser();
    $client = $CurrentUser->client();
    global $smarty;
    if ($client) {
        $settings = avatar_manager_settings();
        if (isset($settings["navbar_avatar"]) && $settings["navbar_avatar"] == "1") {
            $default_avatar = "client_name";
            if ($settings["default_avatar"] != $default_avatar) {
                $default_avatar = $settings["default_avatar"];
            }
            $exist_value = "name";
            $cache_id = md5($client->firstname . " " . $client->lastname);
            $exist_item = Illuminate\Database\Capsule\Manager::table("nnm_avatar_manager")->where("user_id", $client->id)->where("is_admin", "0")->first();
            if (!$exist_item) {
                $exist_value = $default_avatar;
            } elseif ($exist_item->type == "gravatar") {
                $cache_id = md5($client->email);
                $exist_value = "gravatar";
            } elseif ($exist_item->type == "local" && file_exists(avatar_manager_root . DIRECTORY_SEPARATOR . "uploads" . DIRECTORY_SEPARATOR . $exist_item->value)) {
                $cache_id = md5(filesize(avatar_manager_root . DIRECTORY_SEPARATOR . "uploads" . DIRECTORY_SEPARATOR . $exist_item->value));
                $exist_value = "local";
            }
            $url = rtrim(App::getSystemURL(), "/");
            $src = $url . "/modules/addons/avatar_manager/avatar.php?cache_id=" . $cache_id . "&method=" . $exist_value;
            $shape = "";
            if ($settings["avatar_shape"]) {
                $shape = ";border-radius:50px";
            }
            $imageurl = "<img style=\"width:" . (isset($settings["navbar_avatar_size"]) && $settings["navbar_avatar_size"] ? intval($settings["navbar_avatar_size"]) : "30") . "px;padding-right:0px" . $shape . "\" class=\"avatar_manager_image\" src=\"" . $src . "\" alt=\"\">";
            $smarty->assign("imageavtar", $imageurl);

        }
    }
});


function avatar_manager_settings()
{
    $settings = Illuminate\Database\Capsule\Manager::table("nnm_avatar_manager_settings")->pluck("value", "setting");

    if (!is_array($settings)) {
        $settings = $settings->toArray();
    }
    return $settings;
}
function NNMgetAdminName($adminId = 0)
{
    if (!$adminNames) {
        $adminNames = [];
    }
    $adminId = $adminId ?: WHMCS\Session::get("adminid");
    if (!empty($adminNames[$adminId])) {
        return $adminNames[$adminId];
    }
    $data = get_query_vals("tbladmins", "firstname,lastname", ["id" => $adminId]);
    $adminName = trim($data["firstname"] . " " . $data["lastname"]);
    $adminNames[$adminId] = $adminName;
    return $adminName;
}

?>