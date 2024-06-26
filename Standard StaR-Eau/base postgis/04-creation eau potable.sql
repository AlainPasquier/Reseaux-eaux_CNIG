/*
 * 04-creation eau potable.sql
 * 
 * Copyright 2023 Alain <>
 * 
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
 * MA 02110-1301, USA.
 * 
 * 02.11.2023
 */

---CANALISATION 

CREATE TABLE "stareau_aep".aep_canalisation (
	fonction_canalisation text NOT NULL, -- >fonction canalisation dans le réseau
	contenu_canalisation text NOT NULL, -- >type d'eau transportée
	protection_cathodique text NULL, -- >presence protection cathodique
	etage_pression text NULL, -- reference etage de pression
	type_pression text NOT NULL, -- >pression de distribution  
	secteur_hydraulique text NULL, -- secteur ou ilot de distribution
	ref_udi text NULL, -- référence unité de distribution (référence ARS)
	cote_debut float4 NULL, -- cote de la génératrice superieure
	cote_fin float4 NULL -- cote génératrice supérieure
)
INHERITS ("stareau_principale".canalisation,"stareau_principale".dimension);
COMMENT ON TABLE "stareau_aep".aep_canalisation IS 'assemblage de tuyau, de leurs pièces et des ouvrages qui permet les transport des eaux entre deux points';

-- Column comments

COMMENT ON COLUMN "stareau_aep".aep_canalisation.fonction_canalisation IS '>fonction canalisation dans le réseau';
COMMENT ON COLUMN "stareau_aep".aep_canalisation.contenu_canalisation IS '>type d''eau transportée';
COMMENT ON COLUMN "stareau_aep".aep_canalisation.protection_cathodique IS '>presence protection cathodique';
COMMENT ON COLUMN "stareau_aep".aep_canalisation.etage_pression IS 'reference etage de pression';
COMMENT ON COLUMN "stareau_aep".aep_canalisation.secteur_hydraulique IS 'secteur ou ilot de distribution';
COMMENT ON COLUMN "stareau_aep".aep_canalisation.ref_udi IS 'référence unité de distribution (référence ARS)';
COMMENT ON COLUMN "stareau_aep".aep_canalisation.cote_debut IS 'cote de la génératrice superieure';
COMMENT ON COLUMN "stareau_aep".aep_canalisation.cote_fin IS 'cote génératrice supérieure';
COMMENT ON COLUMN "stareau_aep".aep_canalisation.type_pression IS '>pression de distribution';

--CAPTAGE

CREATE TABLE "stareau_aep".aep_captage (
	id_aep_captage serial4 NOT NULL,
	nom_usuel text NULL, -- nom d'usage
	type_captage text NOT NULL, -- type de captage
	nom_ressource text NULL, -- nom ressource
	type_ressource text NOT NULL, -- type de ressource
	ref_aac text NULL, -- reference aire alimentation captage
	ref_dup text NULL, -- référence arrêté autorisation 
	debit_max_autorise text NULL -- Débit max autorisé mentionné dans la DUP, accompagné de son unité
)
INHERITS ("stareau_principale".noeud_reseau);
COMMENT ON TABLE "stareau_aep".aep_captage IS 'Ouvrage de prélèvement exploitant une ressource en eau, que ce soit en surface (prise d''eau en rivière) ou dans le sous-sol (forage ou puit atteignant un aquifère';

-- Column comments

COMMENT ON COLUMN "stareau_aep".aep_captage.nom_usuel IS 'nom d''usage';
COMMENT ON COLUMN "stareau_aep".aep_captage.type_captage IS '>type de captage';
COMMENT ON COLUMN "stareau_aep".aep_captage.nom_ressource IS 'nom ressource';
COMMENT ON COLUMN "stareau_aep".aep_captage.type_ressource IS '>type de ressource';
COMMENT ON COLUMN "stareau_aep".aep_captage.ref_aac IS 'reference aire alimentation captage';
COMMENT ON COLUMN "stareau_aep".aep_captage.ref_dup IS 'référence arrêté autorisation ';
COMMENT ON COLUMN "stareau_aep".aep_captage.debit_max_autorise IS 'Débit max autorisé mentionné dans la DUP, accompagné de son unité';


--- RESERVOIR

CREATE TABLE "stareau_aep".aep_reservoir (
	id_aep_reservoir serial4 NOT NULL,
	nom_usuel text NULL, -- nom d'usage
	type_reservoir text NOT NULL, -- >type réservoir
	nb_cuves int2 NOT NULL DEFAULT 1, -- nombre de cuves
	volume_utile int2 NULL, -- volume total utile m3
	cote_sol float4 NULL, -- cote NGF sol du reservoir
	cote_radier float4 NULL, -- cote NGF du fond de cuve la plus basse
	cote_trop_plein float4 NULL, -- cote NGF du trop-plein
	telegestion text NULL -- >présence d'une gestion à distance
)
INHERITS ("stareau_principale".noeud_reseau,"stareau_principale".dimension);
COMMENT ON TABLE "stareau_aep".aep_reservoir IS 'installation destinée au stockage de l''eau';

-- Column comments

COMMENT ON COLUMN "stareau_aep".aep_reservoir.nom_usuel IS 'nom d''usage';
COMMENT ON COLUMN "stareau_aep".aep_reservoir.type_reservoir IS '>type réservoir';
COMMENT ON COLUMN "stareau_aep".aep_reservoir.nb_cuves IS 'nombre de cuves';
COMMENT ON COLUMN "stareau_aep".aep_reservoir.volume_utile IS 'volume total utile m3';
COMMENT ON COLUMN "stareau_aep".aep_reservoir.cote_sol IS 'cote NGF sol du reservoir';
COMMENT ON COLUMN "stareau_aep".aep_reservoir.cote_radier IS 'cote NGF du fond de cuve la plus basse';
COMMENT ON COLUMN "stareau_aep".aep_reservoir.cote_trop_plein IS 'cote NGF du trop-plein';
COMMENT ON COLUMN "stareau_aep".aep_reservoir.telegestion IS '>présence d''une gestion à distance';


--TRAITEMENT (UP)

CREATE TABLE "stareau_aep".aep_traitement (
	id_aep_traitement serial4 NOT NULL,
	nom_usuel text NULL, -- nom d'usage
	fonction_traitement text NOT NULL, -- >fonction traitement
	type_desinfection text NOT NULL, -- >type désinfection
	capacite float4 NULL, -- capacité de traitement m3/j
	debit_ref float4 NULL, -- débit de référence m3/j
	telegestion varchar NULL -- >présence d'une gestion à distance
)
INHERITS ("stareau_principale".noeud_reseau);
COMMENT ON TABLE "stareau_aep".aep_traitement IS 'ensemble des installations chargées de traiter les eaux brutes en vue de leur potabilisation et distribution';

-- Column comments

COMMENT ON COLUMN "stareau_aep".aep_traitement.nom_usuel IS 'nom d''usage';
COMMENT ON COLUMN "stareau_aep".aep_traitement.fonction_traitement IS '>fonction traitement';
COMMENT ON COLUMN "stareau_aep".aep_traitement.type_desinfection IS '>type désinfection';
COMMENT ON COLUMN "stareau_aep".aep_traitement.capacite IS 'capacité de traitement m3/j';
COMMENT ON COLUMN "stareau_aep".aep_traitement.debit_ref IS 'débit de référence m3/j';
COMMENT ON COLUMN "stareau_aep".aep_traitement.telegestion IS '>présence d''une gestion à distance';

--POINT DE MESURE

CREATE TABLE stareau_aep.aep_point_mesure (
  id_aep_point_mesure serial4 NOT NULL,
  nom_usuel text NULL,
  type_point_mesure text NOT NULL, -- >type point de mesure*
  fonction_point_mesure text NOT NULL, -- >fonction point de mesure*
  calibre float4 NULL, -- calibre/diametre
  annee_fabrication int4 NULL, -- année fabrication
  marque text NULL, -- marque compteur
  numero_serie text NULL, -- numéro série
  telegestion text NULL -- >présence d'une gestion à distance
)
INHERITS (stareau_principale.noeud_reseau);
COMMENT ON TABLE stareau_aep.aep_point_mesure IS 'table des point de mesure (compteurs) sur réseaux';

COMMENT ON COLUMN stareau_aep.aep_point_mesure.type_point_mesure IS '>type point de mesure*';
COMMENT ON COLUMN stareau_aep.aep_point_mesure.fonction_point_mesure IS '>fonction point de mesure*';
COMMENT ON COLUMN stareau_aep.aep_point_mesure.calibre IS 'calibre/diametre';
COMMENT ON COLUMN stareau_aep.aep_point_mesure.annee_fabrication IS 'année fabrication';
COMMENT ON COLUMN stareau_aep.aep_point_mesure.marque IS 'marque compteur';
COMMENT ON COLUMN stareau_aep.aep_point_mesure.numero_serie IS 'numéro série';
COMMENT ON COLUMN stareau_aep.aep_point_mesure.telegestion IS '>présence d''une gestion à distance';

--- VANNE

CREATE TABLE "stareau_aep".aep_vanne (
	id_aep_vanne serial4 NOT NULL,
	type_vanne text NOT NULL, -- type_vanne
	fonction_vanne text NOT NULL, -- fonction vanne
	diametre float4 NULL, -- diametre nominal
	sens_fermeture text NOT NULL, -- sens fermeture
	etat_ouverture text NOT NULL, -- état ouverture
	motorisation bool NULL, -- motorisation
	telegestion text NULL -- gestion à distance
)
INHERITS ("stareau_principale".noeud_reseau);
COMMENT ON TABLE "stareau_aep".aep_vanne IS 'Appareillage capable d''intercepter ou laisser libre le passage de l''eau dans le réseau, hors régulation.';


COMMENT ON TABLE "stareau_aep".aep_vanne IS 'vanne réseau';
COMMENT ON COLUMN "stareau_aep".aep_vanne.type_vanne IS '>type_vanne';
COMMENT ON COLUMN "stareau_aep".aep_vanne.fonction_vanne IS '>fonction vanne';
COMMENT ON COLUMN "stareau_aep".aep_vanne.diametre IS 'diametre nominal';
COMMENT ON COLUMN "stareau_aep".aep_vanne.sens_fermeture IS 'sens fermeture*';
COMMENT ON COLUMN "stareau_aep".aep_vanne.etat_ouverture IS 'état ouverture*';
COMMENT ON COLUMN "stareau_aep".aep_vanne.motorisation IS 'motorisation';
COMMENT ON COLUMN "stareau_aep".aep_vanne.telegestion IS 'présence d''une gestion à distance';

--REGULATION

CREATE TABLE "stareau_aep".aep_regulation (
	id_aep_regulation serial4 NOT NULL,
	nom_usuel text NULL, -- nom usage
	type_regulation text NOT NULL, -- type régulation*
	type_consigne text NOT NULL, -- type consigne*
	consigne_amont float4 NULL, -- consigne en amont
	consigne_aval float4 NULL, -- consigne en aval
	marque text NULL, -- marque de l'appareil
	diametre float4 NULL, -- diametre nominal
	annee_fabrication int2 NULL, -- année de fabrication
	telegestion text NULL -- telegestion/telereleve*
)
INHERITS ("stareau_principale".noeud_reseau);

COMMENT ON TABLE "stareau_aep".aep_regulation IS 'appareil de régulation du débit ou de la pression';
COMMENT ON COLUMN "stareau_aep".aep_regulation.nom_usuel IS 'nom usage';
COMMENT ON COLUMN "stareau_aep".aep_regulation.type_regulation IS '>type régulation';
COMMENT ON COLUMN "stareau_aep".aep_regulation.type_consigne IS '>type consigne';
COMMENT ON COLUMN "stareau_aep".aep_regulation.consigne_amont IS 'consigne en amont';
COMMENT ON COLUMN "stareau_aep".aep_regulation.consigne_aval IS 'consigne en aval';
COMMENT ON COLUMN "stareau_aep".aep_regulation.marque IS 'marque de l''appareil';
COMMENT ON COLUMN "stareau_aep".aep_regulation.diametre IS 'diametre nominal';
COMMENT ON COLUMN "stareau_aep".aep_regulation.annee_fabrication IS 'année de fabrication';
COMMENT ON COLUMN "stareau_aep".aep_regulation.telegestion IS '>présence d''une gestion à distance';
  
--POMPAGE

CREATE TABLE "stareau_aep".aep_pompage (
	id_aep_pompage serial4 NOT NULL, -- identifiant
	nom_usuel text NULL, -- nom d'usage
	fonction_pompage text NOT NULL, -- >fonction du pompage
	installation_pompage text NOT NULL, -- >mode installation
	nb_pompes int2 NULL, -- nombre de pompes
	capacite float4 NULL, -- capacite nominale de pompage m3/j
	telegestion text NULL
)
INHERITS ("stareau_principale".noeud_reseau);
COMMENT ON TABLE "stareau_aep".aep_pompage IS 'ensemble des dispositifs permettant d''aspirer, de refouler ou de comprimer des eaux';

-- Column comments
COMMENT ON COLUMN "stareau_aep".aep_pompage.id_aep_pompage IS 'identifiant';
COMMENT ON COLUMN "stareau_aep".aep_pompage.nom_usuel IS 'nom d''usage';
COMMENT ON COLUMN "stareau_aep".aep_pompage.fonction_pompage IS '>fonction du pompage';
COMMENT ON COLUMN "stareau_aep".aep_pompage.installation_pompage IS '>mode installation';
COMMENT ON COLUMN "stareau_aep".aep_pompage.nb_pompes IS 'nombre de pompes';
COMMENT ON COLUMN "stareau_aep".aep_pompage.capacite IS 'capacité nominale de pompage m3/j';
COMMENT ON COLUMN "stareau_aep".aep_pompage.telegestion IS '>présence d''une gestion à distance';

--APPAREILLAGE
CREATE TABLE "stareau_aep".aep_appareillage (
	id_aep_appareillage serial4 NOT NULL,
	type_appareillage text NOT NULL, -- >type d'appariellage
	diametre float4 NULL, -- diametre nominal
	telegestion text NULL -- > Présence d'une gestion à distance
)
INHERITS ("stareau_principale".noeud_reseau);
COMMENT ON TABLE "stareau_aep".aep_appareillage IS 'Equipements divers sur le réseau d''eau potable non pris en compte dans les autres classes d''entités';

-- Column comments

COMMENT ON COLUMN "stareau_aep".aep_appareillage.type_appareillage IS '>type d''appariellage';
COMMENT ON COLUMN "stareau_aep".aep_appareillage.diametre IS 'diametre nominal';
COMMENT ON COLUMN "stareau_aep".aep_appareillage.telegestion IS '> Présence d''une gestion à distance';

--STATION D'ALERTE

CREATE TABLE stareau_aep.aep_station_alerte (
	id_aep_station_alerte serial4 NOT NULL, -- identifiant
	nom_usuel text NULL, -- nom d'usage
	geom public.geometry(point, 2154) NOT NULL,
	CONSTRAINT aep_station_alerte_pk PRIMARY KEY (id_aep_station_alerte)
);
COMMENT ON TABLE stareau_aep.aep_station_alerte IS 'equipement permettent de déclencher une alerte en cas de pollution ou de dépassement de seuils';

-- Column comments

COMMENT ON COLUMN stareau_aep.aep_station_alerte.id_aep_station_alerte IS 'identifiant';
COMMENT ON COLUMN stareau_aep.aep_station_alerte.nom_usuel IS 'nom d''usage';
