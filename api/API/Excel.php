<?php
/**
 * Created by PhpStorm.
 * User: rcd18
 * Date: 10/05/2016
 * Time: 14:14
 */

namespace API;

require_once( '../../PHPExcel/Classes/PHPExcel.php' );
require_once( '../../PHPExcel/Classes/PHPExcel/Writer/Excel2007.php' );

use \PHPExcel;
use \PHPExcel_Writer_Excel2007;

/**
 * Class Excel
 * @package API
 */
class Excel
{
    /**
     * PHPExcel object
     * @var PHPExcel
     */
    public $file;
    /**
     * Filename of the new Excel sheet
     * @var string
     */
    public $name;

    /**
     * Excel constructor.
     *
     * @param string $name
     */
    public function __construct( $name="My_excel" )
    {
        $this->name = $name;

        $this->file = new PHPExcel();
        $this->file->getProperties()->setCreator( $_SESSION['user']->user_name . ' ' . $_SESSION['user']->user_firstname );
        $this->file->getProperties()->setTitle( $name );
    }

    /**
     * Send an Excel to client, with goog Headers
     * @throws \PHPExcel_Writer_Exception
     */
    public function send()
    {
        // We'll be outputting an excel file
        header('Content-type: application/vnd.ms-excel');
        // It will be called file.xls
        header('Content-Disposition: attachment; filename="' . $this->name . '.xlsx"');
        // Write file to the browser


        $objWriter = new PHPExcel_Writer_Excel2007( $this->file );
        ob_end_clean();

        $objWriter->save( 'php://output' );
        die();
    }

}
