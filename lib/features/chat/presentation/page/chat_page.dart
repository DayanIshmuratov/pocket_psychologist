import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocket_psychologist/common/components/text.dart';
import 'package:pocket_psychologist/features/auth/presentation/state/auth_cubit.dart';
import 'package:pocket_psychologist/features/chat/presentation/state/chat_cubit.dart';
import 'package:pocket_psychologist/features/chat/presentation/widgets/chat_widgets.dart';

class ChatPage extends StatelessWidget {
  Widget build(BuildContext context) {
    final chatCubit = context.read<ChatCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Чат'),
        centerTitle: true,
      ),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthUnSigned) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AppSubtitle(value: 'Войдите в аккаунт', color: Colors.black),
                  ElevatedButton(
                      onPressed: () async {
                        await Navigator.pushNamed(context, 'sign_in_page');
                      }, child: const AppText(value: 'Войти'))
                ],
              ),
            );
          } else if (state is AuthSigned) {
            return ChatWidgets(userData: state.userData, chatCubit: chatCubit,);
          } else if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return const Center(child: AppText(value: 'Такой ошибки быть не может. Удали читы'));

        },
      ),
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
