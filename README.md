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

Partie 1
--------

Vous trouverez ici un tutoriel pas à pas pour la réalisation d'une application Flutter. Cette application sera un jeu de morpion classique avec ses neuf boutons, avec une fonction définissant le joueur qui doit jouer et le remplissage de la case choisie. Lorsqu'une case sera choisie par un des deux joueurs nous la désactiverons et créerons une fonction pour définir le gagnant quand toutes les cases seront remplies. En fin d'application nous ajouterons un bouton refresh ainsi qu'un refresh du jeu en cas de match nul. En bonus, nous jouerons contre un ordinateur qui choisira au hasard une case vide lorsque l'on en choisira une nous-même.

Pour se faire nous allons commencer par créer un projet flutter dans notre IDE préféré. Et nous allons commencer par effacer ce qui est dans le fichier main.dart pour le remplacer par la notre :

dans ce fichier nous allons d'abord commencer par faire un import du package material.dart voici le code à rajouter au début du fichier main.dart :
```
import 'package:flutter/material.dart';
```
après avoir rajouté material.dart nous allons pouvoir commencer par la fonction main qui lancera notre application
```
// need this to run the app 
void main() => runApp(MyApp());
```
maintenant nous allons définir MyApp, nous créons une class qui sera une extension StatelessWidget et nous créons l'interface avec material app. 
```
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
```
Vous aurez une erreur sur la fonction HomePage() car nous n'avons pas encore créer le fichier qui l'a contient car nous allons utiliser un composant pour générer la page, en créant un fichier home_page.dart dans le même répertoire que le main.dart. Nous allons re importer le material dart dans ce nouveau fichier et puis l'importons dans le fichier main.dart que nous pouvons fermer. Dans le nouveau fichier nous pouvons commencer la structure de notre HomePage :
```
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // create structure (scaffold = échafaudage)
    return new Scaffold(
      // create application bar
      appBar: new AppBar(
        // create a title
        title: new Text("Morpion"),
      ),
      body: new Container()
    );
  }
}
```
Nous créons d'abord un StatefulWidget qui va créer l'état de l'application ensuite nous créons une classe qui sera une extension qui nous serira de layout. Nous utiliserons Scaffold, puis lui mettons une app bar avec un titre et enfin on lui donnera un body avec un simple container. A ce stade-ci vous devriez vous retrouver avec quelque chose comme ceci :

![application-final](https://raw.githubusercontent.com/petroons-jonathan/flutter-app/master/app-1.png)

Si ce n'est pas le cas, comparez votre code avec la première partie de ce tuto [ici](https://github.com/petroons-jonathan/flutter-app/tree/master/Step-by-step/step-1)

Partie 2
--------
Maintenant que nous avons notre début d'application, nous allons nous poser la question de ce qu'il nous faut en premier dans le jeu du morpion et ce sont les 9 cases à remplir pour jouer. Il faut que ses cases puissent être rempli c'est pourquoi nous partirons du principe que ce sont des boutons. 
Nous allons donc d'ores et déjà créer un nouveau fichier nommé game_button.dart toujours dans le même répertoire et toujours en lui important material dart. 
Dans ce fichier nous allons créer la class GameButton et lui paramêtrer ce dont nous aurons besoin pour la suite.
```
class GameButton {
  //give an id to the button 
  final id;
  // give the "x" or "O" 
  String text;
  // color of background 
  Color bg;
  // say if the button is already clicked
  bool enabled; 
  // GameButton class
  GameButton({
    this.id,
    this.text="",
    this.bg= Colors.grey,
    this.enabled = true,
  });
}
```
Nous aurons besoin que le bouton ait une id, un texte qui servira au remplissage, un background color de base qui changera selon la prise du joueur et en dernier savoir si le bouton est disponible ou pas.

Retournons maintenant dans notre fichier home_page.dart où nous pouvons importer le fichier game_button.dart.
Nous allons ensuite dans le top de la class `_HomePageState` pour y créer la liste de boutons et les initier par une fonction.

```
  //create list
  List<GameButton> buttonsList;

  @override
  void initState() {
    super.initState();
    buttonsList = doInit();
  }

  List<GameButton> doInit() {
    var gamebuttons = <GameButton>[
      // give 9 piece for the game
      new GameButton(id: 1),
      new GameButton(id: 2),
      new GameButton(id: 3),
      new GameButton(id: 4),
      new GameButton(id: 5),
      new GameButton(id: 6),
      new GameButton(id: 7),
      new GameButton(id: 8),
      new GameButton(id: 9),
    ];
    return gamebuttons;
  }
```
Maintenant que nous avons défini le nombre de bouton et leur état d'origine nous allons pouvoir retourner dans notre Widget Scaffold et changer le body par un système de grille, la grille aura un padding de 10 et nous controlerons le nombre de bouton par ligne (le morpion se jouant sur un plateau de 3x3) en créant le nombre de bouton qu'il y a dand la list buttonsList. Nous créerons des boîtes grâce à la fonction SizedBox et y placeront le bouton de jeu (RaisedButton) puis imbriquer dans celle-ci (souvenez-vous les widgets dans les widgets en mode poupée russe) un widget texte qui servira à remplir la boîte.

```
        body: new GridView.builder(
          padding: const EdgeInsets.all(10.0),
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.0,
              crossAxisSpacing: 20.0,
              mainAxisSpacing: 20.0),
          itemCount: buttonsList.length,
          itemBuilder: (context, i) => new SizedBox(
            width: 100.0,
            height: 100.0,
            child: new RaisedButton(
              padding: const EdgeInsets.all(8.0),
              onPressed: null,
              child: new Text(
                buttonsList[i].text,
                style: new TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              color: buttonsList[i].bg,
              disabledColor: buttonsList[i].bg,
            ),
          ),
        )
```
 A ce stade-ci vous devriez vous retrouver avec quelque chose comme ceci :

![application-final](https://raw.githubusercontent.com/petroons-jonathan/flutter-app/master/app-2.png)

Si ce n'est pas le cas, comparez votre code avec la deuxième partie de ce tuto [ici](https://github.com/petroons-jonathan/flutter-app/tree/master/Step-by-step/step-2)

Partie 3
--------
Maintenant que nous avons nos boutons, nous devrions un peu penser au jeu. Nous avons deux joueurs, qui joue l'un après l'autre en remplissant des cases et celui dont les trois cases verticales, horizontales ou diagonales gagne. Nous allons donc créer les variables que nous avons besoin (par soucis de clarté nous les placerons juste en dessous la `List<GameButton> buttonsList;` et nous aurons donc `var player1;` `var player2;` `var activePlayer;`
Et nous pouvons créer l'état de base qui sera :
```
void playGame(GameButton gb){
  // give a state to the game
  setState(() {
    if(activePlayer == 1){
      gb.text = "Be";
      gb.bg = Colors.blue;
      activePlayer = 2;
      // get id for winner function
      player1.add(gb.id);
    } else {
      gb.text = "Code";
      gb.bg = Colors.black;
      activePlayer = 1;
      // get id for winner function
      player2.add(gb.id);
    }
    gb.enabled = false;
    checkWinner();
  });
}
```
Nous allons utiliser une annotation rapide pour le GameButton et indiquons la fonction checkWinner que nous allons créer maintenant et qui sera la plus longue car elle va reprendre toutes les possibilités du jeu !
Nous aurons donc une structure qui s'articulera de cette manière :
```
  void checkWinner(){
        var winner = -1;
    if (player1.contains(1) && player1.contains(2) && player1.contains(3)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(2) && player2.contains(3)) {
      winner = 2;
    }
   }
```
Maintenant si nous reprenons notre jeu du morpion on peut gagner donc avec le groupement 1,2,3 puis 4,5,6 et ainsi de suite. Tout en pensant aux diagonales et vertciales ! Si vous avez décidez de tout taper vous même bravo ! sinon voici la liste :
```
void playGame(GameButton gb){
  // give a state to the game
  setState(() {
    if(activePlayer == 1){
      gb.text = "Be";
      gb.bg = Colors.blue;
      activePlayer = 2;
      // get id for winner function
      player1.add(gb.id);
    } else {
      gb.text = "Code";
      gb.bg = Colors.black;
      activePlayer = 1;
      // get id for winner function
      player2.add(gb.id);
    }
    gb.enabled = false;
    checkWinner();
  });
}

// create the function for the winner 
  int checkWinner(){
        var winner = -1;
    if (player1.contains(1) && player1.contains(2) && player1.contains(3)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(2) && player2.contains(3)) {
      winner = 2;
    }

    // row 2
    if (player1.contains(4) && player1.contains(5) && player1.contains(6)) {
      winner = 1;
    }
    if (player2.contains(4) && player2.contains(5) && player2.contains(6)) {
      winner = 2;
    }

    // row 3
    if (player1.contains(7) && player1.contains(8) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(7) && player2.contains(8) && player2.contains(9)) {
      winner = 2;
    }

    // col 1
    if (player1.contains(1) && player1.contains(4) && player1.contains(7)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(4) && player2.contains(7)) {
      winner = 2;
    }

    // col 2
    if (player1.contains(2) && player1.contains(5) && player1.contains(8)) {
      winner = 1;
    }
    if (player2.contains(2) && player2.contains(5) && player2.contains(8)) {
      winner = 2;
    }

    // col 3
    if (player1.contains(3) && player1.contains(6) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(3) && player2.contains(6) && player2.contains(9)) {
      winner = 2;
    }

    //diagonal
    if (player1.contains(1) && player1.contains(5) && player1.contains(9)) {
      winner = 1;
    }
    if (player2.contains(1) && player2.contains(5) && player2.contains(9)) {
      winner = 2;
    }

    if (player1.contains(3) && player1.contains(5) && player1.contains(7)) {
      winner = 1;
    }
    if (player2.contains(3) && player2.contains(5) && player2.contains(7)) {
      winner = 2;
    }

    if(winner != -1){
      if(winner == 1){

        );
      } else {

        );
      }
    }
    return winner;
  }
```
Nous avons délibérément laisser les champs vides car nous avons l'idée de créer une bôite de dialogue lorsque la victoire d'un des joueurs sera acquise ! pour cela nous allons créer un autre composant qui sera appelé. Pour ce faire créons un fichier nommé custom_dialog.dart, même rengaine quand il s'agit d'importer material et là nous allons créer notre class de dialog avec en supplément l'actien de refresh la partie :
```
class CustomDialog extends StatelessWidget {
  final title;
  final content;
  final VoidCallback callback;
  final actionText;

  CustomDialog(this.title,this.content,this.callback,[this.actionText="Reset"]);
  @override
  Widget build(BuildContext context){
    return new AlertDialog(
      title: new Text(title),
      content: new Text(content),
      actions: <Widget>[
        new FlatButton(
          onPressed:callback,
          color: Colors.white,
          child: new Text(actionText),
        ),
      ],
    );
  }
}
```
Retour dans le fichier home_page.dart auquel nous ajoutons notre nouvelle création :
```
    if(winner != -1){
      if(winner == 1){
        showDialog(
          context: context,
          builder:(_)=> new CustomDialog("Player 1 Won", "Press the reset button to start again.", resetGame)
        );
      } else {
        showDialog(
          context: context,
          builder:(_)=> new CustomDialog("Player 2 Won", "Press the reset button to start again.", resetGame)
        );
      }
    }
```
Vous devriez voir une erreur sur le CustomDialog, si vous êtes dans VS Code cliquez dessus, cliquez sur l'ampoule et fait "import custom_dialog.dart". Sinon rajoutez le à la main dans le dessus du fichier home_page.dart. Maintenant que nous avons la boîte de dialogue il nous manque la fonction resetGame pour relancer le jeu. 
Nous pouvons la construire comme suit :
```
void resetGame(){
  if(Navigator.canPop(context)) Navigator.pop(context);
  setState(() {
    buttonsList = doInit();
  });
}
```
Dernière petite modification, retour dans votre GriedView dans le RaisedButton nous devons changer la valeur de onPressed :
```
onPressed: buttonsList[i].enabled?()=>playGame(buttonsList[i]):null,
```
 A ce stade-ci vous devriez vous retrouver avec quelque chose comme ceci :
![application-final](https://raw.githubusercontent.com/petroons-jonathan/flutter-app/master/app-3.png)

Si ce n'est pas le cas, comparez votre code avec la deuxième partie de ce tuto [ici](https://github.com/petroons-jonathan/flutter-app/tree/master/Step-by-step/step-3)
