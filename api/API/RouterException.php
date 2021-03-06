<?php
    
namespace API;

use \Exception;
use \Controllers\Logger;

/**
 * Class RouterException
 * @package API
 */
class RouterException extends Exception {

    // Permet d'effectuer une action si aucune des routes n'a matché.
    // Parce que le Router throw une nouvelle exception
    /**
     * RouterException constructor.
     *
     * @param string         $message
     * @param int            $code
     * @param Exception|null $previous
     */
    public function __construct($message, $code = 0, Exception $previous = null)
    {
        parent::__construct($message, $code, $previous);

        Logger::error( json_encode([
            'err'   => $this->message,
            'file'  => $this->file,
            'line'  => $this->line
        ]) );
    }

    /**
     * @return string
     */
    public function __toString() {
        return __CLASS__ . ": [{$this->code}]: {$this->message}\n";
    }
}
?>