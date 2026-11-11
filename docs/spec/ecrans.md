# Écrans et navigation

> Partie de la spec salle blanche d'Air Hockey Challenge. Ticket : « Écrans et navigation » (https://github.com/Marwichmisi/Air/issues/2).

Le jeu est en portrait. Le dessin fait 720 × 1280 et est étiré pour remplir l'écran. L'activité refuse un écran plus de 2,1 fois plus haut que large. La cadence est de 60 images par seconde. (observé)

## Ce que fait le jeu

### Ouverture

1. Sur un appareil en coréen, si l'accord n'a pas encore été donné (premier lancement, ou version des conditions absente), l'écran d'accord s'ouvre. Deux cases : conditions d'utilisation, et vie privée. Deux liens ouvrent les pages. Le bouton OK reste éteint tant que les deux cases ne sont pas cochées. OK enregistre, puis va au consentement s'il manque, sinon à l'introduction. La touche retour quitte le jeu. (observé)
2. Si le consentement est encore demandé, un écran montre une image de chargement au centre (360, 640) qui tourne sans arrêt, puis passe à l'introduction. Ses boutons et sa touche retour ne font rien. Le délai avant l'introduction n'est pas fixé dans ce qu'on a pu lire. Les images oui, non et fermer existent ; cet écran ne les pose pas. (observé pour le chargement et le passage à l'introduction ; inconnu pour le délai et pour ces images)
3. Sinon, l'introduction : fond blanc, logo, 2 secondes (un battement chaque seconde, changement au second). Ensuite, si les pubs sont actives et que la liste des autres jeux est prête, l'écran des autres jeux. Sinon le menu. Si le drapeau sans publicité est déjà vrai, le menu. (observé)

Depuis les options, un bouton ouvre la fenêtre de confidentialité du système, puis le cadre se retire. Le délai de retrait n'a pas été lu. (observé pour l'ouverture ; inconnu pour le délai)

### Menu principal

Quatre grands boutons, en colonne, au milieu de l'écran (moitié de la largeur, 37 % de la hauteur) :

- **Mode VS CPU.** Ouvre un cadre. Quatre boutons, difficultés 0, 1, 2 et 3, et un bouton pour fermer. Chaque difficulté affiche un pourcentage : victoires / (victoires + défaites) × 100, tronqué, ou 0 s'il n'y a eu aucune partie. Le choisir lance la partie en mode VS CPU à cette difficulté. (observé)
- **Deux joueurs sur le même écran.** Lance tout de suite. Chacun a un maillet : le bas si le doigt est sous le milieu, le haut sinon. Pas de CPU. (observé)
- **Stages.** Ouvre la liste. (observé)
- **Boutique.** Ouvre la boutique par-dessus. Le bouton d'or du haut ouvre la même boutique. (observé)

Barre du haut, collée au bord haut. De gauche à droite : quitter (6 % de la largeur), pub qui donne de l'or (27,5 %, absente si le drapeau sans publicité est vrai), bouton d'or (67 %), le nombre d'or (82 %), options (94 %). Ces boutons sont 70 pixels sous le haut de la barre. (observé)

Barre du bas. Avec les pubs : autres jeux, partage, Play Jeux. Sans les pubs : seulement Play Jeux, décalé vers la droite (75 % de la largeur). (observé)

Le bouton d'avis du menu est fabriqué, puis il n'est pas ajouté à l'écran. L'avis reste dans les options. Les images Facebook, YouTube et Game Center ne sont pas posées. (observé)

Autres boutons du menu : succès, classements, et le bouton qui fait entrer le panneau Play Jeux. Leurs effets de service sont dans la spec des services. (observé)

Le bonus du jour se pose par-dessus le menu quand la date sauvée est vide ou n'est pas celle du jour (année sur deux chiffres, mois, jour). Son bouton ferme le cadre. (observé)

Un verrou ignore les clics et la touche retour pendant qu'on quitte le menu vers une autre scène. (observé)

### Autres jeux

Le bouton pour commencer va au menu, quel que soit le jeu touché. Un autre bouton ouvre la page de l'éditeur, pas la fiche du jeu touché. La touche retour va au menu seulement si un drapeau interne est déjà vrai ; sinon elle ne fait rien. On n'a pas vu qui met ce drapeau. (observé pour les deux boutons et pour le test ; inconnu pour le drapeau)

### Liste des stages

300 stages, numérotés de 1 à 300 sans trou. La liste demande ce maximum divisé par 5, donc 60 lignes si la fonction renvoie bien le 300 qu'elle vient de ranger. On n'a pas lu le contenu d'une ligne : cinq cartes par ligne est la lecture la plus simple. (observé pour 300 et pour la division ; déduit pour le nombre de lignes et pour cinq cartes)

Une carte jouable montre 0, 1, 2 ou 3 étoiles. L'état 0 a en plus une lumière qui boucle. L'état verrouillé montre un cadenas et le bouton est éteint. Toucher une carte jouable lance ce stage. Le numéro écrit sur la carte est l'indice qu'on lui passe ; on n'a pas vu si la première carte affiche 0 ou 1. (observé pour les états et le lancement ; inconnu pour le numéro affiché)

Boutons de la liste : retour au menu, options, boutique. La touche retour, quelle qu'elle soit, ferme d'abord les options ou la boutique s'ils sont ouverts, sinon revient au menu. (observé)

### Partie

La touche retour, dans cet ordre : ferme l'avis s'il est ouvert ; sinon le cadre d'achat d'objet ; sinon la dernière chance ; sinon le résultat ; sinon, dans la pause, une annonce ouverte, ou la pause elle-même ; sinon ouvre la pause. (observé)

La pause a : reprendre, recommencer, quitter, et trois interrupteurs (particules, musique, effets). Recommencer relance la partie, et demande un plein écran si le compteur d'avis dépasse 6. Quitter attend 0,4 s dans ce même cas, sinon part tout de suite : vers la liste si c'était un stage, vers le menu sinon. Deux boutons de la pause ouvrent une annonce ; on n'a pas lu leur image. (observé)

On n'a pas vu quand le cadre d'achat d'objet s'ouvre. Des boutons d'édition de table existent dans la partie ; on n'a pas vu s'ils sont affichés. (inconnu)

### Fin de partie

Le score qui décide est 7. Quand le score du joueur atteint 7, c'est une victoire. L'autre score est celui de l'adversaire. (observé pour le 7 et pour les deux scores ; déduit pour « le 7 est le joueur », parce que seul ce cas compte une victoire et des étoiles)

Avant le panneau, deux textes : gagné et perdu, un en bas (25 % de la hauteur), l'autre en haut (75 %), celui du haut tourné de 180°. Le mot du joueur est en bas. Puis une animation au centre. Les durées n'ont pas été lues. (observé)

- **Mode VS CPU, le joueur n'a pas 7.** La dernière chance s'ouvre. Si elle est déjà là, une défaite est comptée pour cette difficulté et le panneau de résultat s'ouvre. (observé)
- **Mode VS CPU, le joueur a 7.** Une victoire est comptée. Le panneau s'ouvre, avec des particules au centre. (observé)
- **Stage, le joueur n'a pas 7.** Même partage : dernière chance, puis résultat sans étoile. (observé)
- **Stage, le joueur a 7.** Étoiles selon l'écart 7 − score adverse : 1 si l'écart vaut 1, 2 si l'écart vaut 2, 3 sinon. Le panneau s'ouvre. (observé)
- **Deux joueurs.** Pas de panneau. La première fois, les textes gagné / perdu. Si ces textes sont déjà là, la partie recommence. (observé)

Un cadre d'avis peut se poser en même temps que le résultat du mode VS CPU, le résultat d'un stage gagné, ou la fin à deux joueurs, quand le jeu décide qu'il est temps. La fonction prévue ailleurs pour le poser est vide. On n'a pas relu la condition. (observé pour l'endroit ; inconnu pour la condition)

Panneau de fin de stage : liste des stages, stage suivant (le numéro de stage augmente de 1), recommencer, et une pub d'or si les pubs sont actives. Une image « suivant éteint » est chargée ; on n'a pas vu quand elle remplace le suivant. La touche retour va à la liste. (observé ; inconnu pour l'image éteinte et pour le stage d'après le 300e)

Le code du panneau sait aussi revenir au menu et partager. On a lu ces boutons sur le résultat de stage seulement pour la liste, le suivant, recommencer et la pub. Le résultat du mode VS CPU n'a pas été relu bouton par bouton. Sa touche retour va au menu. (observé)

Dernière chance : abandonner ; continuer en payant l'or, ou ouvrir la boutique si l'or manque ; continuer avec une pub si les pubs sont actives. La touche retour ferme d'abord un cadre posé dessus (la boutique, c'est la lecture la plus simple), sinon elle compte la fin et ferme la dernière chance, ce qui ouvre le résultat. (observé pour les trois boutons et pour le retour ; déduit pour « le cadre du dessus est la boutique »)

### Quitter

Depuis le menu, le bouton quitter ou la touche retour (quand rien d'autre n'est ouvert) pose la confirmation. Un bouton ferme l'application. L'autre ouvre les autres jeux, ou la page de l'éditeur si la liste n'est pas prête. La touche retour, pendant que la confirmation est ouverte, la ferme au lieu de quitter. (observé)

La touche retour ferme aussi, dans l'ordre, le cadre de difficulté, le bonus du jour, la boutique, les options, puis rentre le panneau Play Jeux. Trois autres cadres sont fermés par la même touche ; on n'a pas vu qui les ouvre. (observé)

## Valeurs

| Quoi | Valeur |
|---|---|
| Dessin | 720 × 1280, étiré pour remplir, portrait, ratio max 2,1 |
| Cadence | 60 images par seconde |
| Introduction | battement 1 s, changement au 2e, donc 2 s |
| Chargement du consentement | centre (360, 640) |
| Colonne du menu | x = 50 %, y = 37 % |
| Titre | x = 50 %, y = 68 % |
| Quitter / pub or / or / montant / options | x = 6 % / 27,5 % / 67 % / 82 % / 94 %, y = hauteur de la barre du haut − 70 |
| Voile du cadre de difficulté | noir, alpha 120, deux fois |
| Pourcentage | victoires / (victoires + défaites) × 100, entier, sinon 0. Texte de taille 22 |
| Stages | 1 à 300. Lignes demandées = 300 / 5 |
| Score qui termine | 7 |
| Étoiles d'un stage gagné | écart 1 → 1, écart 2 → 2, sinon 3 |
| Attente en quittant la pause | 0,4 s si un plein écran est demandé, sinon 0 |
| Plein écran depuis la pause | seulement si le compteur d'avis dépasse 6 |

(observé, sauf le nombre de lignes : déduit, parce que le nombre renvoyé n'est pas écrit clairement, seul le 300 rangé l'est)

## Inconnues

- Le délai du chargement de consentement, et si les images oui / non apparaissent ailleurs que dans les fichiers.
- Le drapeau qui autorise la touche retour sur l'écran des autres jeux.
- Le numéro écrit sur la première carte, et si une ligne contient bien cinq cartes.
- Ce qui se passe sur « suivant » au dernier stage, et quand le suivant est éteint.
- Les boutons exacts du résultat en mode VS CPU.
- Quand le cadre d'achat d'objet s'ouvre, et les deux annonces ouvertes depuis la pause.
- La condition qui pose le cadre d'avis, et les trois cadres que la touche retour du menu sait fermer sans qu'on ait vu leur ouverture.
- Si la mise en arrière-plan ouvre la pause.
- Si les boutons d'édition de table sont visibles.
