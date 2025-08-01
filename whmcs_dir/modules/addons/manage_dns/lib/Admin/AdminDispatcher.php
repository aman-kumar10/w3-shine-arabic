<?php

namespace WHMCS\Module\Addon\ManageDns\Admin;

use WHMCS\Module\Addon\ManageDns\Admin\Controller;

class AdminDispatcher {
    public function dispatch($action, $parameters)
    {
        $controller = new Controller($parameters);
        if (is_callable(array($controller, $action))) {
            $controller->$action($parameters);
        }
        else{
            print '<p>Invalid action requested. Please go back and try again.</p>';
        }
    }
}