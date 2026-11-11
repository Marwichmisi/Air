# Sons et musique

> Partie de la spec salle blanche d'Air Hockey Challenge. Ticket : « Sons et musique » (https://github.com/Marwichmisi/Air/issues/9).

Dix-huit sons sont livrés avec le jeu. Deux ne sont jamais joués. Il n’y a pas de curseur de volume : un effet part à plein volume, ou pas du tout. La musique aussi, et elle tourne en boucle. (observé)

## Ce que fait le jeu

### Au démarrage

Les deux interrupteurs, musique et effets, sont mis à « oui », puis la sauvegarde les remplace. Les dix-huit sons sont chargés en mémoire, y compris les deux qui ne joueront pas. Le nom de la musique en cours est vidé. (observé)

Tant que l’interrupteur des effets est à « non », aucun effet ne part. Un effet déjà en train de jouer n’est pas coupé par cet interrupteur. La musique ne regarde que son interrupteur à elle. (observé)

### Musique

Un seul morceau, **Musique du menu**, 40,229 s, en boucle, plein volume.

Elle démarre quand le menu principal est créé. Elle ne redémarre pas si une musique en boucle est déjà en cours. (observé)

Elle s’arrête, et **tous** les sons en cours avec elle, dans deux cas :

- le menu principal est détruit (le bouton du menu qui change de scène passe par là) ;
- le joueur coupe la musique dans les options.

(observé)

Rallumer la musique enregistre l’interrupteur, joue le clic, puis relance le morceau seulement si la partie n’est pas dans un mode de jeu (la valeur de mode vaut 0). En pleine partie, l’interrupteur change mais le morceau attend le prochain menu. (observé pour le test « mode = 0 » ; déduit pour « 0 veut dire hors partie », parce que les modes de jeu déjà lus valent 3, 4 ou 5)

Couper la musique n’émet pas le clic : l’arrêt général le mangerait. (observé)

Le raccord de boucle est sec : les 20 premières millisecondes et les 20 dernières ne se ressemblent pas. (observé)

### Clic

**Clic**, 0,993 s, une fois, plein volume, au début du traitement du bouton, avant l’action. Il suit l’interrupteur des effets.

Écrans où un bouton ou la touche retour le joue : menu principal, options, pause, résultat, boutique, choix des stages, carte de stage, annonce, avis, dernière chance, achat d’objet, sortie de partie, événement du jour, écran des autres jeux, et le cadre de consentement (au moins un de ses boutons). (observé)

Dans les options, le clic accompagne la musique qu’on rallume et les effets qu’on rallume. Il accompagne aussi les boutons de récompense, d’avis, d’aide, de partage, de fermeture et de consentement, plus un bouton qui ne fait que ce clic. Il n’accompagne pas la musique coupée, les effets coupés, ni les particules. (observé pour le clic, la musique, les effets et les particules ; le nom des autres boutons est celui déjà établi pour les services)

### Cadres qui s’ouvrent

À la création du cadre, avant le reste de l’écran :

| Son | Durée | Cadres |
|---|---|---|
| Ouverture | 0,209 s | achat d’objet, dernière chance, annonce, pause, avis |
| Boutique | 0,235 s | la boutique, à la place d’Ouverture |
| Achat manquant | 0,261 s | voir plus bas |

(observé)

**Achat manquant** part quand le joueur demande un objet dont le stock est 0 ou moins. Le cadre d’achat s’ouvre ensuite, et joue aussi Ouverture. Si le stock est au moins 1, l’objet est consommé et Achat manquant ne part pas. (observé)

Deux animations du cadre de consentement jouent chacune un son, arrêtent les mouvements en cours d’un panneau, puis le font glisser. L’une passe la valeur 1, l’autre la valeur 0. On n’a pas retrouvé quel bouton appelle laquelle. (observé pour les deux animations ; inconnu pour le bouton)

| Son | Durée |
|---|---|
| Consentement 1 | 0,261 s |
| Consentement 0 | 0,157 s |

### Contacts sur la table

Le palet porte le repère 300. Le son dépend du repère de l’autre corps. Les deux sens du contact aboutissent au même choix, une seule fois. (observé)

Tous ces sons sont sautés, ainsi que les étincelles qui suivent, quand un entier lu à travers le directeur d’affichage vaut au moins 1200. Cet entier n’a pas été nommé. (observé pour le seuil ; inconnu pour l’entier)

Si les étincelles sont coupées dans les options, le son part quand même. (observé)

| Son | Durée | Quand |
|---|---|---|
| Frappe du bas | 0,648 s | maillet du joueur, en bas, repère 301 |
| Frappe du haut | 1,050 s | maillet du CPU, en haut, repère 302 |
| Obstacle | 0,383 s | obstacle mobile, repère 22, ou bouclier, repère 499 |
| Pièce haute | 0,808 s | repère au moins 500, et seulement sur la branche où un test vaut 0 |

(observé pour les repères et les sons ; le bas et le haut viennent du montage des maillets : argument 0 → 301, argument 1 → 302, et ces deux positions sont déjà celles du joueur et du CPU)

Les coins de la table (repères 305 à 308) ne sont pas dans cette liste : ils ne jouent aucun de ces quatre sons. (déduit, parce que 305 à 308 ne tombent dans aucune des branches)

### But

**But**, 2,241 s, une fois, dès qu’un but est compté. Les deux cages utilisent le même son. Il part avant de regarder qui a marqué. (observé)

### Résultat

**Victoire**, 1,672 s. **Défaite**, 0,705 s.

- Stage : victoire si le résultat vaut 0, défaite s’il vaut 1. Une autre valeur ne joue ni l’un ni l’autre. (observé)
- Mode VS CPU : l’écran reçoit deux entiers. Victoire si le premier est strictement plus grand que le second, défaite sinon (égalité comprise). On n’a pas suivi lequel est le score du joueur. (observé pour la comparaison ; inconnu pour l’identité des deux entiers)

Sur une victoire de stage, chaque étoile affichée joue **Étoile**, 0,549 s. Les indices demandés vont de 0 au nombre d’étoiles moins un. **Étoile pleine**, 0,522 s, ne part que si l’indice est égal au nombre d’étoiles : l’animation ne demande jamais cet indice. (observé)

### Le téléphone

Quand l’application passe en arrière-plan, tous les sons sont mis en pause, puis l’animation s’arrête. Au retour au premier plan, l’animation reprend et tous les sons reprennent. Le simple passage « actif » relance aussi les sons. (observé)

Le téléphone ne vibre pas : la permission est déclarée, aucun appel ne s’en sert. (observé)

### Deux sons chargés pour rien

| Son | Durée | Fait |
|---|---|---|
| Double de l’ouverture | 0,209 s | octets identiques à Ouverture, jamais joué |
| Réserve | 0,414 s | jamais joué |

(observé)

Une fonction « tout couper » existe en double de l’arrêt de la musique. Rien ne l’appelle. L’arrêt de la musique fait déjà taire les effets. (observé)

Une fonction règle le volume de la musique à 0 ou à 1. Rien ne l’appelle. Le volume réel, à la lecture, est toujours 1. (observé)

## Valeurs

Tous les sons : une piste, entiers signés sur 16 bits. (observé)

| Son | Durée (s) | Échantillons / s | Lecture |
|---|---|---|---|
| Musique du menu | 40,229 | 44 100 | boucle |
| Clic | 0,993 | 44 100 | une fois |
| Achat manquant | 0,261 | 44 100 | une fois |
| Ouverture | 0,209 | 44 100 | une fois |
| Double de l’ouverture | 0,209 | 44 100 | jamais |
| Boutique | 0,235 | 44 100 | une fois |
| Consentement 1 | 0,261 | 44 100 | une fois |
| Consentement 0 | 0,157 | 44 100 | une fois |
| Victoire | 1,672 | 44 100 | une fois |
| Défaite | 0,705 | 44 100 | une fois |
| Étoile | 0,549 | 44 100 | une fois |
| Étoile pleine | 0,522 | 44 100 | une fois, indice jamais demandé |
| Frappe du bas | 0,648 | 48 000 | une fois |
| Frappe du haut | 1,050 | 44 100 | une fois |
| Pièce haute | 0,808 | 44 100 | une fois |
| Obstacle | 0,383 | 22 050 | une fois |
| But | 2,241 | 44 100 | une fois |
| Réserve | 0,414 | 48 000 | jamais |

Volume de lecture : 1. Pas de profil audio. (observé)

Interrupteurs, octet, 0 = coupé, toute autre valeur = ouvert. Valeur initiale avant la sauvegarde : 1 et 1. (observé)

| Bouton d’option | Ce qui est enregistré | Son |
|---|---|---|
| Particules éteintes | sorte 2, valeur 0 | aucun |
| Particules allumées | sorte 2, valeur 1 | aucun |
| Musique coupée | sorte 0, valeur 0, puis arrêt général | aucun |
| Musique rallumée | sorte 0, valeur 1 | Clic, puis Musique du menu si le mode vaut 0 |
| Effets coupés | sorte 1, valeur 0 | aucun |
| Effets rallumés | sorte 1, valeur 1 | Clic |

(observé)

La sorte 0 est l’interrupteur musique, la sorte 1 les effets, la sorte 2 les étincelles. (observé)

Repères de contact :

| Repère | Son |
|---|---|
| 301 | Frappe du bas |
| 302 | Frappe du haut |
| 22 ou 499 | Obstacle |
| ≥ 500, une branche | Pièce haute |
| 300 | le palet, pas un son à lui seul |
| 305 à 308 | aucun de ces sons |

Seuil qui coupe le son de contact : entier ≥ 1200. (observé)

Résultat de stage : 0 victoire, 1 défaite. (observé)

## Inconnues

- L’entier comparé à 1200 avant un son de contact. Le chemin part du directeur d’affichage, puis d’un mot situé très loin dans l’objet pointé. Rien d’autre dans le jeu ne lit cet endroit. On ne sait pas si c’est une hauteur, un compteur, ou autre chose. (inconnu)
- Quel bouton du consentement joue Consentement 1, et lequel joue Consentement 0. Les deux fonctions sont dans ce cadre, sans appel direct retrouvé. (inconnu)
- Lequel des deux entiers du résultat VS CPU est le score du joueur. (inconnu)
- Quels corps portent un repère ≥ 500. Ce ne sont ni les maillets, ni l’obstacle mobile, ni le bouclier, ni les quatre coins. (inconnu)
- Ce que fait la branche « repère ≥ 500 » quand le test n’est pas 0 : une animation part, le son Pièce haute non. (observé pour la coupure ; inconnu pour le sens du test)
- Si une sauvegarde sans ces clés laisse les interrupteurs à 1, ou les force à autre chose. L’init écrit 1 ; le chargement n’a pas été relu ici. (inconnu)
