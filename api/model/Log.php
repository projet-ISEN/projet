<?php
/**
 * Created by PhpStorm.
 * User: rcd18
 * Date: 06/05/2016
 * Time: 18:30
 */

namespace Models;

use \API\Database;

class Log
{
    public $timestamp;
    public $type;
    public $content;

    public function __construct( $type=null, $content=null )
    {
        $this->type     = empty($type)?     'info'  : $type;
        $this->content  = empty($content)?  ''      : $content;
    }

    public function save()
    {
        
    }

}