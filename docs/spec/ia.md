# Maillet du CPU

> Partie de la spec salle blanche d'Air Hockey Challenge. Ticket : « IA du CPU » (https://github.com/Marwichmisi/Air/issues/4).

La table de jeu mesure 720 × 1280 pixels de design. Le joueur est en bas, le CPU en haut. L’axe y augmente vers le but du CPU. Le centre de la table est à y = 640. (observé)

Les quatre difficultés sont les entiers 0, 1, 2 et 3. 0 est la plus lente, 3 la plus rapide. Le mode VS CPU et les stages utilisent les mêmes tables : un stage ne fait que choisir l’un de ces quatre entiers. (observé)

## Ce que fait le jeu

Le CPU ne réexamine le palet que pendant la phase de jeu active. Deux autres phases coupent aussi le pas de physique ; pendant celles-là le CPU ne décide rien. (observé) L’intervalle exact entre deux réexamens n’est pas fixé dans la fonction elle-même. La chasse, une fois choisie, est relancée à chaque image. (observé pour la chasse ; inconnu pour la cadence du réexamen)

À chaque réexamen :

1. S’il n’y a pas de palet, ou si le CPU est dans l’état figé, ne rien faire. (observé)
2. Si le palet est sous y = 635 et que sa vitesse verticale est positive (il remonte vers le CPU), ne rien changer. (observé)
3. Si le palet est sous y = 635 et qu’il ne remonte pas, abandonner l’action en cours et rentrer au poste. (observé)
4. Si le palet est à y ≥ 635 et qu’il descend plus vite que 2 mètres par seconde, ne rien changer. (observé)
5. Si une attaque est déjà engagée, ne pas en lancer une autre. (observé)
6. Sinon, choisir une attaque. (observé)

Les vitesses du corps physique sont en mètres par seconde. Les positions des glissements sont en pixels de design, et leur durée en secondes. (observé)

### Rentrer au poste

Le maillet s’arrête (vitesse nulle) et glisse en ligne droite jusqu’au point (360, 1024). La durée dépend de la difficulté (tableau plus bas). Arrivé, il passe en patrouille. (observé)

### Patrouille

Deux glissements sont préparés, chacun vers un point tiré au hasard. Le tirage u (et v, un second tirage) est uniforme sur [0, 1), le 1 non compris. (observé)

- Zone gauche : x = 207 + u × 90, y = 1068 + v × 40. Donc x dans [207, 297), y dans [1068, 1108).
- Zone droite : x = 423 + u × 90, même formule pour y. Donc x dans [423, 513).

La durée de chaque glissement dépend de la difficulté, et ce n’est pas la même table que le retour au poste. (observé) Les deux trajets sont construits tous les deux ; qu’ils soient joués l’un après l’autre, puis relancés, est la lecture la plus simple. (déduit)

### Choisir une attaque

Si le palet est presque arrêté en montant (vitesse horizontale exactement 0, et vitesse verticale entre 0 et 0,1 mètre par seconde, bornes comprises), le CPU chasse tout de suite. (observé)

Sinon il tire un entier de 0 à 99, bornes comprises, et le compare à quatre poids qui somment à 100. (observé pour le tirage et les poids ; déduit pour « bornes comprises », parce que 100 issues tombent juste sur 100 pour-cent)

1. Si le tirage tombe dans la part A, il tente la frappe « derrière le palet ». Si le point n’est pas à portée, il chasse à la place. (observé)
2. Sinon, s’il tombe dans la part B, il tente l’interception. Même repli vers la chasse si le point n’est pas à portée. (observé)
3. Sinon il chasse. Les parts C et D mènent toutes les deux à cette chasse. (observé)

### Prévoir le palet

Pour A et pour B, le CPU fait tourner la physique en avance, jusqu’à 40 pas de 0,016 seconde. Chaque pas a 6 itérations de vitesse et 2 itérations de position, comme le vrai pas de la partie. Les quatre premiers pas sont joués mais pas encore testés. (observé)

Pendant cette avance, les deux maillets et jusqu’à trois autres corps (les obstacles, quand le stage en pose) ne collisionnent plus. Les bandes de la table restent. À la fin, positions, vitesses et collisions sont remises comme avant. (observé pour la coupure des collisions et la remise en place ; déduit pour « ce sont les obstacles »)

À partir du 5ᵉ pas (indice 4, puis 5, … jusqu’à 39), il mesure la distance en pixels entre son maillet et une cible. Il peut l’atteindre si cette distance est strictement plus petite que :

`vitesse × facteur × (indice du pas − 3)`

La vitesse est le nombre du tableau (15, 27, 39 ou 51). Le facteur vaut 0,7 si le maillet est rétréci, sinon 1. Ce budget est en pixels de design, pas en mètres : le même nombre sert ailleurs de mètres par seconde, sans conversion. (observé)

S’il y a un pas qui convient, le maillet glisse en ligne droite vers la cible. La durée du glissement est `(indice du pas − 3) × 0,016` seconde. À l’arrivée il frappe. (observé pour la durée et la cible ; déduit pour « la frappe part à l’arrivée », parce que la frappe est préparée avec exactement les nombres que le coup consomme)

- Frappe « derrière » (A). Cible : x du palet prévu, y du palet prévu + 50. Le pas est ignoré si ce y dépasse 1200. À la frappe, la vitesse horizontale est un entier tiré de −7 à 7, et la vitesse verticale est `−0,5 × vitesse × facteur` (vers le joueur). (observé)
- Interception (B). Cible : la position prévue du palet, sans le décalage de 50. Le pas est ignoré si y dépasse 1200. À la frappe, la vitesse est l’opposée de celle du palet, multipliée par `(difficulté + 1)`, plus un entier de −7 à 7 sur chaque axe. Pour les difficultés 0, 1, 2, 3 l’échelle vaut donc 1, 2, 3, 4. (observé)

### Chasse

À chaque image, tant que l’attaque n’a pas été annulée et que le palet n’est pas au-dessus de y = 1200, la vitesse du maillet pointe droit vers le palet. Sa grandeur est le nombre du tableau, en mètres par seconde, fois le facteur 0,7 ou 1. (observé)

### Sortie de zone

Si le maillet du CPU quitte x entre 0 et 720, ou y entre 630 et 1280, il est reposé à (360, 960). (observé)

### Bonus qui rétrécit le maillet

L’objet qui réduit le maillet pose le facteur à 0,7 et écrit un rayon de collision de 0,9375 mètre, soit la moitié du rayon normal. La chasse, la frappe « derrière » et le budget de la prévision sont ralentis. Les glissements (retour, patrouille, course vers le point prévu) gardent leur durée. (observé)

## Valeurs

Vitesse : nombre unique, trois usages. Prévision : ce nombre de pixels de design par pas de 0,016 s. Chasse : ce nombre de mètres par seconde vers le palet. Frappe « derrière » : la composante verticale vaut moins la moitié de ce nombre, en mètres par seconde. (observé)

| | 0 | 1 | 2 | 3 |
|---|---|---|---|---|
| Vitesse | 15 | 27 | 39 | 51 |
| Retour au poste (s) | 0,7 | 0,55 | 0,4 | 0,25 |
| Un glissement de patrouille (s) | 0,7 | 0,4 | 0,5 | 0,5 |
| Part A, frappe derrière (%) | 0 | 5 | 15 | 40 |
| Part B, interception (%) | 5 | 15 | 20 | 35 |
| Part C, chasse (%) | 35 | 30 | 35 | 20 |
| Part D, chasse aussi (%) | 60 | 50 | 30 | 5 |
| Échelle de la frappe B | 1 | 2 | 3 | 4 |

Si la difficulté n’est pas 0, 1, 2 ou 3 : vitesse 27, retour au poste 0,5 s, et les parts 0 / 5 / 35 / 60. (observé)

Constantes communes, toutes difficultés :

| Quoi | Valeur |
|---|---|
| Pas de physique, réel et prévu | 0,016 s, 6 itérations de vitesse, 2 de position |
| Pas prévus au maximum | 40 |
| Pas prévus sans test | les 4 premiers |
| Cible A, décalage | +50 pixels en y, +0 en x |
| Plafond des cibles | y = 1200 |
| Seuil « palet presque arrêté » | vx = 0 et 0 ≤ vy ≤ 0,1 m/s |
| Seuil « le palet est à moi » | y = 635 |
| Seuil « il descend déjà trop vite » | vy < −2 m/s |
| Tirage du choix | entier de 0 à 99 |
| Erreur de frappe | entier de −7 à 7 sur l’axe concerné |
| Facteur du maillet rétréci | 0,7 |
| Poste | (360, 1024) |
| Repos si sortie de zone | (360, 960) |
| Zone autorisée | x de 0 à 720, y de 630 à 1280 |
| Ancres de patrouille | (252, 1088) et (468, 1088) |
| Écart aléatoire en x | −45 + u × 90 |
| Écart aléatoire en y | −20 + v × 40 |

(observé)

Difficulté de chaque stage, de 1 à 300, dix par ligne. Seul cet entier change la force du CPU ; les bandes du stage restent visibles dans la prévision, les obstacles en sont retirés. (observé pour les entiers ; déduit pour l’effet des bandes et des obstacles)

```
  1- 10  0 0 1 1 1 0 1 0 1 1
 11- 20  0 0 1 1 1 0 1 0 1 1
 21- 30  0 0 1 1 1 0 0 0 1 1
 31- 40  0 0 1 1 1 0 1 0 1 1
 41- 50  0 0 1 1 1 0 0 0 1 1
 51- 60  0 0 1 1 2 0 1 0 1 2
 61- 70  0 1 1 1 2 0 1 1 1 2
 71- 80  0 1 1 1 2 0 1 1 1 3
 81- 90  0 1 1 1 2 0 1 1 1 3
 91-100  0 1 1 1 2 0 1 1 1 0
101-110  1 1 2 1 0 0 1 2 1 3
111-120  1 1 2 1 2 1 1 2 1 0
121-130  1 1 2 1 2 1 1 2 1 3
131-140  1 1 2 1 2 1 1 2 1 3
141-150  1 1 2 1 3 1 1 2 1 3
151-160  1 1 2 1 2 1 1 2 1 3
161-170  1 1 2 1 2 1 1 2 1 3
171-180  1 1 2 1 0 1 1 2 1 0
181-190  1 1 2 1 2 1 1 2 1 3
191-200  1 1 2 1 2 1 1 2 1 3
201-210  1 2 2 2 3 2 2 3 2 3
211-220  1 2 2 2 0 0 2 3 2 3
221-230  1 2 2 2 3 2 2 3 2 3
231-240  0 2 2 2 3 2 2 3 2 3
241-250  1 2 2 2 3 2 2 3 2 3
251-260  1 2 2 2 3 2 2 3 2 3
261-270  1 2 2 2 3 2 2 3 2 3
271-280  2 2 2 2 3 2 2 3 2 3
281-290  2 2 2 2 3 2 2 3 2 3
291-300  2 2 2 2 3 2 2 3 2 3
```

Comptage : 43 stages en 0, 121 en 1, 96 en 2, 40 en 3. (observé)

## Inconnues

- L’intervalle entre deux réexamens de l’état. La chasse est à chaque image ; la fonction qui choisit l’état n’a pas de délai en elle, et son branchement n’a pas été retrouvé dans la boucle physique. (inconnu)
- Le rapport pixels de design par mètre. Sans lui, on ne convertit pas les mètres par seconde de la chasse en pixels par seconde. Un calcul antérieur le plaçait à 32 ; ce n’est pas relu ici. (inconnu)
- L’ordre visuel des quatre boutons du menu par rapport aux valeurs 0, 1, 2, 3. Le code les écrit dans cet ordre ; la place à l’écran n’a pas été regardée. (inconnu)
- Ce qui met le CPU dans l’état figé, et ce que le joueur voit pendant les deux phases qui coupent la physique. (inconnu)
- Une table de durées moitié moindre (0,35 / 0,275 / 0,2 / 0,125 seconde) est en mémoire à côté des durées de retour. Aucune fonction relue ne s’en sert. (inconnu)
- La patrouille construit les deux trajets ; l’enchaînement exact (ordre, répétition) n’a pas été suivi jusqu’au rappel. (inconnu)
