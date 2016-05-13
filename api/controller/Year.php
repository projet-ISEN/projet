<?php
/**
 * User: Vincent Riouallon
 * Date: 13/05/2016
 * Time: 09:14
 */

namespace Controllers;

/**
 * Gestion de l'année
 * Class Year
 * @package Year
 */
class Year
{

    /**
     * Send back the current year
     */
    public function currentYear()
    {
        $year = $_SESSION['year'];

        echo json_encode(intval($year));
    }


}
