# Stages

> Partie de la spec salle blanche d'Air Hockey Challenge. Ticket : « Format des stages et stages 1 à 10 » (https://github.com/Marwichmisi/Air/issues/3).

Il y a 300 stages. Tous ont la même description : un entier de difficulté, huit bandes, et jusqu'à trois obstacles. Rien dans cette description ne fixe le nombre de buts ni les étoiles : c'est la même règle pour chaque stage. Cette partie détaille le format, puis les stages 1 à 10. (observé)

La table mesure 720 × 1280 pixels de design. Le joueur est en bas, le CPU en haut. L'axe y augmente vers le but du CPU. (observé)

## Ce que fait le jeu

Un stage choisit trois choses.

1. La difficulté du CPU : un entier 0, 1, 2 ou 3. 0 est la plus lente, 3 la plus rapide. C'est le même réglage que le mode VS CPU. Le stage ne fournit pas une autre table de vitesses. (observé)
2. Huit bandes, posées sur la table. (observé)
3. Zéro, un, deux ou trois obstacles. Un obstacle dont le type vaut 0 n'est pas créé, même si des coordonnées sont encore écrites à côté. (observé)

### Les huit bandes

Les emplacements sont numérotés de 0 à 7, dans cet ordre : deux par rangée, de la rangée du CPU vers la rangée du joueur, et dans chaque rangée la gauche puis la droite.

| Emplacements | Rangée | Ancre y |
|---|---|---|
| 0 gauche, 1 droite | côté CPU | 950 |
| 2 gauche, 3 droite | au-dessus du centre | 640 |
| 4 gauche, 5 droite | au-dessous du centre | 330 |
| 6 gauche, 7 droite | côté joueur | 20 |

L'ancre x vaut 10 à gauche et 490 à droite. Le centre d'une boîte est l'ancre plus le décalage du type. (observé)

Deux emplacements de la même colonne forment une paire : 0 avec 2, 1 avec 3, 4 avec 6, 5 avec 7. Chaque type appartient à une famille de longueur : (observé)

| Famille | Types |
|---|---|
| 1 | 1, 2, 5 |
| 3 | 3, 4, 6 |
| 2 | 9, 58, 59, 60, 61 |
| 0 | tous les autres, de 7 à 57 sauf 9 |

Si les deux types d'une paire sont de la même famille, une boîte supplémentaire est posée : 20 × 620 pixels, décalage x = 10, décalage y = 0 sur une rangée paire et 310 sur une rangée impaire. Sa famille de collision est la 3. (observé) Sinon, le type ajoute sa propre seconde boîte, quand il en a une. Les types 5, 6 et 9 n'ont pas de boîte à eux seuls : ils ne servent qu'à cette jonction. (observé)

Les quatre types de coin, relus jusqu'à la boîte :

| Type | Taille | Décalage (x, y) | Centre typique |
|---|---|---|---|
| 1 et 4 | 220 × 20 | (110, 300) | haut de la table, y = 1250 |
| 2 et 3 | 220 × 20 | (110, 10) | bas de la table, y = 30 |

La largeur de collision de cette famille (la 6) est encore multipliée par 0,9. Les boîtes sont immobiles. (observé)

Les autres types utilisés par les stages 1 à 10 sont des barres plus courtes, parfois penchées. Leurs tailles sont dans Valeurs. Leurs décalages exacts, autres que ceux du tableau ci-dessus, n'ont pas été recopiés jusqu'au bout. (inconnu pour ces décalages)

### Les obstacles

Trois emplacements. Le type 62 est un pentagone, 63 un triangle, 64 une barre de 120 × 10. Les sommets, en pixels de design, le centre de l'obstacle à l'origine : (observé)

- 62 : (0, 30), (−32, 6), (−22, −30), (22, −30), (32, 6)
- 63 : (0, 26), (−30, −26), (30, −26)
- 64 : (−60, 5), (60, 5), (60, −5), (−60, −5)

Seul le palet les heurte. Le rebond vaut 1, le frottement vaut 0. Le corps est immobile au sens du moteur : pendant un glissement il est replacé à chaque image, sans recevoir de vitesse. Le palet le retrouve à sa nouvelle place au pas suivant, il n'est pas poussé. (observé)

La place est une case d'une grille de 5 colonnes et 9 rangées. La colonne 0 est à gauche, la rangée 0 est côté joueur. (observé)

| Colonne | 0 | 1 | 2 | 3 | 4 |
|---|---|---|---|---|---|
| x | 130 | 230 | 360 | 490 | 590 |

| Rangée | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 |
|---|---|---|---|---|---|---|---|---|---|
| y | 160 | 280 | 400 | 520 | 640 | 760 | 880 | 1000 | 1120 |

Si la case de départ est (2, 5), sa rangée est réécrite en 6 avant la pose. La case d'arrivée ne change pas. (observé) Aucun obstacle actif des stages 1 à 10 ne part de (2, 5).

S'il n'y a pas de case d'arrivée, ou si elle est la même que le départ, l'obstacle ne glisse pas. Sinon, et seulement si la vitesse n'est pas 0, il va en ligne droite vers l'arrivée puis revient, en boucle. La durée d'un trajet, en secondes, est la distance en pixels divisée par (100 × vitesse). (observé)

La rotation est indépendante du glissement.

- Direction 0 : pas de tour.
- Direction 1 : un tour de −360°.
- Direction 2 : un tour de +360°.

La durée d'un tour est 3 / (vitesse + 1) secondes, même si la vitesse vaut 0 (alors c'est 3 secondes). Le tour se répète. (observé)

L'inclinaison de départ : 0 ne tourne pas le dessin au départ ; 1 le tourne de 45° ; 2 de 90° ; 3 de 135°. (observé) On n'a pas vu si cette rotation, ni le tour continu, font tourner la forme de collision ou seulement le dessin. (inconnu)

### Victoire et étoiles

Un but est marqué pour le joueur quand le palet passe au-dessus de y = 1280, et pour le CPU quand il passe sous y = 0. Toute la largeur compte. Le premier à 7 buts termine le stage. (observé)

Si le joueur atteint 7 :

| Buts du CPU | Étoiles |
|---|---|
| 6 (donc 7–6) | 1 |
| 5 (7–5) | 2 |
| 4 ou moins (7–4 jusqu'à 7–0) | 3 |

Si le CPU atteint 7 avant le joueur, le joueur a 0 étoile. Avant l'écran de défaite, un autre écran peut s'intercaler ; la condition exacte n'est pas fixée. (observé pour le 0 étoile ; inconnu pour cet écran)

Si un écran d'avis doit s'ouvrir au moment de la victoire, le calcul des étoiles n'est pas lancé dans le même passage. (observé)

Les étoiles ne sont pas dans la description du stage. Les stages 1 à 10 ont donc tous cette règle.

## Valeurs

Difficulté des stages 1 à 10 : 0, 0, 1, 1, 1, 0, 1, 0, 1, 1. (observé)

Sur les 300 stages, cet entier ne prend que les valeurs 0, 1, 2 et 3. (observé)

Bandes des stages 1 à 10. Chaque ligne est une rangée, gauche puis droite, du CPU vers le joueur. (observé)

| Stage | Haut | 2e rangée | 3e rangée | Bas |
|---|---|---|---|---|
| 1 | 1, 4 | 32, 30 | 31, 33 | 2, 3 |
| 2 | 1, 4 | 18, 19 | 31, 33 | 2, 3 |
| 3 | 1, 4 | 5, 6 | 5, 6 | 2, 3 |
| 4 | 1, 4 | 32, 30 | 31, 33 | 2, 3 |
| 5 | 1, 4 | 8, 6 | 7, 6 | 2, 3 |
| 6 | 1, 4 | 11, 10 | 24, 25 | 54, 56 |
| 7 | 1, 4 | 18, 19 | 28, 29 | 52, 50 |
| 8 | 55, 57 | 28, 29 | 5, 6 | 52, 50 |
| 9 | 1, 57 | 5, 9 | 24, 15 | 54, 50 |
| 10 | 55, 57 | 60, 61 | 32, 30 | 61, 60 |

Au stage 3, les quatre paires sont de même famille (1 avec 1, 3 avec 3). Les jonctions 20 × 620 sont donc posées. Aux stages 1, 2 et 4, aucune paire n'est de même famille. (observé)

Tailles des autres types présents ci-dessus, en pixels, boîtes créées avant le test du voisin. L'angle est celui de la barre penchée. (observé pour les tailles ; l'angle est observé là où il est écrit, sinon 0)

| Types | Boîtes |
|---|---|
| 7 | 20 × 372, penchée de −33° |
| 8 | 20 × 372, penchée de +33° |
| 10, 11 | deux barres 20 × 198, penchées de +33° et de −33° |
| 15, 18, 19 | 20 × 165, puis 120 × 20, puis 20 × 165 |
| 24, 25 | 20 × 165, puis 20 × 198 penchée |
| 28, 29 | 20 × 198 penchée, puis 20 × 165 |
| 30, 31, 32, 33 | 20 × 325,5, penchée de 18° (le signe dépend du type) |
| 50, 52 | 20 × 325,5 penchée, plus 120 × 20 |
| 54, 55, 56, 57 | 20 × 325,5 penchée, plus 220 × 20 |
| 60, 61 | 120 × 20, plus la jonction si la famille 2 est partagée |

Obstacles actifs des stages 1 à 10. Les stages 1 et 2 n'en ont pas. (observé)

| Stage | Type | Départ (px) | Arrivée | Vitesse | Tour | Inclinaison |
|---|---|---|---|---|---|---|
| 3 | barre | (360, 880) | aucune | 0 | +360° en 3 s | 0 |
| 4 | barre | (360, 880) | aucune | 0 | +360° en 3 s | 0 |
| 5 | barre | (230, 1120) | la même | 0 | −360° en 3 s | 0 |
| 5 | barre | (490, 1120) | la même | 0 | +360° en 3 s | 0 |
| 6 | pentagone | (230, 880) | (490, 880) | 3 | +360° en 0,75 s | 0 |
| 7 | pentagone | (590, 1120) | (230, 880) | 3 | +360° en 0,75 s | 0 |
| 7 | pentagone | (130, 1120) | (490, 880) | 3 | −360° en 0,75 s | 0 |
| 8 | triangle | (130, 1120) | (590, 1120) | 3 | +360° en 0,75 s | 0 |
| 8 | pentagone | (360, 520) | (360, 160) | 3 | +360° en 0,75 s | 135° |
| 9 | barre | (230, 760) | la même | 3 | +360° en 0,75 s | 0 |
| 10 | barre | (360, 400) | la même | 0 | −360° en 3 s | 0 |

Durées de glissement, distance / (100 × 3) : (observé)

| Trajet | Distance (px) | Durée d'un aller (s) |
|---|---|---|
| stage 6, (230, 880) → (490, 880) | 260 | 0,867 |
| stage 7, les deux diagonales | 432,7 | 1,442 |
| stage 8, (130, 1120) → (590, 1120) | 460 | 1,533 |
| stage 8, (360, 520) → (360, 160) | 360 | 1,2 |

Le stage 9 a une vitesse 3 mais les deux cases sont la même : il tourne, il ne glisse pas. (observé)

## Inconnues

- Le décalage local des types autres que 1, 2, 3 et 4. Les tailles et les angles ci-dessus sont lus ; le couple (x, y) ajouté à l'ancre ne l'est pas pour ces types, parce que les deux coordonnées ne sont pas toujours écrites dans le même registre. (inconnu)
- Le signe de l'angle de 18° pour chacun des types 30, 31, 32, 33, 50, 52, 54, 55, 56 et 57. On a vu +18° et −18°, pas encore lequel va à quel type. (inconnu)
- Si le tour et l'inclinaison font tourner la forme de collision, ou seulement le dessin. (inconnu)
- L'appel qui ouvre l'écran de résultat juste après le 7e but. Le but à 7 arrête l'échange, et l'écran lit les deux scores ; le branchement de l'un à l'autre n'a pas été suivi. (inconnu)
- La condition qui affiche l'écran intermédiaire avant la défaite. (inconnu)
- Quelle image de bande correspond à quel type. L'image est choisie par trois entiers, pas par le type seul. (inconnu)
