<?php
/**
 * Created by PhpStorm.
 * User: rcd18
 * Date: 06/05/2016
 * Time: 18:23
 */

namespace Controllers;

use \DateTime;
use \Models\Log;

/**
 * Class Logger
 * @package Controllers
 */
class Logger
{

    /**
     * [PRIVATE]
     *  Register a message in log table with a type and a message
     * @param $type
     * @param $msg
     *
     * @return array
     */
    private static function log( $type, $msg )
    {
        $log = new Log( null, $type , $msg );
        return $log->save();
    }

    /**
     * Log an information
     * @param $msq
     *
     * @return array
     */
    public static function info( $msq )
    {
        return self::log( 'info', $msq );
    }

    /**
     * Log a warning
     * @param $msq
     *
     * @return array
     */
    public static function warn( $msq )
    {
        return self::log( 'warning', $msq );
    }

    /**
     * Log an error
     * @param $msq
     *
     * @return array
     */
    public static function error( $msq )
    {
        return self::log( 'error', $msq );
    }

    /**
     * Look for all logs between 2 dates
     * @param $start
     * @param $end
     *
     * @return array
     */
    public static function getBetweenDate( $start, $end )
    {
        $startTimestamp = new DateTime($start);
        $endTimestamp   = new DateTime($end);

        // getTimeStamp return value in second, we need it in milli seconds
        $res = Log::searchBetween( $startTimestamp->getTimestamp() * 1000, $endTimestamp->getTimestamp() * 1000 );
        return var_dump($res);
    }

    /**
     * Return the last n logs, default is 20
     * @param int $number
     *
     * @return mixed
     */
    public static function getLastLogs( $number=20 )
    {
        $number = (int) $number;
        if( !is_int($number) or  $number <= 0 ){
            return var_dump([
                'err' => 'Mauvais paramètre'
            ]);
        }
        return var_dump( Log::searchLastLogs($number) );
    }
}