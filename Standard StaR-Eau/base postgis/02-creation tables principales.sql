/*
 * 02-creation tables communes.sql
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
 * 17.03.2024
 */

---tables principales

--DIMENSIONS

CREATE TABLE "stareau_principale".dimension (
  --id_dimension text NOT NULL -- pas utile dans base, à voir si besoin pour gpkg ou autre
  forme text NULL, -- forme générale de l'objet
  type_dimension text NULL, -- type de dimension
  hauteur_interieure float8 NULL, -- hauteur max interieure
  hauteur_exterieure float8 NULL, -- hauteur max exterieure
  largeur_interieure float8 NULL, -- largeur max interieure
  largeur_exterieure float8 NULL, -- largeur max exterieure
  longueur_interieure float8 NULL, -- longueur max interieure
  longueur_exterieure float8 NULL -- longueur max exterieure
);
COMMENT ON TABLE "stareau_principale".dimension IS 'table mére des dimensions des élèments';

-- Column comments

COMMENT ON COLUMN "stareau_principale".dimension.forme IS '>forme générale de l''objet';
COMMENT ON COLUMN "stareau_principale".dimension.type_dimension IS '>type de dimension';
COMMENT ON COLUMN "stareau_principale".dimension.hauteur_interieure IS 'hauteur max interieure';
COMMENT ON COLUMN "stareau_principale".dimension.hauteur_exterieure IS 'hauteur max exterieure';
COMMENT ON COLUMN "stareau_principale".dimension.largeur_interieure IS 'largeur max interieure';
COMMENT ON COLUMN "stareau_principale".dimension.largeur_exterieure IS 'largeur max exterieure';
COMMENT ON COLUMN "stareau_principale".dimension.longueur_interieure IS 'longueur max interieure';
COMMENT ON COLUMN "stareau_principale".dimension.longueur_exterieure IS 'longueur max exterieure';

--DONNÉES GÉNÉRALES

CREATE TABLE "stareau_principale".donnee_generale(
   --id_donnee_generale SERIAL4 NOT NULL,
   type_reseau TEXT NOT NULL, --type de réseau (com_type_reseau)
   fictif BOOL DEFULT 'false',
   etat_service TEXT NOT NULL, --etat de service (com_etat_service)
   --insee_commune varchar(5) NOT NULL, --Insee de la commune
   insee_commune c_insee NOT NULL, --Insee de la commune
   localisation TEXT NULL, --adresse, nom de la rue principale, ou localisation relative du patrimoine
   maitre_ouvrage TEXT NOT NULL, --propriétaire de patrimoine
   exploitant TEXT NOT NULL, --exploitant actuel du patrimoine
   entreprise_pose TEXT, --entreprise ayant effectué les travaux de mise en place
   an_pose_sup c_annee NOT NULL, --Année marquant la fin de la période de pose
   an_pose_inf c_annee, --Année marquant la début de la période de pose
   an_service_sup c_annee, --Année marquant la fin de la période de mise en service
   an_service_inf c_annee, --Année marquant le début de la période de mise en service
   an_abandon_sup c_annee,--Année marquant la fin de la période d'arrêt définitif
   an_abandon_inf c_annee,--Année marquant le début de la période d'arrêt définitif
   an_rehab_sup c_annee,--Année marquant la fin de la période de réhabilitation
   an_rehab_inf c_annee,--Année marquant le début de la période de mise en service
   lien_doc1 TEXT,
   lien_doc2 TEXT,
   commentaire TEXT
   --CONSTRAINT PK_donnee_generale PRIMARY KEY(id_donnee_generale)
);

COMMENT ON TABLE "stareau_principale".donnee_generale IS 'table mére des données générales sur les éléments de patrimoine';
COMMENT ON COLUMN "stareau_principale".donnee_generale.type_reseau IS '>type de réseau';
COMMENT ON COLUMN "stareau_principale".donnee_generale.etat_service IS '>état de service';
COMMENT ON COLUMN "stareau_principale".donnee_generale.insee_commune IS 'insee de la commune';
COMMENT ON COLUMN "stareau_principale".donnee_generale.maitre_ouvrage IS 'maitre d''ouvrage';
COMMENT ON COLUMN "stareau_principale".donnee_generale.exploitant IS 'exploitant actuel';
COMMENT ON COLUMN "stareau_principale".donnee_generale.entreprise_pose IS 'entreprise de pose';
COMMENT ON COLUMN "stareau_principale".donnee_generale.an_pose_sup IS 'Année marquant la fin de la période de pose';
COMMENT ON COLUMN "stareau_principale".donnee_generale.an_pose_inf IS 'Année marquant la début de la période de pose';
COMMENT ON COLUMN "stareau_principale".donnee_generale.an_service_sup IS 'Année marquant la fin de la période de mise en service';
COMMENT ON COLUMN "stareau_principale".donnee_generale.an_service_inf IS 'Année marquant le début de la période de mise en service';
COMMENT ON COLUMN "stareau_principale".donnee_generale.an_abandon_sup IS 'Année marquant la fin de la période d''arrêt définitif';
COMMENT ON COLUMN "stareau_principale".donnee_generale.an_abandon_inf IS 'Année marquant le début de la période d''arrêt définitif';
COMMENT ON COLUMN "stareau_principale".donnee_generale.an_rehab_sup IS 'Année marquant la fin de la période de réhabilitation';
COMMENT ON COLUMN "stareau_principale".donnee_generale.an_rehab_inf IS 'Année marquant le début de la période de mise en service';
COMMENT ON COLUMN "stareau_principale".donnee_generale.lien_doc1 IS 'lien vers document';
COMMENT ON COLUMN "stareau_principale".donnee_generale.lien_doc2 IS 'lien 2 vers autre document';
COMMENT ON COLUMN "stareau_principale".donnee_generale.localisation IS 'adresse, nom de la rue principale, ou localisation relative du patrimoine';

--METADONNÉES

/*CREATE TABLE "stareau_principale".metadonnee (
  --id_metadonnee serial4 NOT NULL,
  precisionxy varchar(1) NOT NULL, -- classe de precision xy
  precisionz varchar(1) NULL, -- classe de precision y
  date_maj date NULL, -- date de mise à jour
  source_maj text NULL, -- source de la mise à jour
  date_geoloc date NULL, -- date de geolocalisation
  source_geoloc text NULL, -- source de la geolocalisation
  prop_metadonnees text NULL, -- propriétaire de la métadonnée
  source_attribut text NULL, -- source des attributs
  producteur text NULL -- producteur de la donnée
  --CONSTRAINT pk_metadonnee PRIMARY KEY (id_metadonnee)
);
COMMENT ON TABLE "stareau_principale".metadonnee IS 'table de qualification de la qualité des données';
COMMENT ON COLUMN "stareau_principale".metadonnee.precisionxy IS '>classe de precision xy';
COMMENT ON COLUMN "stareau_principale".metadonnee.precisionz IS '>classe de precision z';
COMMENT ON COLUMN "stareau_principale".metadonnee.date_maj IS 'date de mise à jour';
COMMENT ON COLUMN "stareau_principale".metadonnee.source_maj IS 'source de la mise à jour*';
COMMENT ON COLUMN "stareau_principale".metadonnee.date_geoloc IS 'date de geolocalisation';
COMMENT ON COLUMN "stareau_principale".metadonnee.source_geoloc IS 'source de la geolocalisation*';
COMMENT ON COLUMN "stareau_principale".metadonnee.prop_metadonnees IS 'propriétaire de la métadonnée';
COMMENT ON COLUMN "stareau_principale".metadonnee.source_attribut IS 'source des attributs';
COMMENT ON COLUMN "stareau_principale".metadonnee.producteur IS 'producteur de la donnée';*/

--ÉLÉMENTS PONCTUELS - NOEUDS-RÉSEAU

CREATE TABLE "stareau_principale".noeud_reseau (
  id_noeud_reseau text NOT NULL DEFAULT gen_random_uuid(), -- uuid par défaut peut-être retirer pour autre identifiant
  --id_noeud_reseau TEXT NOT NULL,
  fictif bool DEFAULT false NULL,
  geom public.geometry(point, 2154) NOT NULL,
  CONSTRAINT pk_noeud_reseau PRIMARY KEY (id_noeud_reseau)
)
INHERITS ("stareau_principale".donnee_generale,"stareau_principale".metadonnee);
CREATE INDEX sidx_noeud_geom ON stareau_principale.noeud_reseau USING gist (geom);

COMMENT ON TABLE "stareau_principale".noeud_reseau IS 'table mére des élèments ponctuels';

--ÉLÉMENTS LINÉAIRES - CANALISATION--

CREATE TABLE "stareau_principale".canalisation (
  id_canalisation text NOT NULL DEFAULT gen_random_uuid(),  -- uuid par défaut peut-être retirer pour autre identifiant
  --id_canalisation TEXT NOT NULL,
  geom public.geometry(multilinestring, 2154) NOT NULL,
  mode_circulation text NULL, -- mode de circulation
  type_pose text NULL, -- type de pose
  raison_pose text NULL, -- raison de la pose
  materiau text NULL, -- materiau
  revetement_interieur text NULL, -- revêtement intérieur
  diametre_equivalent int2 NOT NULL, -- diametre nominale ou commercial
  longueur_terrain numeric(15, 2) NULL, -- longueur réelle terrain
  noeudterminal text NOT NULL, -- noeud terminal
  noeudinitial text NOT NULL, -- noeud initial
  fictive bool NOT NULL, -- conduite fictive ou virtuelle pour continuité hydraulique
  CONSTRAINT pk_canalisation PRIMARY KEY (id_canalisation)
)
INHERITS ("stareau_principale".donnee_generale);
CREATE INDEX sidx_canalisation_geom ON stareau_principale.canalisation USING gist (geom);

COMMENT ON TABLE "stareau_principale".canalisation IS 'table mère des éléments linéaire';
COMMENT ON COLUMN "stareau_principale".canalisation.mode_circulation IS '>mode de circulation';
COMMENT ON COLUMN "stareau_principale".canalisation.type_pose IS '>type de pose';
COMMENT ON COLUMN "stareau_principale".canalisation.raison_pose IS '>raison de la pose';
COMMENT ON COLUMN "stareau_principale".canalisation.materiau IS '>materiau';
COMMENT ON COLUMN "stareau_principale".canalisation.revetement_interieur IS '>revêtement intérieur';
COMMENT ON COLUMN "stareau_principale".canalisation.diametre_equivalent IS 'diametre nominale ou équivalent';
COMMENT ON COLUMN "stareau_principale".canalisation.longueur_terrain IS 'longueur réelle terrain';
COMMENT ON COLUMN "stareau_principale".canalisation.fictive IS 'conduite fictive ou virtuelle pour continuité hydraulique';

-- ÉLÉMENTS SURFACIQUES - EMPRISE--

CREATE TABLE "stareau_principale".emprise (
  id_emprise text NOT NULL DEFAULT gen_random_uuid(), -- uuid par défaut peut-être retirer pour autre identifiant
  --id_emprise text NOT NULL, -- identifiant emprise
  visible bool NULL, -- visible de la surface ?
  fictive bool DEFAULT false NULL, -- fictive ?
  geom public.geometry(polygon, 2154) NOT NULL,
  CONSTRAINT emprise_pk PRIMARY KEY (id_emprise)
)
INHERITS ("stareau_principale".donnee_generale);
CREATE INDEX sidx_emprise_geom ON stareau_principale.emprise USING gist (geom);

COMMENT ON TABLE "stareau_principale".emprise IS 'table mère des éléments ayant une surface réelle ou projetée au sol';
COMMENT ON COLUMN stareau_principale.emprise.id_emprise IS 'identifiant emprise';
COMMENT ON COLUMN stareau_principale.emprise.visible IS 'visible de la surface ?';
COMMENT ON COLUMN stareau_principale.emprise.fictive IS 'fictive ?';

-- Column comments

COMMENT ON COLUMN "stareau_principale".emprise.id_emprise IS 'identifiant emprise';
--COMMENT ON COLUMN "stareau_principale".emprise.type_emprise IS '>type d''emprise';
COMMENT ON COLUMN "stareau_principale".emprise.visible IS 'visible de la surface ?';

--- TABLE DE RELATION NOEUD-EMPRISE
CREATE TABLE stareau_principale.mm_emprise_ponctuel (
  id_emprise text NOT NULL,
  id_noeud text NOT NULL
);
COMMENT ON TABLE stareau_principale.mm_emprise_ponctuel IS 'table many-many entre éléments surfaciques et éléments ponctuels';


