import 'dart:math';

import 'package:flutter/material.dart';
import 'package:minesweeper_game/screens/components/bomb.dart';
import 'package:minesweeper_game/utils/app_colors.dart';
import 'package:minesweeper_game/utils/app_style.dart';

import 'components/number_box.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {

  bool bombsRevealed = false;

  int numbersOfSquares = 9 * 9;

  int numbersInEachRow = 9;

  // numbers of bombs around , revealed = true / false
  var squareStatus = [];

  // bomb Location



  final List<int> bombLocation = [15,10,11,12,5,6,8,1,22,68,20,30,4,50,8];

  @override
  void initState() {
    super.initState();

    // initially each square has 0 bombs around, and is not revealed
    for (int i = 0; i < numbersOfSquares; i++) {
      squareStatus.add([0, false]);
    }
    scanBombs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.Grey,
      body: Column(
        children: <Widget>[
          Container(
            height: 150,
            color: AppColors.Grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(bombLocation.length.toString(), style: TextStyle(fontSize: 40,color: Colors.red,fontWeight: FontWeight.bold)),
                    Text("Bomb",style: TextStyle(color: AppColors.White,fontWeight: FontWeight.bold,fontSize: 15),)
                  ],
                ),
                GestureDetector(
                  onTap: restarGame,
                  child: Icon(
                    Icons.refresh,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("0", style: TextStyle(fontSize: 40)),
                    Text("T I M E",style: TextStyle(color: AppColors.White),)
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: numbersOfSquares,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: numbersInEachRow),
              itemBuilder: (context, index) {
                if (bombLocation.contains(index)) {
                  return Bomb(
                    releaved: bombsRevealed,
                    function: () {
                      // player tapped  the bomb , so player loses
                      setState(() {
                        bombsRevealed = true;
                      });
                      PlayerLose();
                    },
                  );
                } else {
                  return NumberOfBoxes(
                    child: squareStatus[index][0],
                    releaved: squareStatus[index][1],
                    function: () {
                      // reveal current box
                      revealBoxNumbers(index);
                      checkWinner();
                    },
                  );
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 40.0),
            child: Text(
              "C R E A T E D => M O A M E N ",
              style: TextStyle(
                  color: AppColors.White,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
          )
        ],
      ),
    );
  }

  void revealBoxNumbers(int index) {


    if (squareStatus[index][0] != 0){
      setState(() {
        squareStatus[index][1] = true;
      });
    }else if (squareStatus[index][0] == 0){
      // reveal current box , and  the  8 surrounding  boxes , unless you are on wall

      setState(() {
        // reveal current box
        squareStatus[index][1] = true;

        // reveal current box ( unless  we are  currently  in the left wall
        if ( index % numbersInEachRow != 0){
          // if next box isn't revealed yet and it is a 0 , then recurse
          if(squareStatus[index-1][0] == 0 && squareStatus[index-1][1]==false){
            revealBoxNumbers(index -1);
          }

          // reveal left box
          squareStatus[index - 1][1] = true;
        }


        // reveal current left box ( unless  we are  currently  in the left wall
        if ( index % numbersInEachRow != 0 && index >= numbersInEachRow){
          // if next box isn't revealed yet and it is a 0 , then recurse
          if(squareStatus[index - 1 - numbersInEachRow][0] == 0
              && squareStatus[index - 1 - numbersInEachRow][1]==false){
            revealBoxNumbers(index - 1 - numbersInEachRow);
          }

          // reveal left box
          squareStatus[index - 1 - numbersInEachRow][1] = true;
        }

        // reveal current top box ( unless  we are  currently  in the left wall
        if ( index >= numbersInEachRow ){
          // if next box isn't revealed yet and it is a 0 , then recurse
          if(squareStatus[index-numbersInEachRow][0] == 0
              && squareStatus[index-numbersInEachRow][1]==false){
            revealBoxNumbers(index -numbersInEachRow);
          }

          // reveal left box
          squareStatus[index - numbersInEachRow][1] = true;
        }


        // reveal current top right box ( unless  we are  currently  in the left wall
        if ( index >= numbersInEachRow && index % numbersInEachRow != numbersInEachRow - 1 ){
          // if next box isn't revealed yet and it is a 0 , then recurse
          if(squareStatus[index + 1 - numbersInEachRow][0] == 0 &&
              squareStatus[index + 1 - numbersInEachRow][1]==false){
            revealBoxNumbers(index + 1 - numbersInEachRow);
          }

          // reveal left box
          squareStatus[index + 1 - numbersInEachRow][1] = true;
        }

        // reveal current right box ( unless  we are  currently  in the left wall
        if ( index % numbersInEachRow != numbersInEachRow - 1 ){
          // if next box isn't revealed yet and it is a 0 , then recurse
          if(squareStatus[index + 1 ][0] == 0 &&
              squareStatus[index + 1 ][1]==false){
            revealBoxNumbers(index + 1 );
          }

          // reveal left box
          squareStatus[index + 1 ][1] = true;
        }

        // reveal current bottom right box ( unless  we are  currently  in the left wall
        if ( index < numbersOfSquares - numbersInEachRow && index % numbersInEachRow != numbersInEachRow - 1 ){
          // if next box isn't revealed yet and it is a 0 , then recurse
          if(squareStatus[index + 1 + numbersInEachRow][0] == 0 &&
              squareStatus[index + 1 + numbersInEachRow][1]==false){
            revealBoxNumbers(index + 1 + numbersInEachRow);
          }

          // reveal left box
          squareStatus[index + 1 + numbersInEachRow][1] = true;
        }

        // reveal current bottom  box ( unless  we are  currently  in the left wall
        if ( index < numbersOfSquares - numbersInEachRow ){
          // if next box isn't revealed yet and it is a 0 , then recurse
          if(squareStatus[index + numbersInEachRow][0] == 0 &&
              squareStatus[index + numbersInEachRow][1]==false){
            revealBoxNumbers(index + numbersInEachRow);
          }

          // reveal left box
          squareStatus[index + 1 + numbersInEachRow][1] = true;
        }

        // reveal current bottom left box ( unless  we are  currently  in the left wall
        if ( index < numbersOfSquares - numbersInEachRow && index % numbersInEachRow != numbersInEachRow - 0 ){
          // if next box isn't revealed yet and it is a 0 , then recurse
          if(squareStatus[index - 1 + numbersInEachRow][0] == 0 &&
              squareStatus[index - 1 + numbersInEachRow][1]==false){
            revealBoxNumbers(index - 1 + numbersInEachRow);
          }

          // reveal left box
          squareStatus[index - 1 + numbersInEachRow][1] = true;
        }
      });
    }

    // if current box is zero

  }

  void scanBombs() {
    for (int i = 0; i < numbersOfSquares; i++) {
      // ther are no boms around initialy
      int numberOfBombsAround = 0;

      // check each square  to see if it has bombs surrounding it
      // there are 8 surrounding boxes to check

      // check square to left, unless if it in the start column
      if (bombLocation.contains(i - 1) && i % numbersInEachRow != 0) {
        numberOfBombsAround++;
      }

      // check square to top left, unless if it in the first column or First row
      if (bombLocation.contains(i - 1 - numbersInEachRow) &&
          i % numbersInEachRow != 0 &&
          i >= numbersInEachRow) {
        numberOfBombsAround++;
      }


      // check square to top, unless if it in the first column or First row
      if (bombLocation.contains(i - numbersInEachRow) &&
          i >= numbersInEachRow) {
        numberOfBombsAround++;
      }

      // check square to top right, unless if it in the first column or First row
      if (bombLocation.contains(i + 1 - numbersInEachRow) &&
          i >= numbersInEachRow &&
          i % numbersInEachRow != numbersInEachRow - 1) {
        numberOfBombsAround++;
      }

      // check square to right, unless if it in the first column or First row
      if (bombLocation.contains(i + 1 ) &&
          i % numbersInEachRow != numbersInEachRow - 1) {
        numberOfBombsAround++;
      }

      // check square to bottom right, unless if it in the first column or First row
      if (bombLocation.contains(i + 1 + numbersInEachRow) &&
          i % numbersInEachRow != numbersInEachRow - 1 &&
          i < numbersOfSquares - numbersInEachRow) {
        numberOfBombsAround++;
      }

      // check square to bottom left, unless if it in the first column or First row
      if (bombLocation.contains(i - 1 + numbersInEachRow) &&
          i < numbersOfSquares - numbersInEachRow &&
          i % numbersInEachRow != 0) {
        numberOfBombsAround++;
      }

      // check square to bottom, unless if it in the first column or First row
      if (bombLocation.contains( i + numbersInEachRow) &&
          i < numbersOfSquares - numbersInEachRow ) {
        numberOfBombsAround++;
      }

      // this is to add total number of bombs around to square status
      setState(() {
        squareStatus[i][0] = numberOfBombsAround;
      });
    }
  }

  void PlayerLose() {
    showDialog(context: context, builder: (context){
       return AlertDialog(

         backgroundColor: Colors.red[900],
         actions: [
         MaterialButton(
           color: Colors.red[500],
           onPressed: (){
           restarGame();
           Navigator.pop(context);
         },
           child: Icon(Icons.refresh,color: AppColors.White,),

         )
       ]
         ,title: Center(child: Text("يا بني خد بالك الارض كلها متلغمة",style: TextStyle(color: AppColors.White,fontSize: 15),),),);
    });
  }

  void restarGame() {
    setState(() {
      bombsRevealed = false;
      for(int i = 0 ; i < numbersOfSquares; i ++){
        squareStatus[i][1] = false;
      }
    });
  }

  void playerWon(){
    showDialog(context: context, builder: (context){
      return AlertDialog(backgroundColor: Colors.green[800],
        actions: [
          MaterialButton(
            color: Colors.green[500],
            onPressed: (){
              restarGame();
              Navigator.pop(context);
            },
            child: Icon(Icons.refresh,color: AppColors.White,),

          )
        ]
        ,title: Center(child: Text("يا بني ايه يا لاذيناااااااا",style: TextStyle(color: AppColors.White,fontSize: 15),),),);
    });
  }

  void checkWinner(){
    // check how many boxes yet ro reveal
    int unrevealBoxes = 0;
    for(int i = 0 ; i < numbersOfSquares ; i++){
      if(squareStatus[i][1] == false){
        unrevealBoxes++;
      }
    }

    // if this number same the numbers of bombs, the player will win in game
    if(unrevealBoxes == bombLocation.length){
      playerWon();
    }
  }


}
