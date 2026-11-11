# Physique du palet et des maillets

> Partie de la spec salle blanche d'Air Hockey Challenge. Ticket : Physique du palet et des maillets.

La table mesure 720 × 1280 pixels. Le centre est (360, 640). L'axe y augmente vers le haut. Le maillet du bas naît à (360, 320), celui du haut à (360, 960), le palet à (360, 640). (observé)

Le doigt, en mode de contrôle 3, ne pilote que le maillet du bas. La frappe du CPU a une vitesse verticale négative, donc vers le bas. Le bas est le camp du joueur, le haut celui du CPU. (déduit)

Un mètre vaut 32 pixels. `mètres = pixels × 0,03125` et `pixels = mètres × 32`. 0,03125 est exactement 1/32. Déplacer le dessin d'un corps déplace le corps : la position est divisée par ce rapport. (observé pour le rapport et pour la division ; déduit pour l'axe horizontal, dont le détail n'a pas été repris)

La pesanteur est (0, 0). Rien ne tombe. L'échelle de gravité lue sur le palet et sur les obstacles vaut 1 : avec une pesanteur nulle, elle ne change rien. (observé pour les deux nombres ; déduit pour l'effet)

## Ce que fait le jeu

### Pas de temps

1. Si un drapeau de partie est éteint, ou si l'état vaut 4 ou 7, aucun pas n'est joué. (observé) Ce que le joueur voit dans ces cas n'est pas décrit ici. (inconnu)
2. Sinon, un seul pas : 0,016 seconde, 6 itérations de vitesse, 2 itérations de position. (observé)
3. Le temps réel écoulé depuis l'image précédente n'est pas lu. Il n'y a pas d'accumulateur. Si l'image ralentit, la simulation ralentit d'autant. (observé pour le temps ignoré ; déduit pour l'accumulateur)
4. 0,016 n'est pas 1/60. À 60 images par seconde, la simulation avance de 0,96 seconde par seconde réelle. (observé pour la valeur ; déduit pour les 0,96 s)
5. Entre deux images, le doigt ou le CPU change une cible ou une vitesse. Ce changement n'entre dans le pas qu'à l'image suivante. (déduit)

Dans le pas : pesanteur nulle, amortissement nul sur le palet et les obstacles, les corps avancent, les contacts sont résolus (y compris entre deux positions pour les corps rapides), 6 itérations règlent les contacts et l'articulation du doigt, puis 2 itérations corrigent les positions. (déduit pour cet enchaînement ; observé pour la pesanteur nulle et pour l'amortissement du palet et des obstacles)

Les collisions continues sont allumées sur le monde. Le palet, les maillets et les obstacles de stage sont marqués rapides : un grand déplacement ne doit pas traverser un mur sans le voir. (observé)

### Ordre d'une image

1. Le pas ci-dessus, sauf état 4, état 7, ou drapeau de partie éteint. (observé)
2. Réponse aux contacts : relance du palet lent, vitesse des maillets remise à zéro. (observé)
3. Filet : si l'abscisse du dessin du palet sort de [0, 720], le palet est reposé. La position d'arrivée n'est pas lue. (observé pour le test ; inconnu pour l'arrivée) Si le maillet du haut sort de x entre 0 et 720, ou de y entre 630 et 1280, il est reposé à (360, 960). (observé) Les bornes 630 et 1280 n'ont pas été relues. (inconnu)
4. But, si l'ordonnée du palet en coordonnées du monde sort de [0, 1280]. (observé) L'ordre « filet, puis but » suppose que le palet est examiné après la table. L'ordre réel n'a pas été lu. (déduit)

### Corps

La masse n'est pas écrite à la main. Pour un disque, `masse = densité × π × rayon²`. (déduit)

Deux formes se touchent seulement si chacune accepte la catégorie de l'autre. (déduit) Les catégories et les masques ci-dessous sont ceux lus. (observé)

Un corps fixe ne bouge pas sous un choc. Sa densité ne sert pas à une masse utile. (déduit) Les formes sont solides : ce ne sont pas des zones de passage. (observé)

### Palet

Corps mobile. Il ne s'endort pas, il ne tourne pas sur lui-même, il est actif, et sa détection est continue. Amortissement linéaire et angulaire : 0. (observé)

Disque de rayon 0,9375 m, soit 30 pixels. Densité 1, frottement 0, rebond 0,85. Catégorie 4, masque toutes les catégories (65 535). (observé)

Masse ≈ 2,761 kg. (déduit)

Numéro 300 : c'est le corps dont la vitesse est relancée après un contact lent. (observé)

### Maillets

Corps mobiles, détection continue, ils ne s'endorment pas. Ils peuvent tourner sur eux-mêmes, contrairement au palet. (observé) Leur amortissement et leur échelle de gravité ne sont pas recopiés. (inconnu)

Disque de rayon 1,875 m, soit 60 pixels. Densité 30, frottement 0, rebond 0. (observé)

Masse ≈ 331,34 kg, soit exactement 120 fois le palet : le rayon est double et la densité vaut 30, donc `30 × 2² = 120`. (déduit)

Catégorie 1 pour le bas, catégorie 2 pour le haut. Ils ne se touchent pas. (observé) Le masque complet n'est pas recopié. Comme un contact palet-maillet est traité, chaque masque contient au moins la catégorie 4. (déduit)

Numéros 301 et 302. Le bas est créé avant le haut. On ne les repose, avec le palet, aux positions de départ que si le numéro 301 est absent. (observé) Que 301 soit le bas suit de cet ordre. (déduit)

### Barres de demi-table

Quatre boîtes fixes, centrées à x = 360. Demi-étendue 22,5 m × 1,25 m, donc boîte pleine 1440 × 80 pixels. Elles couvrent toute la largeur de la table, et au-delà. (observé pour les étendues ; déduit pour le dépassement)

Frottement 0, rebond 0, catégorie 4096. Peau du polygone : 0,002 m. (observé)

| Centre y (pixels) | Masque | Rôle |
| --- | --- | --- |
| 5 | 1 | bloque le maillet du bas vers le bas |
| 725 | 1 | bloque le maillet du bas vers le haut |
| 555 | 2 | bloque le maillet du haut vers le bas |
| 1275 | 2 | bloque le maillet du haut vers le haut |

Le palet n'est pas dans ces masques : il traverse la ligne du milieu. (observé)

Avec un rayon de 60 pixels et une demi-hauteur de barre de 40 pixels, sans compter la peau de 0,002 m : le centre du maillet du bas reste dans y de 105 à 625, celui du haut dans y de 655 à 1175. (déduit)

### Murs latéraux

Deux boîtes fixes. Catégorie 8, masque toutes les catégories, frottement 0, rebond 0. (observé)

Demi-étendue 1,25 m × 40 m, soit 40 × 1280 pixels de demi-étendue (boîte pleine 80 × 2560 pixels). Centres environ (−10, 640) et (730, 640). (observé pour les mètres et pour « environ » ; déduit pour la boîte pleine)

En mode de contrôle 5, ces deux murs ne sont pas posés. (observé ; le détail du choix n'a pas été repris)

Le palet, masque complet, les touche quand ils sont là. (déduit) Que les maillets les touchent dépend de leur masque, non recopié. (inconnu)

### Disques de coin

Quatre disques fixes. Rayon 0,4375 m, soit 14 pixels. Frottement 0, densité 0,01, rebond 30. Le palet et les maillets les heurtent. (observé) Le numéro de catégorie n'est pas lu. (inconnu) Le rebond 30 n'a pas été relu. (inconnu)

| Position (pixels) | Numéro |
| --- | --- |
| (32,5 ; 42,5) | 305 |
| (687,5 ; 42,5) | 306 |
| (32,5 ; 1237,5) | 307 |
| (687,5 ; 1237,5) | 308 |

(observé)

### Murs de stage

Boîte fixe, à part des murs de la table. Le stage donne la colonne, la ligne, le décalage local, la largeur et la hauteur en pixels. (observé) Les valeurs de chaque stage ne sont pas dans cette partie.

1. Demi-étendue en mètres : `taille en pixels × 0,5 × 0,03125`. Si la sorte vaut 6, la demi-largeur est encore multipliée par 0,9. (observé)
2. Position en pixels : `x = colonne × 480 + 10 + décalage local`, `y = (ligne + 1) × (−310) + 1260 + décalage local`. Puis conversion en mètres par × 0,03125. (observé)
3. Sortes 6 et 7 dont le centre y est strictement entre 628 et 652 : y forcé à 640 pixels. (observé)
4. Sorte 3 : le dessin est décalé de −5 pixels en y si la ligne est inférieure à 2, sinon de +5 pixels. Le corps garde la position déjà calculée. (observé)

Forme : frottement 0, rebond 0, densité 1000, solide, catégorie 8, masque toutes, groupe de collision 0, peau 0,002 m. La donnée portée par la forme est la sorte, en entier. (observé)

### Obstacles de stage

Corps fixe. Position = point de départ en pixels / 32, angle 0, amortissement 0, échelle de gravité 1, peut s'endormir, démarre éveillé, rotation libre, détection continue, actif. (observé)

Seules les sortes 62, 63 et 64 reçoivent une forme. Les autres ont un corps sans forme : pas de collision. (observé)

Sommets en mètres, dans l'ordre lu, relatifs au corps. L'équivalent en pixels est × 32. (observé pour les mètres ; déduit pour les pixels)

Sorte 62, cinq sommets : (0 ; 0,9375), (−1 ; 0,1875), (−0,6875 ; −0,9375), (0,6875 ; −0,9375), (1 ; 0,1875). En pixels : (0 ; 30), (−32 ; 6), (−22 ; −30), (22 ; −30), (32 ; 6).

Sorte 63, trois sommets : (0 ; 0,8125), (−0,9375 ; −0,8125), (0,9375 ; −0,8125). En pixels : (0 ; 26), (−30 ; −26), (30 ; −26).

Sorte 64, quatre sommets : (−1,875 ; 0,15625), (1,875 ; 0,15625), (1,875 ; −0,15625), (−1,875 ; −0,15625). En pixels : (−60 ; 5), (60 ; 5), (60 ; −5), (−60 ; −5). Un barreau de 120 × 10 pixels.

Forme commune : frottement 0, rebond 1, densité 50, solide, catégorie 16, masque 4 (le palet seul), peau 0,002 m. Numéro d'affichage 22. (observé)

Mouvement, seulement si la vitesse demandée n'est pas 0 et si les deux points diffèrent. (observé)

1. `durée = (distance en pixels / 100) / vitesse`. L'unité lue est celle d'un glissement à l'écran, donc des secondes. (observé pour la formule ; déduit pour les secondes)
2. Le dessin glisse vers l'autre point. (observé)
3. Un second glissement suit, en boucle. Sa cible exacte n'a pas été lue ; le retour au premier point est la lecture la plus simple. (déduit)

Déplacer le dessin téléporte le corps fixe. Il ne reçoit pas de vitesse. Le palet n'est pas poussé par l'obstacle : au pas suivant, il le trouve à sa nouvelle place. (déduit)

Rotation, en boucle : le paramètre 2 fait un tour de +360 degrés, le paramètre 1 un tour de −360 degrés. (observé) La durée d'un tour n'est pas lue. On ne sait pas si tourner le dessin tourne aussi le corps. Les autres valeurs du paramètre ne sont pas décrites. (inconnu)

### Doigt du joueur

Le maillet ne reçoit pas la vitesse du doigt. Seule une position cible change. Un ressort le tire vers cette cible. L'ancre est un corps fixe qui ne sert qu'à ce lien. (observé) Le réglage du lien dit que l'ancre et le maillet ne se cognent pas entre eux à cause de ce lien. (observé pour le réglage ; déduit pour l'effet)

1. Le point du doigt est converti dans le repère de la table, puis borné : x dans [90, 630], y dans [100, 1180]. (observé)
2. Le mode de contrôle choisit le maillet, ou refuse le geste. (observé)
3. À un nouvel appui, l'ancienne articulation est détruite, puis une nouvelle est créée. La cible vaut d'abord la position du maillet, puis le doigt en mètres (`pixels × 0,03125`). (observé)
4. Quand le doigt glisse, seule la cible change. (observé)
5. Quand le doigt se lève, l'articulation n'est pas détruite. Elle reste sur la dernière cible. (observé)

| Mode | Comportement |
| --- | --- |
| 3 | Maillet du bas seulement. Si y > 650, le geste est refusé. Fréquence du ressort 10 000 Hz. |
| 4 | Si y < 640, maillet du bas, sinon maillet du haut. Même ressort. Fréquence 10 000 Hz. |
| 5 | Maillet du bas si y ≤ 650, sinon refus. Fréquence 1 000 Hz. Si le doigt est dans un rectangle autour du palet, la cible est repoussée à 84 pixels du centre du palet. |
| autre | Le geste est accepté, mais aucune articulation n'est créée. |

(observé)

Le rectangle du mode 5 : origine = position du dessin + 0,25 × sa taille, taille du rectangle = 0,5 × la taille du contenu. La taille en pixels de ce contenu n'est pas lue. (observé pour la formule ; inconnu pour les pixels)

La formule visible du recul est `nouvelle position = position du palet − (sinus, cosinus) × 84`. L'axe qui porte le sinus, et donc la direction, ne sont pas sûrs. 84 pixels font 2,625 m. (observé pour les 84 pixels ; inconnu pour l'axe ; déduit pour les 2,625 m)

Réglages du ressort. (observé)

- Force maximale = masse du maillet × 20 000 newtons.
- Fréquence = 10 000 Hz, ou 1 000 Hz en mode 5.
- Rapport d'amortissement = 1.

À 10 000 Hz, la période du ressort (0,0001 s) est bien plus courte que le pas (0,016 s) : le ressort demanderait de combler tout l'écart en un pas. C'est le plafond de force qui limite. Accélération maximale = 20 000 m/s², donc un gain de vitesse d'au plus `20 000 × 0,016 = 320` m/s par pas. Depuis l'arrêt, cela fait `320 × 32 = 10 240` pixels/s, soit 163,84 pixels par pas. (déduit)

Un plafond de déplacement de 2 m par pas n'a pas été relu. S'il vaut 2 m, il est plus strict : 64 pixels par pas, soit 4 000 pixels/s. (inconnu)

La borne du doigt (y jusqu'à 1 180, et jusqu'à 650 pour le bas) dépasse un peu les barres (centres limités à 625 et 1 175). Les barres restent le blocage du corps. (déduit)

### Vitesse du maillet du CPU

La vitesse linéaire est écrite directement, en mètres par seconde. Pas d'articulation. (observé)

La vitesse de base dépend de la difficulté. Elle est multipliée par 0,7 si un réglage interne est allumé, sinon par 1. Ce qui allume ce réglage n'est pas vu ici. (observé pour le facteur ; inconnu pour le moment)

| Difficulté | Vitesse (m/s) |
| --- | --- |
| 0 | 15 |
| 1 | 27 |
| 2 | 39 |
| 3 | 51 |
| autre | 27 |

(observé)

Deux écritures. Le choix de l'instant et le vecteur demandé par la seconde viennent du comportement du CPU, pas d'ici. (observé)

1. Si un compteur interne est supérieur à 2 et si le corps n'est pas fixe : vitesse horizontale = entier uniforme de −7 à 7, bornes comprises ; vitesse verticale = `−0,5 × vitesse de base` (déjà fois 0,7 ou 1). Si le vecteur n'est pas nul, le corps est réveillé. (observé) À quoi sert le compteur n'est pas lu. (inconnu)
2. Seconde frappe : chaque axe vaut la vitesse demandée, plus un entier de −7 à 7. (observé)

Après un contact avec le palet, la vitesse des numéros 301 et 302 passe à (0, 0). L'impulsion déjà donnée au palet reste. Le maillet repart de zéro au pas suivant. (observé)

### Après un contact

Aucun contact n'est annulé avant la résolution. (observé)

Si un drapeau interne est allumé, la réponse ci-dessous est sautée. Son sens n'est pas lu. (observé pour le saut ; inconnu pour le drapeau)

Sinon, pour les deux corps du contact :

1. Si l'un est le palet (300) et si `|vx| + |vy| < 1` m/s (somme des valeurs absolues, pas la longueur du vecteur), sa vitesse est remplacée par deux tirages. Chaque composante vaut `u / 2³¹ − 1`, où u est un entier de 0 à 2³² − 1. Le résultat est dans [−1, 1) m/s, le 1 non compris. Si le nouveau vecteur n'est pas nul, le palet est réveillé. (observé)
2. Si l'autre est un maillet (301 ou 302), sa vitesse linéaire passe à (0, 0). (observé)

Le rebond effectif est celui du moteur. Il garde le plus grand des deux coefficients. En dessous d'un seuil de vitesse, le rebond est annulé : le seuil d'origine de ce moteur est 1 m/s, et il n'a pas été relu. (déduit pour le plus grand ; inconnu pour un seuil modifié)

Conséquences si ce mélange est en place, au-dessus du seuil. (déduit)

- Palet 0,85 contre maillet 0 : rebond 0,85.
- Palet 0,85 contre mur 0 : rebond 0,85.
- Palet 0,85 contre obstacle 1 : rebond 1.
- Palet 0,85 contre disque de coin 30 : rebond 30. La vitesse de séparation vaut 30 fois la vitesse d'approche.
- Maillet 0 contre disque de coin 30 : rebond 30.

La relance aléatoire a lieu après cette résolution. Si le palet est encore lent au sens de la somme des valeurs absolues, elle écrase le résultat du rebond. (observé pour le remplacement ; déduit pour l'ordre avec le rebond)

### Buts

Pas de capteur de but. À chaque image, la position du dessin du palet est lue en coordonnées du monde. (observé)

1. Ordonnée > 1280 : but numéroté 0. Le suivi du palet est retiré, le palet est désactivé.
2. Ordonnée < 0 : but numéroté 1. Même arrêt.
3. Sinon, rien.

Les bornes sont strictes : y = 0 et y = 1280 ne sont pas des buts. Toute abscisse compte. Le test ne regarde que y. (observé)

La largeur vraiment jouable est l'intervalle que les murs et les disques de coin laissent ouvert. Ce n'est pas une deuxième condition du test. (observé) Avec les centres approximatifs des murs latéraux, leurs faces internes sont près de x = 30 et x = 690. (déduit)

Le but n'est signalé qu'à cet endroit. (observé) À quel camp le point est donné pour 0 et pour 1 n'est pas dit ici. (inconnu)

## Valeurs

Échelle, pas, ressort. (observé, sauf les lignes marquées déduit)

| Quoi | Valeur |
| --- | --- |
| Table | 720 × 1280 pixels |
| Centre, palet au départ | (360, 640) |
| Maillet du bas, maillet du haut | (360, 320), (360, 960) |
| Mètres par pixel | 0,03125 |
| Pixels par mètre | 32 |
| Pas | 0,016 s, 6 itérations de vitesse, 2 de position |
| Pesanteur | (0, 0) m/s² |
| Rayon palet | 0,9375 m = 30 pixels |
| Rayon maillet | 1,875 m = 60 pixels |
| Rayon disque de coin | 0,4375 m = 14 pixels |
| Masse palet | densité 1, ≈ 2,761 kg (déduit) |
| Masse maillet | densité 30, ≈ 331,34 kg, soit 120 × le palet (déduit) |
| Rebond palet, maillet, barres, murs | 0,85 ; 0 ; 0 ; 0 |
| Rebond obstacle, disque de coin | 1 ; 30 |
| Frottement de toutes ces formes | 0 |
| Peau des polygones | 0,002 m |
| Borne du doigt | x [90, 630], y [100, 1180] |
| Refus du haut de table | y > 650 en modes 3 et 5 |
| Bascule des deux maillets | y < 640 en mode 4 |
| Fréquence du ressort | 10 000 Hz, ou 1 000 Hz en mode 5 |
| Amortissement du ressort | rapport 1 |
| Force max du ressort | masse × 20 000 N |
| Accélération max qui en suit | 20 000 m/s², +320 m/s par pas, 163,84 pixels/pas (déduit) |
| Recul mode 5 | 84 pixels = 2,625 m du centre du palet (déduit pour les mètres) |
| Vitesse CPU | 15, 27, 39, 51, sinon 27 |
| Facteur 0,7 sur la vitesse du CPU | allumé ou non selon un réglage dont le moment est inconnu |
| Erreur de frappe CPU | entier de −7 à 7 |
| Frappe simple, axe vertical | −0,5 × vitesse de base |
| Palet lent | \|vx\| + \|vy\| < 1 m/s |
| Relance | chaque axe dans [−1, 1) m/s |
| Filet du maillet du haut | hors x [0, 720] ou y [630, 1280] → (360, 960) |
| But | y monde > 1280 → 0 ; y monde < 0 → 1 |

Catégories. Masque « toutes » = 65 535. (observé)

| Corps | Catégorie | Accepte |
| --- | --- | --- |
| Palet | 4 | toutes |
| Maillet du bas | 1 | masque non recopié ; pas le maillet du haut ; au moins le palet (déduit) |
| Maillet du haut | 2 | masque non recopié ; pas le maillet du bas ; au moins le palet (déduit) |
| Barres du bas | 4096 | catégorie 1 seulement |
| Barres du haut | 4096 | catégorie 2 seulement |
| Murs latéraux | 8 | toutes |
| Murs de stage | 8 | toutes, groupe 0 |
| Obstacles 62, 63, 64 | 16 | catégorie 4 seulement |
| Disques de coin | non lue | palet et maillets, d'après les contacts |

## Inconnues

- Le sens des états 4 et 7, et le moment où le drapeau de partie coupe le pas.
- Le drapeau qui saute toute la réponse après contact.
- Où le palet est reposé quand son abscisse sort de [0, 720].
- Les bornes y = 630 et y = 1280 du filet du maillet du haut : lues une fois, non relues. L'ordre réel entre ce filet et le test de but.
- Le masque complet des deux maillets. Sans lui, on ne sait pas s'ils heurtent les murs latéraux et les murs de stage.
- La catégorie des disques de coin. Le rebond 30 n'a pas été relu.
- Le mode de contrôle 5 sans murs latéraux : la condition n'a pas été reprise en détail. Les centres (−10, 640) et (730, 640) sont approximatifs.
- Le seuil de vitesse sous lequel le rebond est annulé. La valeur d'origine, 1 m/s, n'a pas été relue. Le mélange « plus grand des deux rebonds » non plus : il est déduit du moteur, pas relu.
- Le plafond de translation par pas, souvent 2 m. S'il tient, il bat le plafond de force du ressort (64 pixels/pas au lieu de 163,84).
- L'axe du recul de 84 pixels en mode 5, et la taille en pixels du rectangle autour du palet.
- L'amortissement des maillets et leur échelle de gravité.
- Ce qui allume le facteur 0,7, et ce que compte le compteur qui doit dépasser 2 avant la frappe simple.
- La durée d'un tour d'obstacle, si la rotation du dessin tourne le corps, la cible exacte du second glissement, et les autres valeurs du paramètre de rotation.
- À quel camp le point est donné pour le but 0 et le but 1.
- Après le pas, un passage sur les contacts des numéros 499 (bouclier) et 300. L'effet n'a pas été suivi.
