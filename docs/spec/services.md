# Services en ligne

> Partie de la spec salle blanche d'Air Hockey Challenge. Ticket : « Services en ligne : ce que fait chaque bouton ».

Hors ligne, chaque service se joue en local : la pub se « termine » tout de suite, l'achat crédite l'or, la connexion Play Jeux est un interrupteur, et les pages web ne s'ouvrent pas.

## Ce que fait le jeu

### Pubs

Trois formats. (observé)

- **Bannière** : un bandeau. Le jeu peut l'afficher ou le cacher.
- **Pub du milieu** : une seconde pub, distincte de la bannière. Le jeu peut l'afficher ou la cacher.
- **Plein écran** : une pub qui couvre l'écran, sans récompense.
- **Pub récompensée** : une pub à regarder jusqu'au bout. Si aucune n'est prête, il ne se passe rien.

Un drapeau « sans publicité » bloque seulement les quatre demandes d'affichage (bannière, milieu, plein écran, récompensée). Les demandes de masquage passent quand même. (observé)

Moments :

- À la fin de l'introduction, le jeu masque la pub du milieu. Au coup d'après, il masque la bannière. Si les pubs sont actives et que la liste « autres jeux » est prête, il ouvre l'écran des autres jeux. Sinon il ouvre le menu principal. Si le drapeau sans publicité est déjà vrai, il va au menu principal. (observé)
- Depuis la pause, recommencer la partie ou la quitter demande un plein écran seulement si le compteur d'avis est supérieur à 6. (observé)
- L'écran de résultat a une demande de plein écran qui ne teste pas ce compteur. On n'a pas vu quel délai l'appelle. (observé pour la demande, inconnu pour l'instant précis)
- Dernière chance, bouton « continuer avec une pub » : demande une pub récompensée, puis grise le bouton. Rien si le drapeau sans publicité est vrai. (observé)
- Menu principal, bouton de la pub qui donne de l'or : même demande, puis le bouton est grisé. (observé)
- Pas assez d'or pour continuer : le jeu masque la pub du milieu et ouvre la boutique. (observé)

Quand une pub récompensée est comptée comme finie, le jeu ajoute **20 or** et sauve. Si on est au menu et que le cadre « or gratuit » est ouvert, ce cadre s'affiche. (observé pour les 20 or, inconnu pour la ligne exacte qui confirme la fin de la pub)

### Achats d'or

La boutique, onglet or, montre **six boutons d'achat** tant que le drapeau sans publicité est faux. (observé)

Un achat réussi ajoute, selon le bouton : **3 000, 5 000, 11 000, 36 000, 65 000 ou 150 000 or**, puis un message de réussite. (observé)

Le prix affiché n'est pas un nombre fixe dans le jeu. (inconnu)

Les objets et les tables s'achètent avec l'or déjà en poche. Ce n'est pas un achat en ligne. S'il n'y a pas assez d'or, un message le dit et l'onglet or s'ouvre. (observé)

### Play Pass

Le jeu connaît un achat « Play Pass », à part des six packs. (observé)

Quand le drapeau sans publicité est vrai, l'onglet or ne montre plus les six packs. Il montre un calendrier de **7 jours** : 500, 500, 500, 1 000, 1 000, 1 000, puis 2 500 or. Au jour suivant, ouvrir cet onglet avance d'un cran (après le 7e, retour au 1er), ajoute l'or de ce jour, et pose une coche. Les jours déjà pris sont grisés avec une coche. Le même jour, rouvrir l'onglet ne redonne rien. (observé)

On n'a pas vu quel bouton met le drapeau à vrai, ni le clic du bouton « obtenir ». (inconnu)

### Play Jeux

Panneau Google, depuis le menu :

- Connexion, et déconnexion.
- Succès. Si on n'est pas connecté, le jeu demande d'abord la connexion, avec une attente, puis ouvre les succès.
- Classements. Même règle : connexion d'abord si besoin.
- Inviter un ami, et voir les invitations : le jeu envoie la demande, et cette version ne fait rien avec. (observé)

Les mêmes succès et classements sont aussi des boutons du menu principal. Un autre bouton du menu ouvre le panneau. (observé)

À la fin d'une partie en mode VS CPU, le jeu envoie **une** mise à jour de succès. À la fin d'un stage, il en envoie **quatre**. Les nombres exacts (combien de victoires, d'étoiles, quel stage) n'ont pas été lus. (observé pour le nombre d'envois, inconnu pour les conditions)

Dix succès :

| Rôle | Ce que le jeu envoie |
| --- | --- |
| Beau défi | déblocage, une fois |
| Cinquante et plus | une progression |
| Très facile | une progression |
| Facile | une progression |
| Un peu dur | une progression |
| Je suis le meilleur | une progression |
| Tout réussi | déblocage, une fois |
| Pique-nique d'étoiles, tour d'étoiles, voie lactée | les trois avancent ensemble, sur trois événements d'étoiles |

Les quatre progressions du milieu suivent les quatre difficultés, d'après leurs noms. Le nombre qu'il faut atteindre pour que le succès soit complet n'est pas dans les fichiers lus. (déduit pour le lien avec les difficultés, inconnu pour le seuil)

Six classements : stages, étoiles, et un par difficulté. Le jeu envoie un score. La formule du score n'a pas été lue. (observé pour la liste, inconnu pour la formule)

Les anciens messages de partie en ligne, d'invitation réelle et de sauvegarde en ligne ne sont pas traités par cette version. Il n'y a pas de match en ligne à simuler. (observé)

### Partage, avis, autres jeux, liens

- **Partage** (menu principal et options) : feuille de partage. Le texte est le lien de la fiche du jeu. Le titre est « 共有 » si la langue est le japonais, sinon « Share via ». (observé)
- **Avis** (menu principal et options) : ouvre la fiche du jeu sur le magasin. (observé)
- Un cadre d'avis existe. Le bouton qui accepte ouvre aussi la fiche, et met le compteur d'avis à 49. Les autres boutons ferment le cadre. La fonction prévue pour l'afficher est vide : on ne sait pas quand le cadre sort. (observé)
- **Aide** (options) : ouvre la page d'aide de l'éditeur pour ce jeu. (observé)
- **Autres jeux** : si la liste téléchargée est prête, le bouton ouvre un écran dans le jeu. Sinon, il ouvre la page de l'éditeur sur le magasin. Un clic sur un jeu de cet écran ouvre aussi la page de l'éditeur, pas la fiche du jeu touché. (observé)
- En quittant, un bouton peut mener au même écran, ou à la page de l'éditeur si la liste n'est pas prête. L'autre bouton ferme l'application. (observé)
- Le menu a aussi un bouton qui ouvre directement la page de l'éditeur. (observé)
- Des images Facebook et YouTube sont sur le menu. Le jeu sait ouvrir la page Facebook de l'éditeur et sa chaîne YouTube. Aucun bouton lu n'envoie ces deux demandes. (inconnu)

### Récompense à distance

Dans les options, le bouton récompense envoie l'identifiant du joueur à un serveur. Si la réponse est un nombre positif, ce nombre d'or est ajouté et un message de réussite s'affiche. Si la réponse est vide, négative, ou si l'appel échoue, un message d'échec s'affiche et l'or ne change pas. Délai d'attente : 5 secondes. (observé)

### Notifications

Le bouton « push » des options ne fait qu'un son. La fonction prévue pour ce réglage est vide. Le jeu ne déclare pas le droit d'afficher des notifications. Rien à simuler. (observé)

### Consentement

Les options ont un bouton qui ouvre la fenêtre de consentement. (observé)

Au démarrage, le jeu demande à la couche de consentement si le parcours est fini. Il sait aussi télécharger un numéro de version des conditions, et ouvrir les pages « conditions » et « données personnelles » de l'éditeur. (observé)

Les images montrent oui, non, en savoir plus, lire les conditions, et fermer. L'effet de chaque bouton de cette fenêtre n'a pas été lu. (inconnu)

Il existe aussi un écran d'accord, avec des cases conditions et vie privée. Le détail des cases n'a pas été lu. (observé pour l'existence, inconnu pour le parcours)

### Mesure invisible

Le jeu a de quoi noter le nom de l'écran affiché. On n'a pas listé les moments. Rien à montrer au joueur. (inconnu)

## Valeurs

| Service | Valeur |
| --- | --- |
| Or d'une pub récompensée finie | 20 |
| Packs d'or crédités | 3 000 ; 5 000 ; 11 000 ; 36 000 ; 65 000 ; 150 000 |
| Jours Play Pass | 500, 500, 500, 1 000, 1 000, 1 000, 2 500, puis on recommence |
| Plein écran depuis la pause | seulement si le compteur d'avis est supérieur à 6 |
| Avis accepté | le compteur passe à 49 |
| Plein écran alors que le compteur dépasse déjà 46 | le compteur est ramené à 47 |
| Attente du serveur de récompense | 5 secondes |
| Succès envoyés | 1 en fin de mode VS CPU, 4 en fin de stage |

Le drapeau sans publicité coupe l'affichage de la bannière, de la pub du milieu, du plein écran et de la pub récompensée. (observé)

## Inconnues

- Le prix de chaque pack, et le texte exact du bouton.
- Comment le drapeau sans publicité devient vrai, et ce que fait le bouton « obtenir » du calendrier.
- Le moment exact du plein écran sur l'écran de résultat, et l'endroit qui augmente le compteur d'avis de 1.
- Les conditions chiffrées des dix succès, et la formule des six classements.
- Quel bouton ouvre Facebook et YouTube, alors que les images et les pages existent.
- L'effet de chaque bouton de la fenêtre de consentement, et le parcours de l'écran d'accord.
- Si une copie de la sauvegarde part encore vers Play Jeux : les anciens messages prévus pour ça ne sont pas traités.
- Si le nom d'écran est vraiment envoyé, et quand.
