import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants.dart';
import '../models/messages_models.dart';
import '../widgets/custom_bubble.dart';
class ChatPage extends StatelessWidget {
  ChatPage({Key? key}) : super(key: key);
   static String id='ChatPage';
  CollectionReference messages = FirebaseFirestore.instance.collection(kMessagesController);
  TextEditingController controller=TextEditingController();
  final ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    String email=ModalRoute.of(context)!.settings.arguments as String;
    return  StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(kTime,descending: true).snapshots() ,
        builder: (context,snapshot)
    {
       if(snapshot.hasData)
         {
           List<Messages> messageList=[];
           for(int i=0;i<snapshot.data!.docs.length;i++)
             {
               messageList.add(Messages.fromJson(snapshot.data!.docs[i]));
             }
           return Scaffold(
             appBar: AppBar(
               automaticallyImplyLeading: false,
               backgroundColor: kPrimaryColor,
               title: Text('Chat'),
               centerTitle: true,
             ),
             body: Column(
               children: [
                 Expanded(
                   child: ListView.builder(
                     reverse: true,
                     controller:_controller ,
                     itemCount: messageList.length,
                     itemBuilder: (BuildContext context, int index) {
                       return messageList[index].id ==email?
                       CustomBubble(message: messageList[index]):
                           CustomBubbleForOthers(message: messageList[index]);
                     },
                   ),
                 ),
                 Container(
                   //color: Color.fromARGB(255, 241, 241, 241),
                   child: Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: TextField(
                     controller: controller,
                       onSubmitted: (data)
                       {
                         if(data!="")
                           {
                             messages.add({
                               kMessages : data,
                               kTime:DateTime.now(),
                               'id':email,
                             });
                             controller.clear();
                             _controller.animateTo(
                              0,
                               curve: Curves.fastOutSlowIn,
                               duration: const Duration(milliseconds: 500),
                             );
                           }
                       },

                       decoration: InputDecoration(
                           focusedBorder: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(8),
                               borderSide: const BorderSide(
                                 color:Colors.black45,
                                 //width: 2,
                               )
                           ),
                           suffixIcon: Icon(Icons.send),
                           suffixIconColor: kPrimaryColor,
                           hintText: "Send Message",
                           border: OutlineInputBorder(
                             borderRadius:BorderRadius.circular(16),
                           ),
                           enabledBorder: OutlineInputBorder(
                             borderRadius:BorderRadius.circular(16),
                             borderSide: const BorderSide(
                                 color:Colors.black45
                             ),
                           )
                       ),
                     ),
                   ),
                 )
               ],
             ),
           );
         }
       else
         {
            return Text('Loading');
         }
    });
  }
}
