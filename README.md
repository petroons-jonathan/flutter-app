# Workshop sur Flutter

Vous trouverez un manuel d'installation de Flutter pour pouvoir commencer le workshop qui se divisera en plusieurs partie.

+ Une partie théorique avec présentation de Flutter et les bases de Dart. 


+ La création d'une première application Flutter dit "Hello World".


+ La création d'un layout d'une application (tutoriel layout de flutter).


+ Et enfin la création d'un jeu de morpion. 

Le jeu du morpion sera lui-même divisé en plusieurs sous section et vous pouvez trouver les différentes étapes du code dans le dossier Step-by-step où chaque partie a été divisé. 

Certains fichiers ne doivent être réalisés qu'une seule fois mais par soucis de facilité, ils ont été intégré à chaque étape.


Vous pouvez trouver la présentation [ici](https://1drv.ms/p/s!Asi6b0PZXylnjADzCDbMP8SMInUW?e=T0sJ4l)
Vous pouvez trouvez la documentation concernant Dart [ici](https://1drv.ms/w/s!Asi6b0PZXylni354tUhmy1m1g_SU?e=as2vVY)
Pour plus d'information concertant Flutter et son installation vous pouvez vous référer à la [documentation Flutter](https://flutter.dev/docs)



Tutoriel Flutter Morpion
========================

Vous trouverez ici un tutoriel pas à pas pour la réalisation d'une application Flutter. Cette application sera un jeu de morpion classique avec ses neuf boutons, avec une fonction définissant le joueur qui doit jouer et le remplissage de la case choisie. Lorsqu'une case sera choisie par un des deux joueurs nous la désactiverons et créerons une fonction pour définir le gagnant quand toutes les cases seront remplies. En fin d'application nous ajouterons un bouton refresh ainsi qu'un refresh du jeu en cas de match nul. En bonus, nous jouerons contre un ordinateur qui choisira au hasard une case vide lorsque l'on en choisira une nous-même.

Pour se faire nous allons commencer par créer un projet flutter dans notre IDE préféré. Et nous allons commencer par effacer ce qui est dans le fichier main.dart pour le remplacer par la notre :

dans ce fichier nous allons d'abord commencer par faire un import du package material.dart voici le code à rajouter au début du fichier main.dart :

import 'package:flutter/material.dart';

-- 
import 'package:flutter/material.dart';
import 'home_page.dart';

// need this to run the app 
void main() => runApp(MyApp());

// the entire application is a widget 
class MyApp extends StatelessWidget {
  @override
  // build widget 
  Widget build(BuildContext context){
    return new MaterialApp(
      theme: ThemeData(primaryColor: Colors.green),
      home: new HomePage(),
    );
  }
}
--


