<?php
require_once("include/fonction.php");
require_once ("include/pdo.php");

include("vues/entete.php") ;

session_start();
$pdo = PdoGsb::getPdoGsb();
$estConnecte = estConnecte();

if(!isset($_REQUEST['uc']) || !$estConnecte){
     $_REQUEST['uc'] = 'connexion';
}	 

$uc = $_REQUEST['uc'];
switch($uc){
	case 'connexion':{
		include("controleurs/connexion.php");
		break;
	}
	case 'gererFrais' :{
		include("controleurs/gererFrais.php");
		break;
	}
	case 'etatFrais' :{
		include("controleurs/etatFrais.php");
		break; 
	}
}
include("vues/pied.php") ;
?>

