/*
 * 03-creation assainissement.sql
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
 
 
 ---TRAITEMENT
 
CREATE TABLE "stareau_ass".ass_traitement (
	id_ass_traitement serial4 NOT NULL,
	nom_usuel text NOT NULL, -- nom de l'ouvrage (nomouvragedepollution)
	code_ouvrage_sandre text NOT NULL, -- code sandre de l'ouvrage (cdouvragedepollution)
	techno_traitement text NOT NULL, -- >technologie du traitement
	capacite_nominale integer NULL, -- capacité nominale du traitement (capaciteNom)
  telegestion text NOT NULL,
	CONSTRAINT ass_traitement_pk PRIMARY KEY (id_ass_traitement)
)
INHERITS ("stareau_principale".noeud_reseau);
COMMENT ON TABLE "stareau_ass".ass_traitement IS 'Ensemble des installations chargées de traiter les eaux collectées par le réseau de collecte des eaux usées avant rejet au milieu naturel et dans le respect de la réglementation.';

-- Column comments

COMMENT ON COLUMN "stareau_ass".ass_traitement.nom_usuel IS 'nom de l''ouvrage (nomouvragedepollution)';
COMMENT ON COLUMN "stareau_ass".ass_traitement.code_ouvrage_sandre IS 'code sandre de l''ouvrage (cdouvragedepollution)';
COMMENT ON COLUMN "stareau_ass".ass_traitement.techno_traitement IS '>technologie du traitement';
COMMENT ON COLUMN "stareau_ass".ass_traitement.capacite_nominale IS 'capacité nominale du traitement (capaciteNom)';

--- PRETRAITEMENT

CREATE TABLE "stareau_ass".ass_pretraitement (
	id_ass_pretraitement serial4 NOT NULL, -- identifiant
	type_pretraitement text NOT NULL, -- > type de prétraitement
	capacite int4 NOT NULL, -- capacité du prétraitement
	volume float4 NOT NULL, -- volume total du stockage éventuel
	telegestion text NOT NULL, -- >présence d'une gestion à distance
	CONSTRAINT ass_pretraitement_pk PRIMARY KEY (id_ass_pretraitement)
)
INHERITS ("stareau_principale".noeud_reseau);
COMMENT ON TABLE "stareau_ass".ass_pretraitement IS 'Les prétraitements ont pour objectif d''éliminer les éléments les plus grossiers. Il s''agit des déchets volumineux (dégrillage), des sables et graviers (dessablage) et des graisses (dégraissage-déshuilage).';

-- Column comments

COMMENT ON COLUMN "stareau_ass".ass_pretraitement.id_ass_pretraitement IS 'identifiant';
COMMENT ON COLUMN "stareau_ass".ass_pretraitement.type_pretraitement IS '>type de prétraitement';
COMMENT ON COLUMN "stareau_ass".ass_pretraitement.capacite IS 'capacité du prétraitement';
COMMENT ON COLUMN "stareau_ass".ass_pretraitement.volume IS 'volume total du stockage éventuel';
COMMENT ON COLUMN "stareau_ass".ass_pretraitement.telegestion IS '>présence d''une gestion à distance';

---EQUIPEMENT

CREATE TABLE "stareau_ass".ass_equipement (
	id_ass_equipement serial4 NOT NULL,
	type_equipement text NOT NULL, -- >type équipement
	fonction_equipement text NOT NULL, -- >fonction de l'équipement
	telegestion text NOT NULL, -- >présence d''une gestion à distance
	CONSTRAINT ass_equipement_pk PRIMARY KEY (id_ass_equipement)
)
INHERITS ("stareau_principale".noeud_reseau);
COMMENT ON TABLE "stareau_ass".ass_equipement IS 'Composant associé à un ouvrage, par installation, montage, liaison ou mise en œuvre pour son exploitation afin d’assurer la fonction qui lui est dévolue.';

-- Column comments

COMMENT ON COLUMN "stareau_ass".ass_equipement.type_equipement IS '>type équipement';
COMMENT ON COLUMN "stareau_ass".ass_equipement.fonction_equipement IS '>fonction de l''équipement';
COMMENT ON COLUMN "stareau_ass".ass_equipement.telegestion IS '>présence d''''une gestion à distance';

---POMPAGE

CREATE TABLE "stareau_ass".ass_pompage (
	id_ass_pompage serial4 NOT NULL,
	type_pompage text NOT NULL, -- >type de pompage
	fonction_pompage text NOT NULL, -- >fonction du pompage
	nb_pompe int2 NOT NULL DEFAULT 1, -- nombre de pompe
	debit_temps_sec float4 NULL, -- débit normal moyen par temps sec (m3/h)
	debit_temps_pluie float4 NULL, -- débit normal moyen par temps de pluie (m3/h)
	nb_bache int2 NULL DEFAULT 1, -- nombre de bâche du poste
	volume_bache float4 NULL, -- volume total de la ou des bâches
	cote_trop_plein float4 NULL, -- cote de déversement du trop-plein (NGF)
	telegestion text NOT NULL, -- présence d'une gestion à distance
	nom_usuel text NULL, -- nom d'usage du pompage
	CONSTRAINT ass_pompage_pk PRIMARY KEY (id_ass_pompage)
)
INHERITS ("stareau_principale".noeud_reseau,"stareau_principale".dimension);
COMMENT ON TABLE "stareau_ass".ass_pompage IS 'Bâtiment, structures et équipements utilisés pour transférer les eaux usées par une conduite de relèvement ou tout autre dispositif de relevage.
On distingue habituellement plusieurs types : 
• station de refoulement, 
• station de relèvement, 
• station de pompage en ligne.';

-- Column comments

COMMENT ON COLUMN "stareau_ass".ass_pompage.type_pompage IS '>type de pompage';
COMMENT ON COLUMN "stareau_ass".ass_pompage.fonction_pompage IS '>fonction du pompage';
COMMENT ON COLUMN "stareau_ass".ass_pompage.nb_pompe IS 'nombre de pompe';
COMMENT ON COLUMN "stareau_ass".ass_pompage.debit_temps_sec IS 'débit normal moyen par temps sec (m3/h)';
COMMENT ON COLUMN "stareau_ass".ass_pompage.debit_temps_pluie IS 'débit normal moyen par temps de pluie (m3/h)';
COMMENT ON COLUMN "stareau_ass".ass_pompage.nb_bache IS 'nombre de bâche du poste';
COMMENT ON COLUMN "stareau_ass".ass_pompage.volume_bache IS 'volume total de la ou des bâches';
COMMENT ON COLUMN "stareau_ass".ass_pompage.cote_trop_plein IS 'cote de déversement du trop-plein (NGF)';
COMMENT ON COLUMN "stareau_ass".ass_pompage.telegestion IS 'présence d''une gestion à distance';
COMMENT ON COLUMN "stareau_ass".ass_pompage.nom_usuel IS 'nom d''usage du pompage';

---CHAMBRE DE DEPOLLUTION

CREATE TABLE "stareau_ass".ass_chambre_depollution (
	id_ass_chambre_depollution serial4 NOT NULL,
	nom_usuel text NULL, -- nom usuel
	type_chambre_depollution text NOT NULL, -- > type de chambre de dépollution
	bypass bool NULL, -- présence d'un by-pass
	volume_chambre float4 NULL, -- volume totale en m3
	telegestion text NOT NULL, -- >présence ou non d'une télégestion
	CONSTRAINT ass_chambre_depollution_pk PRIMARY KEY (id_ass_chambre_depollution)
)
INHERITS ("stareau_principale".noeud_reseau,"stareau_principale".dimension);
COMMENT ON TABLE "stareau_ass".ass_chambre_depollution IS 'Une installation ou une structure conçue pour traiter ou réduire la charge polluante des eaux usées ou des effluents avant leur rejet dans l''environnement. Elle est généralement intégrée à un système d''assainissement pour améliorer la qualité des eaux avant qu''elles ne soient rejetées dans les cours d''eau ou les réseaux de collecte.';

-- Column comments

COMMENT ON COLUMN "stareau_ass".ass_chambre_depollution.nom_usuel IS 'nom usuel';
COMMENT ON COLUMN "stareau_ass".ass_chambre_depollution.type_chambre_depollution IS '>type de chambre de dépollution';
COMMENT ON COLUMN "stareau_ass".ass_chambre_depollution.bypass IS 'présence d''un by-pass';
COMMENT ON COLUMN "stareau_ass".ass_chambre_depollution.volume_chambre IS 'volume totale en m3';
COMMENT ON COLUMN "stareau_ass".ass_chambre_depollution.telegestion IS '>présence ou non d''une télégestion';


--- CANALISATION

CREATE TABLE "stareau_ass".ass_canalisation (
	id_ass_canalisation serial4 NOT NULL,
	fonction_ass_canalisation text NOT NULL, -- fonction de la canalisation dans le réseau
	visitable text NULL, -- possibilté de visite pedestre
	altitude_fil_eau_amont float4 NULL, -- altitude fil d'eau amont
	altitude_fil_eau_aval float4 NULL, -- altitude fil d'eau aval
	bassin_collecte text NULL, -- identifiant bassin de collecte
	ref_ouvrage_aval text NULL, -- reference de l'ouvrage en aval
	CONSTRAINT ass_canalisation_pk PRIMARY KEY (id_canalisation)
)
INHERITS ("stareau_principale".canalisation,"stareau_principale".dimension);
COMMENT ON TABLE "stareau_ass".ass_canalisation IS 'canalisation assainissement';

-- Column comments

COMMENT ON COLUMN "stareau_ass".ass_canalisation.fonction_ass_canalisation IS 'fonction de la canalisation dans le réseau';
COMMENT ON COLUMN "stareau_ass".ass_canalisation.visitable IS 'possibilté de visite pedestre';
COMMENT ON COLUMN "stareau_ass".ass_canalisation.altitude_fil_eau_amont IS 'altitude fil d''eau amont';
COMMENT ON COLUMN "stareau_ass".ass_canalisation.altitude_fil_eau_aval IS 'altitude fil d''eau aval';
COMMENT ON COLUMN "stareau_ass".ass_canalisation.bassin_collecte IS 'identifiant bassin de collecte';
COMMENT ON COLUMN "stareau_ass".ass_canalisation.ref_ouvrage_aval IS 'reference de l''ouvrage en aval';

--- PIECE

CREATE TABLE "stareau_ass".ass_piece (
	id_ass_piece serial4 NOT NULL,
	type_piece text NOT NULL, -- > type de pièce
	fk_ass_canalisation text NULL -- référence à la conduite de rattachement
)
INHERITS ("stareau_principale".noeud_reseau);
COMMENT ON TABLE "stareau_ass".ass_piece IS 'Pièces sur canalisations principales';

-- Column comments

COMMENT ON COLUMN "stareau_ass".ass_piece.type_piece IS '>type de pièce';
COMMENT ON COLUMN "stareau_ass".ass_piece.fk_ass_canalisation IS 'référence à la conduite de rattachement';

--- PIECE HORS TOPOLOGIE

CREATE TABLE "stareau_ass".ass_piece_hors_topo (
	id_ass_pieceht serial4 NOT NULL,
	type_piece text NOT NULL, -- > type de pièce
	fk_ass_canalisation text NULL, -- référence à la conduite de rattachement
  geom public.geometry(point, 2154) NOT NULL
)
INHERITS ("stareau_principale".metadonnee,stareau_principale.donnee_generale);
COMMENT ON TABLE "stareau_ass".ass_piece_hors_topo IS 'Pièces sur canalisations principales HORS TOPOLOGIE (pas sur un noeud réseau)';

-- Column comments

COMMENT ON COLUMN "stareau_ass".ass_piece_hors_topo.type_piece IS '>type de pièce';
COMMENT ON COLUMN "stareau_ass".ass_piece_hors_topo.fk_ass_canalisation IS 'référence à la conduite de rattachement(id_canalisation)';

---POINT DE MESURE

CREATE TABLE "stareau_ass".ass_point_mesure (
	id_ass_point_mesure serial4 NOT NULL,
	type_point_mesure text NOT NULL, -- >type du point de mesure
	code_sandre text NOT NULL, -- >code sandre officiel
	id_sandre text NULL, -- identifiant SANDRE
  ref_ouvrage text NULL, -- référence à l'ouvrage de rattachement
	telegestion text NOT NULL
)
INHERITS ("stareau_principale".noeud_reseau);
COMMENT ON TABLE "stareau_ass".ass_point_mesure IS 'Point de suivi remarquable du fonctionnement d''un ouvrage d''assainissement';

-- Column comments

COMMENT ON COLUMN "stareau_ass".ass_point_mesure.type_point_mesure IS '>type du point de mesure';
COMMENT ON COLUMN "stareau_ass".ass_point_mesure.code_sandre IS '>code sandre officiel';
COMMENT ON COLUMN "stareau_ass".ass_point_mesure.ref_ouvrage IS 'référence à l''ouvrage de rattachement';
COMMENT ON COLUMN "stareau_ass".ass_point_mesure.id_sandre IS 'identifiant SANDRE';

--- REGARD

CREATE TABLE "stareau_ass".ass_regard (
	id_ass_regard serial4 NOT NULL,
	type_regard text NOT NULL, -- type de regard *
	materiau text NOT NULL, -- materiau constitutif du regard *
	"position" text NOT NULL, -- position par rapport à la canalisation *
	type_descente text NOT NULL, -- élèment de descente dans le regard *
	nb_paliers int2 NULL, -- nombre de paliers
	z_tampon float4 NULL, -- cote NGF du tampon
	z_radier float4 NULL -- cote NGF du point le plus bas du regard
)
INHERITS ("stareau_principale".noeud_reseau,"stareau_principale".dimension);
COMMENT ON TABLE "stareau_ass".ass_regard IS 'enceinte munie d''un tampon amovible, réalisé sur un branchement ou un collecteur afin de permettre l''entrée du personnel';

-- Column comments
COMMENT ON COLUMN "stareau_ass".ass_regard.type_regard IS '>type de regard';
COMMENT ON COLUMN "stareau_ass".ass_regard.materiau IS '>materiau constitutif du regard';
COMMENT ON COLUMN "stareau_ass".ass_regard."position" IS '>position par rapport à la canalisation';
COMMENT ON COLUMN "stareau_ass".ass_regard.type_descente IS '>élèment de descente dans le regard';
COMMENT ON COLUMN "stareau_ass".ass_regard.nb_paliers IS 'nombre de paliers';
COMMENT ON COLUMN "stareau_ass".ass_regard.z_tampon IS 'cote NGF du tampon';
COMMENT ON COLUMN "stareau_ass".ass_regard.z_radier IS 'cote NGF du point le plus bas du regard';

---OUVRAGE SPECIAL

CREATE TABLE "stareau_ass".ass_ouvrage_special (
	id_ass_ouvrage_special serial4 NOT NULL,
	type_ouvrage_special text NOT NULL, -- >type d'ouvrage spécial
	ref_ouvrage text NULL -- ouvrage ou canalisation de rattachement
)
INHERITS ("stareau_principale".noeud_reseau,"stareau_principale".dimension);
COMMENT ON TABLE "stareau_ass".ass_ouvrage_special IS 'Ouvrage particulier ne rentrant pas dans une autre classe d''entités';

-- Column comments

COMMENT ON COLUMN "stareau_ass".ass_ouvrage_special.type_ouvrage_special IS '>type d''ouvrage spécial';
COMMENT ON COLUMN "stareau_ass".ass_ouvrage_special.ref_ouvrage IS 'ouvrage ou canalisation de rattachement';

------EXUTOIRE

CREATE TABLE stareau_ass.ass_exutoire (
	id_ass_exutoire serial4 NOT NULL, -- identifiant
	code_topage text NULL, -- Code TOPAGE du milieu récepteur
	destination text NOT NULL, -- >type de milieu récepteur
	CONSTRAINT ass_exutoire_pk PRIMARY KEY (id_ass_exutoire)
)
INHERITS ("stareau_principale".noeud_reseau);
COMMENT ON TABLE stareau_ass.ass_exutoire IS 'Point de rejet dans le milieu récepteur';

-- Column comments

COMMENT ON COLUMN stareau_ass.ass_exutoire.id_ass_exutoire IS 'identifiant';
COMMENT ON COLUMN stareau_ass.ass_exutoire.code_topage IS 'Code TOPAGE du milieu récepteur';
COMMENT ON COLUMN stareau_ass.ass_exutoire.destination IS '>type de milieu récepteur';


----BASSIN

CREATE TABLE stareau_ass.ass_bassin (
	id_ass_bassin serial4 NOT NULL, -- identifiant
	nom_usuel text NULL, -- nom usuel
	type_bassin text NOT NULL, -- >type de bassin
	fonction_bassin text NOT NULL, -- >fonction du bassin
	structure_bassin text NOT NULL, -- >structure du bassin
	capacite text NULL, -- capacité maximale de stockage en m3
	debit_fuite numeric NULL, -- Quantité limitée d'eau en M3/s qui s'évacue du bassin de stockage par l'intermédiaire d'un dispositif de régulation
	cote_radier numeric NULL, -- Cote NGF du point le plus bas du fond de bassin
	cote_trop_plein numeric NULL, -- cote NGF de débordement du bassin
	telegestion text NOT NULL, -- >présence d'une gestion à distance
	CONSTRAINT bassin_pk PRIMARY KEY (id_ass_bassin)
)
INHERITS ("stareau_principale".noeud_reseau,"stareau_principale".dimension);

COMMENT ON TABLE stareau_ass.ass_bassin IS 'Ouvrage retenant momentanément des eaux pendant les périodes pluvieuses, que ce soit des eaux pluviales seules ou un mélange d''eaux pluviales et d''eaux usées.';

-- Column comments

COMMENT ON COLUMN stareau_ass.ass_bassin.id_ass_bassin IS 'identifiant';
COMMENT ON COLUMN stareau_ass.ass_bassin.nom_usuel IS 'nom usuel';
COMMENT ON COLUMN stareau_ass.ass_bassin.type_bassin IS '>type de bassin';
COMMENT ON COLUMN stareau_ass.ass_bassin.fonction_bassin IS '>fonction du bassin';
COMMENT ON COLUMN stareau_ass.ass_bassin.structure_bassin IS '>structure du bassin';
COMMENT ON COLUMN stareau_ass.ass_bassin.capacite IS 'capacité maximale de stockage en m3';
COMMENT ON COLUMN stareau_ass.ass_bassin.debit_fuite IS 'Quantité limitée d''eau en M3/s qui s''évacue du bassin de stockage par l''intermédiaire d''un dispositif de régulation';
COMMENT ON COLUMN stareau_ass.ass_bassin.cote_radier IS 'Cote NGF du point le plus bas du fond de bassin';
COMMENT ON COLUMN stareau_ass.ass_bassin.cote_trop_plein IS 'cote NGF de débordement du bassin';
COMMENT ON COLUMN stareau_ass.ass_bassin.telegestion IS '>présence d''une gestion à distance';

--- ENGOUFFREMENTS
---point
CREATE TABLE stareau_ass.ass_engouffrement_point (
	id_ass_engouffrement_point serial4 NOT NULL, -- identifiant
	type_engouffrement text NULL, -- >type d'engouffrement
	decantation text NOT NULL, -- >présence décantation
	siphon text NOT NULL, -- > présence d'un siphon
	CONSTRAINT ass_engouffrement_point_pk PRIMARY KEY (id_ass_engouffrement_point)
)
INHERITS ("stareau_principale".noeud_reseau,"stareau_principale".dimension);

-- Column comments
COMMENT ON TABLE stareau_ass.ass_engouffrement_point IS 'Élément du système d’assainissement permettant l''introduction des eaux de ruissellement';
COMMENT ON COLUMN stareau_ass.ass_engouffrement_point.id_ass_engouffrement_point IS 'identifiant';
COMMENT ON COLUMN stareau_ass.ass_engouffrement_point.type_engouffrement IS '>type d''engouffrement';
COMMENT ON COLUMN stareau_ass.ass_engouffrement_point.decantation IS '>présence décantation';
COMMENT ON COLUMN stareau_ass.ass_engouffrement_point.siphon IS '> présence d''un siphon';

----ligne
CREATE TABLE stareau_ass.ass_engouffrement_ligne (
	id_ass_engouffrement_ligne serial4 NOT NULL, -- identifiant
	type_engouffrement text NULL, -- >type d'engouffrement
	decantation text NOT NULL, -- >présence décantation
	siphon text NOT NULL, -- > présence d'un siphon
	CONSTRAINT ass_engouffrement_ligne_pk PRIMARY KEY (id_ass_engouffrement_ligne)
)
INHERITS ("stareau_principale".canalisation,"stareau_principale".dimension);

-- Column comments
COMMENT ON TABLE stareau_ass.ass_engouffrement_ligne IS 'Élément du système d’assainissement permettant l''introduction des eaux de ruissellement';
COMMENT ON COLUMN stareau_ass.ass_engouffrement_ligne.id_ass_engouffrement_ligne IS 'identifiant';
COMMENT ON COLUMN stareau_ass.ass_engouffrement_ligne.type_engouffrement IS '>type d''engouffrement';
COMMENT ON COLUMN stareau_ass.ass_engouffrement_ligne.decantation IS '>présence décantation';
COMMENT ON COLUMN stareau_ass.ass_engouffrement_ligne.siphon IS '> présence d''un siphon';

---surface
CREATE TABLE stareau_ass.ass_engouffrement_surface (
	id_ass_engouffrement_surface serial4 NOT NULL, -- identifiant
	type_engouffrement text NULL, -- >type d'engouffrement
	decantation text NOT NULL, -- >présence décantation
	siphon text NOT NULL, -- > présence d'un siphon
	CONSTRAINT ass_engouffrement_surface_pk PRIMARY KEY (id_ass_engouffrement_surface)
)
INHERITS ("stareau_principale".emprise,"stareau_principale".dimension);

-- Column comments
COMMENT ON TABLE stareau_ass.ass_engouffrement_surface IS 'Élément du système d’assainissement permettant l''introduction des eaux de ruissellement';
COMMENT ON COLUMN stareau_ass.ass_engouffrement_surface.id_ass_engouffrement_surface IS 'identifiant';
COMMENT ON COLUMN stareau_ass.ass_engouffrement_surface.type_engouffrement IS '>type d''engouffrement';
COMMENT ON COLUMN stareau_ass.ass_engouffrement_surface.decantation IS '>présence décantation';
COMMENT ON COLUMN stareau_ass.ass_engouffrement_surface.siphon IS '> présence d''un siphon';
