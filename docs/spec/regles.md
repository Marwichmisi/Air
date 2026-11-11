# Règles d'une partie

> Partie de la spec salle blanche d'Air Hockey Challenge. Ticket : Règles d'une partie.

Le terrain de référence mesure 720 × 1280. Le joueur humain est toujours en bas, sauf en mode 2 joueurs où le second humain est en haut, tête en bas. (observé)

Il y a trois modes. (observé)

- **Stage** : un stage numéroté, contre le CPU. L'indice de force du CPU (0 à 3) est propre à chaque stage.
- **Mode VS CPU** : une partie libre. La difficulté, de 0 à 3, est choisie avant le coup d'envoi.
- **2 joueurs** : les deux humains sur le même écran.

Les règles de but sont les mêmes dans les trois modes. Le reste (étoiles, objets, pause, dernière chance) ne l'est pas.

## Ce que fait le jeu

### Coup d'envoi

Les deux scores partent à 0. Le maillet du bas est en (360, 320), celui du haut en (360, 960), le palet au centre (360, 640). (observé)

Le palet reste inactif le temps d'une apparition, puis un court délai, puis il devient jouable. Les maillets, eux, répondent au doigt pendant cette attente. La durée exacte du délai n'est pas connue. (observé pour l'enchaînement, inconnu pour la durée)

### Comment on marque

Un but vaut 1 point, pour le camp qui l'a mis. (observé)

Après un but du bas, le palet réapparaît en (360, 768), dans la moitié haute. Après un but du haut, il réapparaît en (360, 512), dans la moitié basse. (observé pour les deux positions, déduit pour « quel camp vient de marquer »)

En stage seulement, le retour vers le haut s'accompagne d'une poussée vers le haut de 0,1 unité de monde par seconde. Les autres retours n'ont pas cette poussée. (observé)

Si le palet sort par la gauche ou par la droite (x hors de 0 à 720), il revient au centre, avec le même délai qu'au coup d'envoi. (observé)

Hors mode 2 joueurs, si le maillet du haut quitte l'écran ou descend sous y = 630, il est ramené en (360, 960). (observé)

### Fin de partie

Le premier camp qui atteint 7 buts a gagné. L'autre en a alors entre 0 et 6. Il n'y a pas de match nul, et pas d'autre condition de fin. (observé)

Il n'y a pas de chrono. Le texte « Time back » n'ajoute pas de secondes : il retire un but, voir plus bas. (observé)

### Stage

Même règle des 7 buts, sur le terrain du stage. La force du CPU change d'un stage à l'autre (indice 0 à 3). Elle ne change ni le score à atteindre, ni les étoiles. Les fichiers de stage ne contiennent pas de durée ni de score cible : seulement des murs, des obstacles et cet indice. (observé)

**Victoire** (le joueur a 7). Les étoiles viennent de l'écart, score du joueur moins score du CPU. (observé)

| Buts du CPU | Écart | Étoiles |
| --- | --- | --- |
| 6 | 1 | 1 |
| 5 | 2 | 2 |
| 0 à 4 | 3 à 7 | 3 |

On ne garde que le meilleur résultat déjà obtenu sur ce stage. Un moins bon passage ne l'abaisse pas. (observé)

**Défaite** (le CPU a 7, le joueur a moins). Une fenêtre « Time back » s'ouvre, une seule fois. Si le joueur la refuse, l'écran de résultat s'ouvre avec 0 étoile. (observé)

Gagner ouvre le stage suivant, qui part à 0 étoile et avec un halo. Un stage à −1 est cadenassé et ne se lance pas. Les états 0, 1, 2 et 3 se lancent : 0 sans étoile, 1 à 3 avec autant d'étoiles. Il y a 300 stages. On ne saute pas : seul le suivant du dernier stage connu s'ouvre. (observé)

L'écran de résultat propose : rejouer la même partie à 0-0, passer au stage suivant, revenir à la carte des stages, revenir au menu, partager, et une pub récompensée. Le bouton « suivant » a une variante grisée. Ce qui se passe au stage 300, et ce que donne la pub, n'est pas établi. (observé pour les actions, inconnu pour le stage 300 et la récompense)

### Mode VS CPU

Même fin en 7 buts. Pas d'étoiles.

À la défaite, la même fenêtre « Time back » s'ouvre une fois. Si on la refuse, l'écran de résultat montre les deux scores. Une victoire ou une défaite définitive augmente un compteur, séparé pour chaque difficulté. (observé)

Mêmes boutons de fin que le stage, sans carte d'étoiles. Rejouer remet les scores à 0 sans changer la difficulté choisie. (observé)

### 2 joueurs

Chacun tient son maillet : le doigt sous y = 640 tient celui du bas, le doigt au-dessus tient celui du haut. (observé)

À 7 buts, un bandeau s'affiche. Le camp qui a le plus gros score voit « win » de son côté, l'autre voit « lose ». Le texte du haut est tourné de 180°. Il n'y a pas d'étoiles, pas de « Time back », pas d'écran de résultat. Après un court délai (durée inconnue), un toucher relance la partie à 0-0, maillets remis en place, palet au centre. (observé, durée inconnue)

Le bouton pause ouvre le même panneau qu'en stage : continuer, recommencer, quitter, particules, musique et effets. (observé sur une partie lancée)

### Continuer, le « Time back »

Proposé en stage et en VS CPU, seulement à la défaite, une fois par défaite. Deux façons d'accepter. (observé)

- **Regarder une pub.** Le bouton se grise. À la fin de la pub, la partie reprend. Si un réglage coupe les pubs, ce bouton ne fait rien. (observé)
- **Payer en or.** Le prix dépend du nombre de fois où l'on a déjà continué dans cette partie : 1 000, puis 2 000, 3 000, 4 000, 5 000, 6 000, 7 000, 8 000, et 9 000 à partir de la neuvième fois. S'il manque de l'or, la boutique s'ouvre et la partie ne reprend pas. (observé)

Dans les deux cas, l'effet est le même. (observé)

- Le score du CPU (le haut) baisse de 1. Un 7-6 devient donc 7-6 avec le 7 du CPU ramené à 6, et on rejoue jusqu'à un nouveau 7.
- Le palet va en (360, 512), côté joueur.
- Le bouclier et le maillet rétréci du CPU sont annulés.
- Les boutons d'objets réapparaissent.

Recommencer la partie, ou en lancer une autre, remet le prix à 1 000. (observé)

Refuser ouvre l'écran de défaite. (observé)

### Objets d'aide

Deux stocks, séparés, gardés d'une partie à l'autre. Les boutons sont là en stage et en VS CPU. Ils s'affichent encore après un but encaissé, et après un « continuer ». Le premier toucher une fois la partie lancée les cache. Un stock à 0 ouvre la fenêtre d'achat au lieu d'appliquer l'effet. Les prix d'achat ne sont pas dans ce sujet. (observé)

Utiliser un objet dépense 1 unité et grise le bouton. (observé)

**Bouclier.** Une barre monte devant le but du bas, de y = −50 jusqu'à y = 30, centrée en x = 360, en environ 0,6 s. Elle encaisse 3 chocs de palet. Les deux premiers font une lueur, le troisième la brise et l'enlève. La largeur exacte de la barre n'est pas connue. (observé, largeur inconnue)

**Maillet du CPU réduit.** Son rayon est divisé par deux. Au repos il vaut 1,875 unité de monde, soit 60 pixels ; pendant l'effet, 30 pixels. L'effet s'arrête si le joueur marque, s'il continue, ou s'il recommence. Une formule prévoit aussi une vitesse du CPU multipliée par 0,7 pendant l'effet, mais rien n'a été vu qui l'appelle : on ne s'en sert pas. (observé pour le rayon et la fin de l'effet, 30 pixels déduit, vitesse écartée)

### Pause

En stage, en VS CPU et à 2 joueurs, un bouton ouvre la pause. Elle ne s'ouvre pas si la dernière chance, l'écran de fin ou la fenêtre d'achat est déjà là. (observé ; le mode 2 joueurs l'a été sur une partie lancée)

Le panneau propose : (observé)

- **Continuer** et la croix : on ferme la pause, les scores ne bougent pas.
- **Recommencer** : une confirmation, puis la partie repart à 0-0 (même effet qu'un rejouer de l'écran de résultat).
- **Quitter** : une confirmation, puis retour au menu. S'il y a une pub plein écran, l'attente est de 0,4 s, sinon elle est nulle.
- Trois interrupteurs : particules, musique, effets sonores.

Le code qui ouvre la pause ne fige pas explicitement le palet. Le pas de simulation ne s'arrête que dans deux états déjà utilisés pour l'écran de fin, pas au moment où la pause s'affiche. On ne sait pas si le palet continue sous le voile. (inconnu)

### Contrôle du maillet

Le doigt attire le maillet, dans les limites x de 90 à 630 et y de 100 à 1180. En dehors, le point est ramené au bord. (observé)

La prise a une force maximale de 10 000 en VS CPU et à 2 joueurs, et de 1 000 en stage : en stage le maillet suit moins sèchement. (observé)

- **VS CPU** : un doigt au-dessus de y = 650 est ignoré. En dessous, il tient le maillet du bas.
- **Stage** : même limite à y = 650. En plus, si le doigt est sur le cœur du palet (le rectangle central, moitié de sa taille), le maillet ne va pas sur le doigt : il se place 84 pixels en retrait du centre du palet, sur la ligne maillet–palet. (observé pour les 84 pixels et le rectangle, déduit pour « sur la ligne », une composante de l'angle n'ayant pas été relue)
- **2 joueurs** : partage à y = 640, comme plus haut. Pas de retrait de 84 pixels.

Le bouton manette du menu principal ouvre le panneau Google Play Jeux. Il ne change aucun de ces chiffres, et aucun autre réglage du menu (musique, effets, particules, notifications) ne le fait non plus. Il n'y a pas deux façons de viser. (observé)

### Recommencer

Scores à 0, prix du « continuer » ramené à 1 000, maillets aux positions de départ, palet au centre, bouclier et maillet rétréci annulés, boutons d'objets cachés, puis le même coup d'envoi. (observé)

## Valeurs

| Quoi | Valeur |
| --- | --- |
| Terrain de référence | 720 × 1280 |
| Buts pour gagner | 7 |
| Chrono de match | aucun |
| Maillet du bas au départ | (360, 320) |
| Maillet du haut au départ | (360, 960) |
| Palet au coup d'envoi et hors limites | (360, 640) |
| Palet après un but du bas | (360, 768) |
| Palet après un but du haut, et après « continuer » | (360, 512) |
| Poussée du palet vers le haut, stage seulement, après un but du bas | 0,1 unité de monde par seconde |
| Zone du doigt | x 90 à 630, y 100 à 1180 |
| Limite haute du maillet du bas (VS CPU et stage) | y = 650 |
| Partage des deux joueurs | y = 640 |
| Plancher du maillet du CPU | y = 630, sinon retour en (360, 960) |
| Échelle pixels → monde | ÷ 32 |
| Force de suivi du doigt, VS CPU et 2 joueurs | 10 000 |
| Force de suivi du doigt, stage | 1 000 |
| Retrait automatique en stage, si le doigt est sur le palet | 84 pixels |
| Étoiles | 1 si le CPU a 6, 2 s'il a 5, 3 s'il a 4 ou moins |
| Stages | 300, ouverts un par un |
| État d'un stage | −1 cadenas, 0 ouvert sans étoile, 1 à 3 étoiles |
| Chocs du bouclier | 3, puis il casse |
| Bouclier | x = 360, monte de y = −50 à y = 30, environ 0,6 s |
| Rayon du maillet du CPU | 60 pixels, 30 pendant l'objet 2 |
| Prix du « continuer », dans l'ordre | 1000, 2000, 3000, 4000, 5000, 6000, 7000, 8000, puis 9000 |
| Attente en quittant la pause s'il y a une pub | 0,4 s, sinon 0 |
| Difficultés du mode VS CPU | 4, numérotées 0 à 3 |
| Indice de force du CPU d'un stage | 0, 1, 2 ou 3, selon le stage |

## Inconnues

- Les durées d'apparition du palet, du délai avant qu'il reparte, du bandeau « win / lose » à 2 joueurs, et de l'attente après la pub du « continuer ». La montée du bouclier est d'environ 0,6 s, pas une valeur relue au chiffre près.
- La largeur et la hauteur exactes de la barre du bouclier.
- La composante horizontale exacte du recul de 84 pixels : le geste est clair, un nombre intermédiaire du calcul d'angle n'a pas été relu.
- Si la pause fige le palet. Rien, dans l'ouverture de la pause, n'arrête la simulation.
- Le stage 300 : le bouton « suivant » peut être grisé, la suite exacte n'a pas été lue.
- Ce que rapporte la pub récompensée de l'écran de résultat.
- Le prix des deux objets, et le stock de départ d'un profil neuf.
- L'état du stage 1 sur un profil qui n'a encore aucun fichier : le cadenas et le halo sont connus, pas la valeur écrite au premier lancement.
- Les noms affichés des quatre difficultés (seul le numéro 0 à 3 est établi).
