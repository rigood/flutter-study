## 틱톡클론 강의 내용 정리 (#18 Navigator2)

### 18.0 Introduction

#### 기존 내비게이션 방식

- `Navigator1`: named router를 사용하면 앞으로가기 불가
- `Material Page Route`: 앞으로가기 가능하지만 웹에서는 URL이 변경되지 않기 때문에 사용할 수 없음

#### Navigator2의 GoRouter로 마이그레이션

- Android, iOS, Web 모두 지원
- URL에 변수 사용 가능

</br>

### 18.1 GoRouter

#### 패키지 설치

```dart
// pubspec.yaml 파일 dependencies로 설치
go_router: 6.0.2
```

#### 사용방법

- lib폴더에 router.dart 파일 만들어서 GoRouter 생성

```dart
final router = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
```

- main.dart 파일의 MaterialApp을 MaterialApp.router로 변경하고, routerConfig에 router 지정

```dart
 return MaterialApp.router(
      routerConfig: router, // 라우터 지정
      home: const HomeScreen(), // 삭제
```

- 기존 내비게이션 방식 수정

```dart
// 기존 코드
  void _onBackTap() {
    Navigator.of(context).pop();
  }
// 수정된 코드
import 'package:go_router/go_router.dart';
  void _onBackTap() {
    context.pop();
  }
```

```dart
// 기존 코드
  void _onPrivacyTap() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const PrivacyScreen()),
    );
  }
// 수정된 코드
import 'package:go_router/go_router.dart';
  void _onPrivacyTap() {
    context.push("/settings/privacy");
  }
```

#### context.go()

- stack 구조를 거치지 않고 다른 화면으로 이동하는 메소드
- AppBar에 뒤로가기 버튼이 생성되지 않음 (브라우저에서는 뒤로가기 가능)
- stack에 페이지가 쌓이지 않기 때문에 pop 메소드도 사용할 수 없음

</br>

### 18.2 Parameters

#### URL에 변수 사용하기

- builder의 state.params로부터 변수를 얻을 수 있음
- 화면에 username을 넣어줄때 뒤에 느낌표(!)를 붙여주어 username이 null이 아니라고 알려줘야함

```dart
    GoRoute(
      path: "/users/:username",
      builder: (context, state) {
        final username = state.params['username'];
        return const UserProfileScreen(username: username!);
      },
    ),
```

</br>

### 18.3 queryParams

#### URL에 쿼리스트링 사용하기

- '/users/:username?show=like'라는 url을 사용한다고 가정
- state.queryparams로부터 쿼리스트링을 얻을 수 있음

```dart
    GoRoute(
      path: "/users/:username",
      builder: (context, state) {
        final username = state.params['username'];
        final tab = state.queryparams['show'];
        return const UserProfileScreen(username: username!, tab: tab!);
      },
    ),
```

#### extra parameter

- URL에 표시하지 않고 다른 화면에 데이터를 전달할 때 사용
- context.push()의 두번째 인자로 extra parameter를 보내고, extra는 어떠한 object라도 보낼 수 있음
- builder의 state.extra를 통해 데이터를 받을 수 있음

```dart
context.push("/login", extra: _username);

GoRoute(
    path: "/users/:username",
    builder: (context, state) {
        final username = state.extra;
        return const LoginScreen(username: username!);
    },
),
```

</br>

### 18.4 CustomTransitionPage

#### 페이지 전환 시 트랜지션 적용

- builder 대신 pageBuilder를 사용

```dart
GoRoute(
    path: "/users/:username",
    pageBuilder: (context, state) {
        return CustomTransitionPage(
            child: const UsernameScreen(),
            transitionBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(
                        scale: animation,
                        child: child,
                    )
                )
            }
        )
    },
),
```

#### context.pushNamed()

- URL 대신 name을 사용

```dart
context.pushNamed('username_screen');

GoRoute(
    name: 'username_screen',
    path: "/username",
    builder: (context, state) => const UseranmeScreen(),
),
```

#### nested routes

- "/signup/username/email" 과 같이 중첩된 URL 생성

```dart
   GoRoute(
      name: SignUpScreen.routeName, // "signup"
      path: SignUpScreen.routeURL, // "/"
      builder: (context, state) => const SignUpScreen(),
      routes: [
        GoRoute(
          path: UsernameScreen.routeURL, // "username"
          name: UsernameScreen.routeName, // "username"
          builder: (context, state) => const UsernameScreen(),
          routes: [
            GoRoute(
              name: EmailScreen.routeName, // "email"
              path: EmailScreen.routeURL, // "email"
              builder: (context, state) {
                final args = state.extra as EmailScreenArgs;
                return EmailScreen(username: args.username);
              },
            ),
          ],
        ),
      ],
    ),
```
