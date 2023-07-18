import 'package:flutter/material.dart';
import '../constants.dart';
import '../models/messages_models.dart';
class CustomBubble extends StatelessWidget {
   CustomBubble({super.key, required this.message});
  Messages message;
  @override
  Widget build(BuildContext context) {
    return  Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(8),
        decoration:const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight:Radius.circular(15) ,
            bottomRight:Radius.circular(15),
          ),
          color: kPrimaryColor,
        ),
        child: Text(message.messages,style: TextStyle(color: Colors.white),),

      ),
    );
  }
}

class CustomBubbleForOthers extends StatelessWidget {
  CustomBubbleForOthers({super.key, required this.message});
  Messages message;
  @override
  Widget build(BuildContext context) {
    return  Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(8),
        decoration:const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight:Radius.circular(15) ,
            bottomLeft:Radius.circular(15),
          ),
          color: kPrimaryColor,
        ),
        child: Text(message.messages,style: TextStyle(color: Colors.white),),

      ),
    );
  }
}
