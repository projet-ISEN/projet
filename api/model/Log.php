<?php
/**
 * Created by PhpStorm.
 * User: rcd18
 * Date: 06/05/2016
 * Time: 18:30
 */

namespace Models;

use \API\Database;
use \DateTime;

/**
 * Class Log
 * @package Models
 */
class Log
{
    /**
     * Current time
     * @var null
     */
    public $timestamp;
    /**
     * Type of log
     * @var null|string
     */
    public $type;
    /**
     * Content of log
     * @var null|string
     */
    public $content;

    /**
     * Log constructor.
     *
     * @param null $timestamp
     * @param null $type
     * @param null $content
     */
    public function __construct( $timestamp=null, $type=null, $content=null )
    {
        $this->timestamp    = $timestamp;
        $this->type         = empty($type)?     'info'  : $type;
        $this->content      = empty($content)?  ''      : $content;
    }

    /**
     * @return array
     */
    public function save()
    {
        $req = Database::getInstance()->PDOInstance->prepare(
            "INSERT INTO log (timestamp, type, content) VALUES ".
            "( " . (microtime(true) * 10000) . ", :type, :content )"
        );

        if( $req->execute([
            ':type'     => $this->type,
            ':content'  => $this->content
        ]))
        {
            return ['err' => null];
        }
        else {
            return ['err' => "Impossible d'enregistrer ce log."];
        }
    }

    /**
     * Loader
     */
    public function load()
    {
        $res = Database::Select("SELECT * FROM log WHERE timestamp='". $this->timestamp ."'")
            ->fetchAll( \PDO::FETCH_ASSOC )[0];

        // complète le this avec les valeurs récupérées
        foreach( $res as $key => $val ) {
            $this->$key = $val;
        }
    }

    /**
     * Return log in array format
     * @return array
     */
    public function toArray()
    {
        return [
            'timestamp' => $this->timestamp,
            'type'      => $this->type,
            'content'   => $this->content
        ];
    }

    /**
     * Return log in json format
     * @return mixed
     */
    public function toJson()
    {
        return json_encode( $this->toArray() );
    }

    /**
     * Return a Date object from timestamp
     * @return $this
     */
    public function timestampToDate()
    {
        $tmp = new DateTime();
        return $tmp->setTimestamp( $this->timestamp );
    }

    /**
     * Return an array of log Object between 2 dates
     * @param $a
     * @param $b
     *
     * @return array
     */
    public static function searchBetween( $a, $b )
    {
        $logs   = [];
        $req    = Database::Select("SELECT * FROM log WHERE timestamp BETWEEN '". $a ."' AND '". $b ."'");

        foreach ($req as $k) {

            $log = new self( $k->timestamp, $k->type, $k->content );
            array_push($logs, $log);
        }
        return $logs;
    }

    /**
     * Get last n logs
     * @param $number
     *
     * @return array
     */
    public static function searchLastLogs( $number )
    {
        $logs   = [];
        $req    = Database::Select("SELECT * FROM log ORDER BY timestamp DESC LIMIT " . $number);

        foreach ($req as $k) {

            $log = new self( $k->timestamp, $k->type, $k->content );
            array_push($logs, $log);
        }
        return $logs;
    }

    /**
     * [EXPERIMENTAL]
     * Apply a filter on an log array, this return a new array of filtered values
     * @param $logs
     * @param $type
     */
    public static function filterType( $logs, $type ) {
        foreach( $logs as $k ) {
            if( $k->type != $type ){
                unset( $k );
            }
        }
    }
}