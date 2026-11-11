# Air

Copie « salle blanche » du jeu mobile Air Hockey Challenge : on décrit le jeu original dans une spec, puis on le recode dans Godot à partir de cette spec seule.

## Le jeu

**Stage** :
Un niveau numéroté du jeu, joué contre le CPU.
_Avoid_ : niveau, map

**Difficulté** :
Un des 4 réglages de force du CPU, choisi pour une partie en mode VS CPU.
_Avoid_ : niveau, lv

**Mode VS CPU** :
Une partie libre contre le CPU, à la difficulté choisie.
_Avoid_ : mode solo, versus

**CPU** :
L'adversaire contrôlé par l'intelligence artificielle du jeu.
_Avoid_ : bot, IA (pour désigner l'adversaire)

**Physique fidèle** :
Le palet et les maillets suivent les formules décrites. Un écart invisible reste acceptable. Les points encore inconnus ne sont pas inventés.
_Avoid_ : ressenti, copie image par image

## La méthode

**Salle blanche** :
La méthode de copie où ceux qui lisent le jeu original ne sont jamais ceux qui codent la copie ; seule la spec passe de l'un à l'autre.
_Avoid_ : clean room, rétro-ingénierie (pour la méthode entière)

**Salle sale** :
Les sessions qui ouvrent le jeu original (APK, code décompilé, fichiers) pour écrire la spec.
_Avoid_ : dirty room

**Salle propre** :
Les sessions qui codent la copie à partir de la spec seule, sans jamais ouvrir le jeu original.
_Avoid_ : clean room

**Spec** :
La description du comportement du jeu (écrans, règles, physique, IA, stages), sans code ni fichier d'origine.
_Avoid_ : cahier des charges, doc

**Simulation hors ligne** :
Chaque service se joue sans réseau : l'effet du bouton arrive tout de suite, et aucune autre application ne s'ouvre.
_Avoid_ : SDK, vrai achat
