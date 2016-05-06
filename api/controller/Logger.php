<?php
/**
 * Created by PhpStorm.
 * User: rcd18
 * Date: 06/05/2016
 * Time: 18:23
 */

namespace Controllers;

/**
 * Class Logger
 * @package Controllers
 */
class Logger
{

    /**
     *  Register a message in log table with a type and a message
     */
    public static function log( $type, $msg )
    {
        
    }

    /**
     * Log an information
     * @param $msq
     */
    public static function info ($msq)
    {
        return self::log( 'info', $msq );
    }

    /**
     * Log a warning
     * @param $msq
     */
    public static function warn ($msq)
    {
        return self::log( 'warning', $msq );
    }

    /**
     * Log an error
     * @param $msq
     */
    public static function error ($msq)
    {
        return self::log( 'error', $msq );
    }
}