<?php
/**
 * Created by PhpStorm.
 * User: rcd18
 * Date: 09/05/2016
 * Time: 14:20
 */

namespace Controllers;


class NotationProf
{
    /**
     * Attribue une note a un club
     * @param $id_club
     */
    public static function setNote( $id_club ){

        // Test des droits du prof
        $club = new \Models\Club($id_club);
        if( !in_array( $club, \Models\Club::getMyClubsForEvaluator() ) )
        {
            $err = "Ce n'est pas votre club";
        }
        else {

            $post = json_decode( file_get_contents("php://input"), true);

            // Test de la note envoyée
            if( empty($post['note']) && is_float($post['note']) )
            {
                $err = 'Vous devez envoyer une note valide.';
            }
            else{

                $note = floatval($post['note']);

                if( $note < 0 || $note > 20 )
                {
                    $err = 'La note doit être comprise entre 0 et 20';
                }
                else
                {
                    $tmp = new \Models\NoteClub( $id_club );
                    $tmp->note_club = $post['note'];
                    if( $tmp->save() ) {
                        $err = null;
                    }
                    else {
                        $err = "Impossible d'enregistrer cette note";
                    }
                }
            }
        }
        echo json_encode([
            "err" => $err
        ]);
        return;
    }

    /**
     * Return all notes of club for a teacher
     * or one if club_id is set
     * @param null $club_id
     */
    public static function allNotes( $club_id=null )
    {
        $year = $_SESSION['year'];

        if( empty($club_id) )
        {
            $notes = [];

            foreach( \Models\Club::getMyClubsForEvaluator() as $club ) {

                $tmp = new \Models\NoteClub( $club->club_id );
                $tmp->load();
                //var_dump($tmp);

                $justNote = [
                    "club_id"       => $tmp->club_id,
                    "note"          => $tmp->note_club,
                    "school_year"   => $tmp->school_year,
                ];

                array_push( $notes, $justNote );
            }
            echo json_encode( $notes );

        }
        else
        {
            $tmp = new \Models\NoteClub($club_id);
            $tmp->load();
            $justNote = [
                "club_id"       => $tmp->club_id,
                "note"          => $tmp->note_club,
                "school_year"   => $tmp->school_year,
            ];
            echo json_encode( $justNote );
        }
        return;
    }

    /**
     * Retourne toutes les notes des élèves d'un évaluateur sous forme de fichier Excel
     */
    public function toXlsx() {

        notes = [];
        $members = [];
        /**
         * Récupère tous les membres qui dépendent d'un evaluateur
         * @var  $club */
        foreach( \Models\Club::getMyClubsForEvaluator() as $club )
        {
            $members = array_merge( $members, $club->getMembers() );
        }
        foreach ($members as $member)
        {
            $member->load();
            $user = new \Models\User( $member->login );
            $user->load();
            
            $notes[]
            
        }
        $E = new \API\Excel( 'Notes clubs ' . $_SESSION['year'] );
    }
}