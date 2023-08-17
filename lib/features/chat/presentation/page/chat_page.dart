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