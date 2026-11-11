# Or, boutique, récompenses et sauvegarde

> Partie de la spec salle blanche d'Air Hockey Challenge. Ticket : « Or, boutique, récompenses et sauvegarde » (https://github.com/Marwichmisi/Air/issues/7).

L'or est un compteur entier. On le gagne en jouant, une fois par jour, avec une pub, avec un achat, ou avec le Play Pass. On le dépense pour deux objets, pour les tables, ou pour reprendre une partie perdue. (observé)

## Ce que fait le jeu

### En jouant

Sur un stage, l'or n'arrive qu'en victoire, et seulement si le nombre d'étoiles de cette partie dépasse le meilleur déjà gardé pour ce stage. Le montant est celui de la nouvelle marque, pas la somme des marques plus basses. Une première victoire à 3 étoiles donne donc 10, pas 23. Améliorer plus tard un 1 en 2 donne 8. Une défaite ne donne rien. (observé)

En mode VS CPU, chaque victoire donne de l'or selon la difficulté choisie. Une défaite donne 0. Rien ne limite ça à la première victoire. (observé)

L'écran de résultat du mode VS CPU affiche, pour la difficulté en cours, le nombre de victoires, le nombre de défaites, et le pourcentage victoires / (victoires + défaites). (observé)

### Bonus du jour

Au menu, si aucun jour n'est encore enregistré, ou si le jour du calendrier a changé, un popup s'ouvre. Il ajoute 50 d'or dès l'ouverture, pas au moment où l'on appuie sur OK. Le jour est enregistré en même temps : fermer l'appli ne permet pas de reprendre les 50. Une fois par jour. (observé)

### Pubs

Deux messages de pub réussie ajoutent de l'or : l'un ajoute 20, l'autre ajoute 300. (observé)

Sans Play Pass, l'écran de dernière chance propose une pub.

- Si aucune continuation n'a encore été utilisée dans cette partie, la pub reprend la partie et n'ajoute pas d'or.
- Sinon, la pub ajoute 300 et ne reprend pas la partie. (observé)

Reprendre, par l'or ou par cette pub, annule le dernier point, remet le palet en place, retire les objets encore actifs, et fait monter le prix de la prochaine continuation. (observé)

L'écran de résultat du mode VS CPU propose aussi un bouton de pub. Il n'est pas créé si le Play Pass est actif. Le clic de ce bouton n'a pas été suivi jusqu'au message : les 300 correspondent au cas où aucune continuation n'est en attente. (observé pour le masquage et pour les 300 ; déduit pour le lien entre ce bouton et les 300)

### Achats

La boutique a trois onglets : or, objets, tables. (observé)

Sans Play Pass, l'onglet or montre six packs. Quand la boutique confirme l'index du pack, le jeu ajoute un nombre d'or fixe. Le prix en argent n'est pas dans le jeu : il est affiché tel que la boutique le renvoie. (observé)

S'il n'y a pas assez d'or pour un objet ou une continuation, la boutique s'ouvre et un court message dit qu'il manque de l'or. (observé)

### Play Pass

Un drapeau, faux pour un nouveau joueur, remplace les six packs par sept cadeaux. Un cadeau par jour de calendrier, dans l'ordre du cycle, puis le cycle repart au premier. Les jours déjà pris dans le cycle en cours sont cochés. Le même drapeau masque la pub de fin de partie et ignore la pub de dernière chance. (observé)

Qui passe le drapeau à vrai n'a pas été trouvé. (inconnu)

### Objets

Il y a deux objets. Un nouveau joueur en a 3 de chaque. (observé)

Le premier pose un mur en forme de bouclier et arme un compteur à 3. Quand l'effet s'arrête, le mur disparaît et le compteur revient à 0. Ce qui fait descendre le compteur n'a pas été suivi. (observé pour le mur et le compteur ; inconnu pour la durée)

Le second vise l'autre maillet, pas celui qu'on arrête au moment d'une reprise. Il coupe en deux un coefficient physique : 1,875 devient 0,9375. Il joue aussi une animation de taille, dont les facteurs n'ont pas été relus. L'icône est une flèche vers le bas. (observé pour le coefficient et l'icône ; déduit : l'effet rétrécit ce maillet)

En partie, s'il n'en reste plus, un popup vend 3 exemplaires pour 3 000. La boutique vend les deux objets aux mêmes tarifs : 3, 5 ou 11 exemplaires. (observé)

Une reprise retire les deux effets, sauf si un code de partie vaut 4. Au démarrage ce code vaut 5. Le sens du 4 n'est pas établi. (observé ; inconnu pour le 4)

### Tables

Neuf emplacements. Chacun vaut non possédé, possédé, ou équipé. Au départ, le premier est équipé et les huit autres ne sont pas possédés. (observé)

Acheter une table coûte 10 000 et l'équipe. L'ancienne équipée reste possédée. Un autre bouton équipe une table déjà possédée, sans payer. Le bouton qui paie ne vérifie pas « déjà possédée » avant de débiter. (observé)

Le neuvième emplacement est un lot. Il coûte 49 000 et débloque toutes les tables encore non possédées, sans changer celle qui est équipée. L'image du prix barré montre 70 000, soit 7 fois 10 000. Acheter les huit tables une par une marque aussi le lot comme déjà pris, sans le payer. (observé pour 10 000 et 49 000 ; déduit pour le sens du 70 000)

L'achat ne change aucun chiffre de partie, seulement l'apparence équipée. (déduit)

Deux images « −10 % » et « −30 % » sont dans le paquet d'images. Aucune chaîne du code ne les nomme. (inconnu)

### Continuer une partie perdue

Payer retire le prix du moment, puis reprend comme la pub gratuite. Le prix suit le nombre de reprises déjà faites dans la partie : 1 000, puis 2 000, et ainsi de suite jusqu'à 9 000. Ensuite il reste à 9 000. La pub gratuite fait monter ce prix elle aussi, puisqu'elle compte comme une reprise. (observé)

Pas assez d'or : la boutique s'ouvre, la partie ne reprend pas. (observé)

On n'a pas vu où ce compteur revient à 0 au début d'une nouvelle partie. (inconnu)

### Ce que la sauvegarde garde

Tout est local. Deux blocs sont aussi copiés vers le compte de jeu : l'or (avec objets, tables, victoires et Play Pass) et la progression des stages. Les réglages ne sont pas copiés. (observé)

La progression des stages est une suite de chiffres, un chiffre par stage débloqué. On ne remplace un chiffre que par un meilleur. Finir le dernier stage débloqué ajoute un 0 pour le suivant, tant qu'il reste des stages. Comme chaque valeur est un seul chiffre, seules les valeurs 0 à 9 survivent à un rechargement. Les étoiles tiennent dans 0, 1, 2 ou 3. (observé)

Un petit drapeau séparé retient si une sauvegarde de compte a déjà été utilisée. (observé)

Au premier lancement, avant toute sauvegarde : 100 d'or, 3 et 3 objets, première table équipée, stage 1 débloqué mais pas fini, 0 victoire et 0 défaite sur chacune des 4 difficultés, Play Pass inactif, cadeau Play Pass pas encore pris, particules allumées. (observé)

## Valeurs

### Or gagné

| Source | Montant |
|---|---|
| Stage, nouveau record de 1 étoile | 5 |
| Stage, nouveau record de 2 étoiles | 8 |
| Stage, nouveau record de 3 étoiles | 10 |
| Stage, défaite ou record non battu | 0 |
| VS CPU, victoire, difficulté 0 | 5 |
| VS CPU, victoire, difficulté 1 | 10 |
| VS CPU, victoire, difficulté 2 | 15 |
| VS CPU, victoire, difficulté 3 | 20 |
| VS CPU, défaite | 0 |
| Bonus du jour | 50 |
| Pub, message court | 20 |
| Pub, message de fin de pub | 300 |
| Pack payant 1 | 3 000 |
| Pack payant 2 | 5 000 |
| Pack payant 3 | 11 000, badge +10 % |
| Pack payant 4 | 36 000, badge +20 % |
| Pack payant 5 | 65 000, badge +30 % |
| Pack payant 6 | 150 000, badge +50 % |

Les badges +10 % à +50 % sont dessinés sur les boutons. Le prix en argent de ces packs n'est pas fixé dans le jeu. (observé)

### Play Pass, un cadeau par jour, puis on recommence

| Jour du cycle | Or |
|---|---|
| 1 | 500 |
| 2 | 500 |
| 3 | 500 |
| 4 | 1 000 |
| 5 | 1 000 |
| 6 | 1 000 |
| 7 | 2 500 |

Un joueur qui n'a jamais pris de cadeau commence au jour 1. (observé)

### Objets

| Achat | Quantité | Prix |
|---|---|---|
| Petit, en partie ou en boutique | 3 | 3 000 |
| Moyen, boutique | 5 | 5 000 |
| Grand, boutique | 11 | 10 000 |

Mêmes prix pour les deux objets. Départ : 3 et 3. (observé)

### Tables

| Achat | Prix | Effet |
|---|---|---|
| Une table | 10 000 | Elle devient équipée. L'ancienne équipée reste possédée. |
| Équiper une table déjà possédée | 0 | Change seulement l'équipée. |
| Lot des tables encore fermées | 49 000 | Les débloque sans changer l'équipée. Prix barré affiché : 70 000. |

Départ : table 1 équipée, tables 2 à 9 non possédées. (observé)

### Reprendre une partie

| Reprises déjà faites | Prix de la suivante |
|---|---|
| 0 | 1 000 |
| 1 | 2 000 |
| 2 | 3 000 |
| 3 | 4 000 |
| 4 | 5 000 |
| 5 | 6 000 |
| 6 | 7 000 |
| 7 | 8 000 |
| 8 ou plus | 9 000 |

Le compteur monte de 1 à chaque reprise. La table ci-dessus vaut s'il part de 0. On n'a pas vu le code qui le remet à 0 au début d'une partie. (observé pour les prix ; inconnu pour la remise à zéro)

### Départ d'un nouveau joueur

| Donnée | Valeur |
|---|---|
| Or | 100 |
| Chaque objet | 3 |
| Table équipée | la première |
| Autres tables | non possédées |
| Stage 1 | débloqué, pas fini |
| Stages suivants | fermés |
| Victoires et défaites | 0 sur chaque difficulté |
| Play Pass | inactif, aucun cadeau pris |
| Bonus du jour | pas encore pris |
| Particules | allumées |

### Contenu de la sauvegarde

| Bloc | Gardé | Copié vers le compte de jeu |
|---|---|---|
| Partie | or, nombre de chaque objet, état des 9 tables, table équipée, victoires et défaites des 4 difficultés, index et jour du cadeau Play Pass | oui |
| Réglages | musique, effets, particules, consentement, jour du bonus, identifiant de 12 caractères, compteur d'avis, table équipée une seconde fois | non |
| Stages | un chiffre par stage débloqué, le meilleur seulement | oui |
| Compte | un drapeau « sauvegarde de compte déjà utilisée » | non |

Le compteur d'avis, s'il dépasse 5 au chargement, est remis à 47. (observé)

Deux autres valeurs sont écrites avec les réglages : un compteur de bonus du jour, qui vaut 1 au départ et que le popup de 50 n'utilise pas, et un ordre de bonus qui est écrit mais jamais relu. (observé)

## Inconnues

- Qui passe le drapeau Play Pass à vrai. Tant qu'il reste faux, les six packs restent à la place des cadeaux.
- Le clic du bouton pub sur l'écran de résultat : on sait que le bouton existe et qu'un message de pub ajoute 300, pas que ce bouton envoie ce message.
- Quel écran envoie le message qui ajoute 20.
- Ce qui fait passer le compteur du bouclier de 3 à 0 : chocs, temps, ou les deux.
- Les facteurs de l'animation de taille du second objet. Le coefficient physique, lui, est connu.
- Le sens du code de partie 4, le seul cas où une reprise laisse les objets actifs.
- Où le prix de continuation revient à 1 000 au début d'une nouvelle partie.
- À quel moment les victoires et les défaites augmentent. On sait qu'elles sont gardées, affichées, et à 0 au départ.
- Si le bouton « acheter » d'une table disparaît une fois la table possédée. Le débit, lui, ne fait pas ce test.
- Si les images « −10 % » et « −30 % » sont montrées. Le code ne les nomme pas. Le −30 % collerait avec 49 000 au lieu de 70 000, mais ce n'est qu'un calcul.
- Le prix en argent des six packs. Seul l'or crédité est fixé dans le jeu.
- Les réglages de son d'un joueur sans sauvegarde. Les particules, elles, partent allumées.
