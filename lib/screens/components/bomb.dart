

import 'package:flutter/material.dart';
import 'package:minesweeper_game/utils/app_colors.dart';

class Bomb extends StatelessWidget {


  bool releaved;
  final function;


  Bomb({required this.releaved, this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Padding(padding: EdgeInsets.all(2.0),
        child: Container(
          color: releaved ? Colors.red : AppColors.AquaBlue,

      ),
    )
    );
  }
}
