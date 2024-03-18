-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le :  mer. 26 sep. 2018 à 20:11
-- Version du serveur :  10.1.35-MariaDB
-- Version de PHP :  7.2.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `gsb_frais`
--

-- --------------------------------------------------------

--
-- Structure de la table `Comptable`
--

CREATE TABLE `Comptable` (
  `id` char(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `Etat`
--

CREATE TABLE `Etat` (
  `id` char(2) NOT NULL,
  `libelle` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `Etat`
--

INSERT INTO `Etat` (`id`, `libelle`) VALUES
('CL', 'Saisie clôturée'),
('CR', 'Fiche créée, saisie en cours'),
('RB', 'Remboursée'),
('VA', 'Validée et mise en paiement');

-- --------------------------------------------------------

--
-- Structure de la table `FicheFrais`
--

CREATE TABLE `FicheFrais` (
  `idVisiteur` char(4) NOT NULL,
  `mois` char(6) NOT NULL,
  `nbJustificatifs` int(11) DEFAULT NULL,
  `montantValide` decimal(10,2) DEFAULT NULL,
  `dateModif` date DEFAULT NULL,
  `idEtat` char(2) DEFAULT 'CR'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `FicheFrais`
--

INSERT INTO `FicheFrais` (`idVisiteur`, `mois`, `nbJustificatifs`, `montantValide`, `dateModif`, `idEtat`) VALUES
('a131', '201809', 0, '0.00', '2018-09-07', 'CL'),
('a17', '201809', 0, '0.00', '2018-09-07', 'CR');

-- --------------------------------------------------------

--
-- Structure de la table `FraisForfait`
--

CREATE TABLE `FraisForfait` (
  `id` char(3) NOT NULL,
  `libelle` char(20) DEFAULT NULL,
  `montant` decimal(5,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `FraisForfait`
--

INSERT INTO `FraisForfait` (`id`, `libelle`, `montant`) VALUES
('ETP', 'Forfait Etape', '110.00'),
('KM', 'Frais Kilométrique', '0.62'),
('NUI', 'Nuitée Hôtel', '80.00'),
('REP', 'Repas Restaurant', '25.00');

-- --------------------------------------------------------

--
-- Structure de la table `LigneFraisForfait`
--

CREATE TABLE `LigneFraisForfait` (
  `idVisiteur` char(4) NOT NULL,
  `mois` char(6) NOT NULL,
  `idFraisForfait` char(3) NOT NULL,
  `quantite` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `LigneFraisForfait`
--

INSERT INTO `LigneFraisForfait` (`idVisiteur`, `mois`, `idFraisForfait`, `quantite`) VALUES
('a131', '201809', 'ETP', 10),
('a131', '201809', 'KM', 6),
('a131', '201809', 'NUI', 4),
('a131', '201809', 'REP', 44),
('a17', '201809', 'ETP', 0),
('a17', '201809', 'KM', 0),
('a17', '201809', 'NUI', 0),
('a17', '201809', 'REP', 0);

-- --------------------------------------------------------

--
-- Structure de la table `LigneFraisHorsForfait`
--

CREATE TABLE `LigneFraisHorsForfait` (
  `id` int(11) NOT NULL,
  `idVisiteur` char(4) NOT NULL,
  `mois` char(6) NOT NULL,
  `libelle` varchar(100) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `montant` decimal(10,2) DEFAULT NULL,
  `statut` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `LigneFraisHorsForfait`
--

INSERT INTO `LigneFraisHorsForfait` (`id`, `idVisiteur`, `mois`, `libelle`, `date`, `montant`, `statut`) VALUES
(1, 'a131', '201809', 'test', '2018-01-01', '10.00', 1);

-- --------------------------------------------------------

--
-- Structure de la table `StatutHorsForfait`
--

CREATE TABLE `StatutHorsForfait` (
  `id` int(11) NOT NULL,
  `libelle` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `StatutHorsForfait`
--

INSERT INTO `StatutHorsForfait` (`id`, `libelle`) VALUES
(1, 'En attente des justificatifs'),
(2, 'Validée'),
(3, 'Remboursée'),
(4, 'Refusée');

-- --------------------------------------------------------

--
-- Structure de la table `Utilisateur`
--

CREATE TABLE `Utilisateur` (
  `id` char(4) NOT NULL,
  `nom` char(30) DEFAULT NULL,
  `prenom` char(30) DEFAULT NULL,
  `login` char(20) DEFAULT NULL,
  `mdp` char(64) DEFAULT NULL,
  `adresse` char(30) DEFAULT NULL,
  `cp` char(5) DEFAULT NULL,
  `ville` char(30) DEFAULT NULL,
  `dateEmbauche` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `Utilisateur`
--

INSERT INTO `Utilisateur` (`id`, `nom`, `prenom`, `login`, `mdp`, `adresse`, `cp`, `ville`, `dateEmbauche`) VALUES
('a131', 'Villechalane', 'Louis', 'lvillachane', 'ca3983640f22d6a38a0708731ac697146026828b88594f9522ae5517960bd56d', '8 rue des Charmes', '46000', 'Cahors', '2005-12-21'),
('a17', 'Andre', 'David', 'dandre', 'db326140bcd9230558378827ccd72ba2a6cf467012df164589a6a2cf6efeba45', '1 rue Petit', '46200', 'Lalbenque', '1998-11-23'),
('a55', 'Bedos', 'Christian', 'cbedos', 'c24a6c41c1f9a6d765954bcadb0b5ed12f22961f456bd4c6a5dae7fa1d81d6f5', '1 rue Peranud', '46250', 'Montcuq', '1995-01-12'),
('a93', 'Tusseau', 'Louis', 'ltusseau', 'bd443a068fdb33f389707dfddb385fd16566d3611348a409cd596792d8fcfcce', '22 rue des Ternes', '46123', 'Gramat', '2000-05-01'),
('b13', 'Bentot', 'Pascal', 'pbentot', '11a7330008c21df7522ff874fbd167cf8a98856fe13c45c7923f5f1518325900', '11 allée des Cerises', '46512', 'Bessines', '1992-07-09'),
('b16', 'Bioret', 'Luc', 'lbioret', 'c08efda8cb562b7d79936c4734ded379868e42ff0bdf96cc8ac94ea1b4fe251b', '1 Avenue gambetta', '46000', 'Cahors', '1998-05-11'),
('b19', 'Bunisset', 'Francis', 'fbunisset', '208664ccd2db4f7f58f0df4eba78b8159059384953b355318a93d0ea4ac0c48e', '10 rue des Perles', '93100', 'Montreuil', '1987-10-21'),
('b25', 'Bunisset', 'Denise', 'dbunisset', '434af718666e4ebefbc0ae5d42015b56e2712012a2cc3ab8ec39c835bb309bf0', '23 rue Manin', '75019', 'paris', '2010-12-05'),
('b28', 'Cacheux', 'Bernard', 'bcacheux', '875055a600695e938d00bd8a1d6cca06eebe665b82ea8b41c3fc6940b1b159f1', '114 rue Blanche', '75017', 'Paris', '2009-11-12'),
('b34', 'Cadic', 'Eric', 'ecadic', '5fd8bdc58bd679cbaff5a57a0793a557941ce7f9b54d57b53d99d1d3484da2cf', '123 avenue de la République', '75011', 'Paris', '2008-09-23'),
('b4', 'Charoze', 'Catherine', 'ccharoze', 'cdb6e8c49fc10a4bf8c4202fe1eecb19c0ef4e09db104a2680d8467d41975f15', '100 rue Petit', '75019', 'Paris', '2005-11-12'),
('b50', 'Clepkens', 'Christophe', 'cclepkens', '9fb381cc38cb2cac547cc7afbe7a7c02982dfc273fe442ca203dc5c43a416350', '12 allée des Anges', '93230', 'Romainville', '2003-08-11'),
('b59', 'Cottin', 'Vincenne', 'vcottin', '29432ffbf5925b19866299608455647e6cbfca1478c41e5c7674a23974ee5ced', '36 rue Des Roches', '93100', 'Monteuil', '2001-11-18'),
('c14', 'Daburon', 'François', 'fdaburon', '9c35a01d8b014a1b89952b6d3a5622ba1506932e383edb33d3a90105f583b66d', '13 rue de Chanzy', '94000', 'Créteil', '2002-02-11'),
('c3', 'De', 'Philippe', 'pde', 'ccfcb629405918d3ace44cb39814f07d7129dbe2bbb54a51feddff089677776a', '13 rue Barthes', '94000', 'Créteil', '2010-12-14'),
('c54', 'Debelle', 'Michel', 'mdebelle', '77ccec7af00a9d37f1736b5bf30c392369854052057df53f59ad98d3c12b7c81', '181 avenue Barbusse', '93210', 'Rosny', '2006-11-23'),
('d13', 'Debelle', 'Jeanne', 'jdebelle', 'c2e19209ef0e92ddfbb97eacb36133f81a0d01d60a3d0fe9fd489796d6108ff6', '134 allée des Joncs', '44000', 'Nantes', '2000-05-11'),
('d51', 'Debroise', 'Michel', 'mdebroise', 'a1b42e3571f8db835638a69942a0e2a66bf6226651b0b69e32016d21640bf9e9', '2 Bld Jourdain', '44000', 'Nantes', '2001-04-17'),
('e22', 'Desmarquest', 'Nathalie', 'ndesmarquest', 'e1b753b1e71c1fd68bcaa4ce6c06bfd06a085415045b018991445ebd57bf755d', '14 Place d Arc', '45000', 'Orléans', '2005-11-12'),
('e24', 'Desnost', 'Pierre', 'pdesnost', 'd567a0b357c5733c4a591c510a385733fae0131bb34dddf0de66b598f98e714b', '16 avenue des Cèdres', '23200', 'Guéret', '2001-02-05'),
('e39', 'Dudouit', 'Frédéric', 'fdudouit', '4753d3e0cd9c8fe7f0bdd5e2a0e11a4094cdf2d2fb9c24a8bd31846da45a83ad', '18 rue de l église', '23120', 'GrandBourg', '2000-08-01'),
('e49', 'Duncombe', 'Claude', 'cduncombe', '10b32d46710fcd4abf6478879f5e60f3421f6c77b35d974e1a7054028e2c25f4', '19 rue de la tour', '23100', 'La souteraine', '1987-10-10'),
('e5', 'Enault-Pascreau', 'Céline', 'cenault', 'fcc0234e80e200cf77ea48a389c201a40a1c587259fc40b3a0c8a9e1b424ca72', '25 place de la gare', '23200', 'Gueret', '1995-09-01'),
('e52', 'Eynde', 'Valérie', 'veynde', '01b8dffa413efc0eec851396dc3bf303ce56784ade64cd8b46c0245d95b430f1', '3 Grand Place', '13015', 'Marseille', '1999-11-01'),
('f21', 'Finck', 'Jacques', 'jfinck', '2ae0521fb6f6d79e3c3643eb1cd62d3231a66420e441110d816e24dd165572a2', '10 avenue du Prado', '13002', 'Marseille', '2001-11-10'),
('f39', 'Frémont', 'Fernande', 'ffremont', 'cea048b708eb7370885cdfb26d829db686dd3b35afd59a76bf56dfbb5ba492b7', '4 route de la mer', '13012', 'Allauh', '1998-10-01'),
('f4', 'Gest', 'Alain', 'agest', '8c639ef0ee4c3b3ffddb53ee0aefbff6c1d27b5eefcdbf6c3f5245dc8b2f7513', '30 avenue de la mer', '13025', 'Berre', '1985-11-01');

-- --------------------------------------------------------

--
-- Structure de la table `Visiteur`
--

CREATE TABLE `Visiteur` (
  `id` char(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `Visiteur`
--

INSERT INTO `Visiteur` (`id`) VALUES
('a131'),
('a17'),
('a55'),
('a93'),
('b13'),
('b16'),
('b19'),
('b25'),
('b28'),
('b34'),
('b4'),
('b50'),
('b59'),
('c14'),
('c3'),
('c54'),
('d13'),
('d51'),
('e22'),
('e24'),
('e39'),
('e49'),
('e5'),
('e52'),
('f21'),
('f39'),
('f4');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `Comptable`
--
ALTER TABLE `Comptable`
  ADD KEY `FK_COMPTABLE_UTILISATEUR` (`id`);

--
-- Index pour la table `Etat`
--
ALTER TABLE `Etat`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `FicheFrais`
--
ALTER TABLE `FicheFrais`
  ADD PRIMARY KEY (`idVisiteur`,`mois`),
  ADD KEY `idEtat` (`idEtat`);

--
-- Index pour la table `FraisForfait`
--
ALTER TABLE `FraisForfait`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `LigneFraisForfait`
--
ALTER TABLE `LigneFraisForfait`
  ADD PRIMARY KEY (`idVisiteur`,`mois`,`idFraisForfait`),
  ADD KEY `idFraisForfait` (`idFraisForfait`);

--
-- Index pour la table `LigneFraisHorsForfait`
--
ALTER TABLE `LigneFraisHorsForfait`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idVisiteur` (`idVisiteur`,`mois`),
  ADD KEY `FK_LigneHorsForfait_StatutHorsForfait` (`statut`);

--
-- Index pour la table `StatutHorsForfait`
--
ALTER TABLE `StatutHorsForfait`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `Utilisateur`
--
ALTER TABLE `Utilisateur`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `Visiteur`
--
ALTER TABLE `Visiteur`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `LigneFraisHorsForfait`
--
ALTER TABLE `LigneFraisHorsForfait`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `StatutHorsForfait`
--
ALTER TABLE `StatutHorsForfait`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `Comptable`
--
ALTER TABLE `Comptable`
  ADD CONSTRAINT `FK_COMPTABLE_UTILISATEUR` FOREIGN KEY (`id`) REFERENCES `Utilisateur` (`id`);

--
-- Contraintes pour la table `FicheFrais`
--
ALTER TABLE `FicheFrais`
  ADD CONSTRAINT `FicheFrais_ibfk_1` FOREIGN KEY (`idEtat`) REFERENCES `Etat` (`id`),
  ADD CONSTRAINT `FicheFrais_ibfk_2` FOREIGN KEY (`idVisiteur`) REFERENCES `Utilisateur` (`id`);

--
-- Contraintes pour la table `LigneFraisForfait`
--
ALTER TABLE `LigneFraisForfait`
  ADD CONSTRAINT `LigneFraisForfait_ibfk_1` FOREIGN KEY (`idVisiteur`,`mois`) REFERENCES `FicheFrais` (`idVisiteur`, `mois`),
  ADD CONSTRAINT `LigneFraisForfait_ibfk_2` FOREIGN KEY (`idFraisForfait`) REFERENCES `FraisForfait` (`id`);

--
-- Contraintes pour la table `LigneFraisHorsForfait`
--
ALTER TABLE `LigneFraisHorsForfait`
  ADD CONSTRAINT `FK_LigneHorsForfait_StatutHorsForfait` FOREIGN KEY (`statut`) REFERENCES `StatutHorsForfait` (`id`),
  ADD CONSTRAINT `LigneFraisHorsForfait_ibfk_1` FOREIGN KEY (`idVisiteur`,`mois`) REFERENCES `FicheFrais` (`idVisiteur`, `mois`);

--
-- Contraintes pour la table `Visiteur`
--
ALTER TABLE `Visiteur`
  ADD CONSTRAINT `FK_VISITEUR_UTILISATEUR` FOREIGN KEY (`id`) REFERENCES `Utilisateur` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
