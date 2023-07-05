
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class CreateButton extends StatelessWidget{
  final String label;
  final Function()? onTap;
  const CreateButton({Key? key, required this.label, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return GestureDetector(
        onTap: onTap,
        child:Container(
          margin: const EdgeInsets.only(left:10,right:10,top:25),
          width: 80,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.deepPurpleAccent,
          ),
          child: Container(
            alignment: Alignment.center,
            // margin: const EdgeInsets.only(top:10,left: 15),
            child: Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                )
            ),
          ),
        )
    );
  }

}