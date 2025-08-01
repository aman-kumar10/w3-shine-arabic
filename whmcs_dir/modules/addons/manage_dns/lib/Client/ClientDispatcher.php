<?php

namespace WHMCS\Module\Addon\ManageDns\Client;

use WHMCS\Module\Addon\ManageDns\Client\Controller;

class ClientDispatcher {

    public function dispatch($action, $parameters)
    {
        if (!$action) {
            // Default to index if no action specified
            $action = 'index';
        }

        $controller = new Controller($parameters);

        // Verify requested action is valid and callable
        if (is_callable(array($controller, $action))) {
            return $controller->$action($parameters);
        }
    }
}