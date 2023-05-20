import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_psychologist/features/chat/presentation/state/chat_cubit.dart';

import '../../../../common/components/text.dart';
import '../../../auth/domain/entity/userData.dart';
import '../../domain/entity/message_entity.dart';

class ChatWidgets extends StatefulWidget {
  final UserData userData;
  ChatWidgets({required this.userData});
  State<ChatWidgets> createState() {
    return _ChatWidgetsState();
  }
}

class _ChatWidgetsState extends State<ChatWidgets> {
  List<Message> messages = [];

  @override
  void initState() {
    // TODO: implement initState
    // chatCubit.sendMessage();
    super.initState();
  }

  Widget build(BuildContext context) {
    final chatCubit = context.read<ChatCubit>();
    final messageController = TextEditingController();
    chatCubit.subscribe();
    return Column(
      children: [
        Expanded(
          child: StreamBuilder(
          stream: chatCubit.resultStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              messages.add(snapshot.data);
              // Update the UI with the new result
                return Expanded(
                  child: ListView.builder(
                      itemCount: messages.length,
                      itemBuilder: (context, i) {
                        return ListTile(
                          title: AppText(
                            value: messages[i].message,
                            color: Colors.red,
                          ),
                        );
                      }),
                );
              } else if (snapshot.hasError) {
              // Handle any errors
              return Text('Error: ${snapshot.error}');
            } else {
              // Initial loading state or no data yet
              return CircularProgressIndicator();
            }
          },
        ),
        ),
        TextFormField(
          controller: messageController,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: () {
                chatCubit.sendMessage(Message(
                    message: messageController.text,
                    userId: widget.userData.id,
                    date: null,
                    action: 'message'));
              },
              icon: Icon(Icons.send),
            ),
          ),
        ),
      ],
    );
  }
}




// import 'package:appwrite/appwrite.dart';
// import 'package:flutter/material.dart';
// import 'package:pocket_psychologist/common/components/text.dart';
// import 'package:pocket_psychologist/core/server/appwrite.dart';
// import 'package:pocket_psychologist/core/server/database.dart';
//
// class ChatPage extends StatefulWidget {
//   @override
//   State<ChatPage> createState() => _ChatPageState();
// }
//
// class _ChatPageState extends State<ChatPage> {
//   final userID = '646091f7b49e95e0c530';
//
//   final messageController = TextEditingController();
//   List<String> messages = [];
//   RealtimeSubscription? subscription;
//   @override
//   void initState() {
//     subscribe();
//     super.initState();
//   }

//   void subscribe() {
//     final realtime = Realtime(AppWriteProvider().client);
//     subscription = realtime.subscribe(['databases.chat.collections.messages.documents']);
//     subscription!.stream.listen((response) {
//       final result = response.payload;
//       messages.add(result['message']);
//       print(result['permissions']);
//       print(result);
//       setState(() {});
//     });
//   }
//   @override
//   void dispose() {
//     subscription!.close();
//     super.dispose();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Чат'),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           TextField(
//             controller: messageController,
//           ),
//           ElevatedButton(onPressed: () {
//             Future result = AppWriteDBProvider().db.createDocument(
//               databaseId: 'chat',
//               collectionId: 'messages',
//               documentId: ID.unique(),
//               data: {
//                 'message' : messageController.text,
//                 'user_id' : userID,
//                 'action' : 'message'
//               },
//             );
//           }, child: AppText(value: 'Отправить')),
//           Expanded(
//             child: ListView.builder(
//                 itemCount: messages.length, itemBuilder: (context, i) {
//                   return ListTile(
//                     title: AppText(value: messages[i],color:  Colors.red,),
//                   );
//             }),
//           ),
//         ],
//       ),
//     );
//   }
// }
