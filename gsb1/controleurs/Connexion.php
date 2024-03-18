<?php
if(!isset($_REQUEST['action'])){
	$_REQUEST['action'] = 'demandeConnexion';
}
$action = $_REQUEST['action'];
switch($action){
	case 'demandeConnexion':{
		include("vues/connexion.php");
		break;
	}
	case 'valideConnexion':{
		$login = $_REQUEST['login'];
		$mdp = crypterMdp($_REQUEST['mdp']);
		$visiteur = $pdo->getInfosVisiteur($login,$mdp);
		
		if(!is_array($visiteur)){
			ajouterErreur("Login ou mot de passe incorrect");
			include("vues/erreurs.php");
			include("vues/connexion.php");
		}
		else{
			$id = $visiteur['id'];
			$nom =  $visiteur['nom'];
			$prenom = $visiteur['prenom'];
			$compta = $visiteur['compta'];
			connecter($id,$nom,$prenom, $compta);
			include("vues/sommaire.php");
		}
		break;
	}
	default :{
		include("vues/connexion.php");
		break;
	}
}
?>
