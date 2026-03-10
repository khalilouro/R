# Convertisseur à Bibi

## Description

Ce projet est une application développée avec **R et Shiny** permettant de convertir un nombre écrit dans une base comprise entre **2 et 36** vers d'autres bases numériques.

L'application permet également de convertir un nombre dans un **système spécial appelé Bibi-binaire** lorsque la base de destination n'est pas comprise entre 2 et 36.

## Fonctionnalités

* Conversion d’un nombre depuis une base comprise entre **2 et 36**.
* Conversion vers plusieurs bases différentes simultanément.
* Support des chiffres **0-9** et des lettres **A-Z** pour les bases supérieures à 10.
* Conversion automatique vers le **système Bibi-binaire** lorsque la base demandée est invalide.

## Principe du système Bibi-binaire

Le nombre est d'abord converti en **binaire**, puis chaque paire de bits est transformée selon le dictionnaire suivant :

| Bits | Code Bibi |
| ---- | --------- |
| 00   | HO        |
| 01   | HA        |
| 10   | HI        |
| 11   | HU        |

Si le nombre binaire possède un nombre impair de bits, un **0 est ajouté au début**.

## Structure du programme

Le projet contient plusieurs fonctions principales :

* **DecodeDigits(word)**
  Transforme les caractères d’un nombre en leurs valeurs numériques.

* **DecodeNumber(word, base)**
  Convertit un nombre écrit dans une base donnée vers un entier en base 10.

* **EncodeNumber(n, base)**
  Convertit un entier vers une base comprise entre 2 et 36.

* **EncodeBibi(n)**
  Convertit un entier vers le système **Bibi-binaire**.

* **Application Shiny**
  Fournit l’interface graphique permettant de saisir le nombre et les bases de conversion.

## Interface de l'application

L'interface contient :

* un champ pour saisir le **nombre**
* un champ pour la **base d'origine**
* trois champs pour les **bases de destination**
* l'affichage automatique des résultats

## Technologies utilisées

* **R**
* **Shiny**

## Lancement de l'application

Dans R ou RStudio :

```r
library(shiny)
runApp("nom_du_dossier_du_projet")
```

ou simplement :

```r
source("app.R")
```

## Auteur

Projet réalisé dans le cadre d’un exercice de programmation avec **R et Shiny**.
