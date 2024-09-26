
import 'package:chatapp/screens/ChatScreen.dart';
import 'package:chatapp/screens/login.dart';
import 'package:chatapp/screens/register.dart';

import 'package:go_router/go_router.dart';

class AppRouter {
  static const String initialPath = "/";
  static const String registerPath = "/register";
  static const String chatScreenPath = "/chatsScreenPath";

  static GoRouter router() => GoRouter(
    routes: [
      GoRoute(
        path: initialPath,
        builder: (context, state) =>  Login(),
      ),
      GoRoute(
        path: registerPath,
        builder: (context, state) =>  Register(),
      ),
      GoRoute(
        path: chatScreenPath,
        builder: (context, state) {
          final String email = state.extra as String;
          return ChatScreen(email: email,);
        },
      ),
    ],
  );
}
