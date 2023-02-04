import 'package:flutter/material.dart';
import 'package:minesweeper_game/utils/app_colors.dart';

class NumberOfBoxes extends StatelessWidget {


  final child;
  bool releaved;
  final function;

  NumberOfBoxes({this.child,required this.releaved, this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Padding(
       padding: EdgeInsets.all(2.0),
       child: Container(
          color: releaved ? AppColors.White : AppColors.AquaBlue,
         child: Center(
           child: Text(
           releaved ?(child == 0 ? "" : child.toString()) : "",
             style: TextStyle(
               fontWeight: FontWeight.bold,
               color: child == 1 ? Colors.blue :
                child ==  2 ? Colors.green : Colors.red
             ),
           ),
      )  ,
      )
    )
    );
  }
}
