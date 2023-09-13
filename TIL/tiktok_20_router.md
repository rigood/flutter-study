## 틱톡클론 강의 내용 정리 (#20 Router)

### 20.2 Router part One

#### GoRouter와 Navigation 같이 사용 예정

- GoRouter: URL로 페이지 이동
- Navigation: URL 변경하지 않음, 회원가입 단계에 따라 페이지 이동(username->email->password->birthday)

#### Navigation

```dart
Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const UsernameScreen(),
    ),
);
```

#### GoRouter

```dart
// router.dart
final router = GoRouter(
  routes: [
    GoRoute(
      name: SignUpScreen.routeName,
      path: SignUpScreen.routeURL,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      name: LoginScreen.routeName,
      path: LoginScreen.routeURL,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      name: InterestsScreen.routeName,
      path: InterestsScreen.routeURL,
      builder: (context, state) => const InterestsScreen(),
    )
  ],
);

// 각 페이지에서 routeName, routeURL 지정
  static const String routeName = "interests";
  static const String routeURL = "/tutorial";

// 페이지 이동
context.pushNamed(LoginScreen.routeName);

// 해당 페이지로 push되지만 뒤로가기 할 수 없음(화면 스택 모두 제거)
context.pushReplacementNamed(InterestsScreen.routeName);
```

</br>

### 20.3 Router part Two

#### go, push 차이점

- push: stack에 화면 추가, 뒤로가기, pop 가능
- go: stack 자체를 교체, pushReplacementNamed와 같음

#### URL에 특정 params 사용

- 변수 옆에 괄호 열고 값 나열

```dart
// router.dart
  GoRoute(
      path: "/:tab(home|discover|inbox|profile)",
      name: MainNavigationScreen.routeName,
      builder: (context, state) {
        final tab = state.params["tab"]!;
        return MainNavigationScreen(tab: tab);
      },
    )
```

- 탭 인덱스 지정하기

```dart
// main_navigation_screen.dart
class MainNavigationScreen extends StatefulWidget {
  static const String routeName = "mainNavigation";

  final String tab;

  const MainNavigationScreen({
    super.key,
    required this.tab,
  });

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  final List<String> _tabs = [
    "home",
    "discover",
    "xxxx",
    "inbox",
    "profile",
  ];

  late int _selectedIndex = _tabs.indexOf(widget.tab);

  void _onTap(int index) {
    context.go("/${_tabs[index]}");
    setState(() {
      _selectedIndex = index;
    });
  }

  ...
}
```

</br>

### 20.4 Router part Three

#### 시작 페이지 지정

```dart
// router.dart
final router = GoRouter(
  initialLocation: "/inbox",
)
```

#### URL에 파라미터 전달하는 2가지 방법

1. push나 go를 사용하여 직접 URL 만들기
2. `pushNamed`에서 `params 옵션` 지정하기

```dart
// chats_screen.dart
  void _onChatTap(int index) {
    context.pushNamed(
      ChatDetailScreen.routeName,
      params: {"chatId": "$index"},
    );
  }

// router.dart
    GoRoute(
      name: ChatsScreen.routeName,
      path: ChatsScreen.routeURL,
      builder: (context, state) => const ChatsScreen(),
      routes: [
        GoRoute(
          name: ChatDetailScreen.routeName,
          path: ChatDetailScreen.routeURL,
          builder: (context, state) {
            // parms 추출
            final chatId = state.params["chatId"]!;
            return ChatDetailScreen(
              chatId: chatId,
            );
          },
        )
      ],
    ),

// chat_detail_screen.dart
class ChatDetailScreen extends StatefulWidget {
  static const String routeName = "chatDetail";
  static const String routeURL = ":chatId";

  final String chatId;

  const ChatDetailScreen({
    super.key,
    required this.chatId,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}
```

</br>

### 20.5 Router part Four

#### 아래에서 올라오는 페이지 전환효과 구현

```dart
  GoRoute(
      path: VideoRecordingScreen.routeURL,
      name: VideoRecordingScreen.routeName,
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const VideoRecordingScreen(),
        transitionDuration: const Duration(milliseconds: 200),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final position = Tween(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(animation);
          return SlideTransition(
            position: position,
            child: child,
          );
        },
      ),
    )
```
