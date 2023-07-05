
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class MyButton extends StatelessWidget{
  final String label;
  final Function()? onTap;
  const MyButton({Key? key, required this.label, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: onTap,
      child:Container(
        margin: const EdgeInsets.only(left:35,right:20,top:25),
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: Colors.deepPurpleAccent,
        ),
        child: Container(
          alignment: Alignment.center,
          // margin: const EdgeInsets.only(top:10,left: 15),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            )
          ),
        ),
      )
    );
  }

}