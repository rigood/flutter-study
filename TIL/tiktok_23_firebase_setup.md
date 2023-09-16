## 틱톡클론 강의 내용 정리 (#23 Firebase setup)

#### Installation

#### Firebase CLI 설치하기

- npm으로 Firebase CLI 전역설치

  - 'firebase'는 내부 또는 외부 ~ 배치 파일이 아닙니다 오류 -> firebase가 설치된 폴더(`C:\Users\rigood\AppData\Roaming\npm`)를 시스템 환경변수 Path에 등록, vscode 재시작

  ```js
  npm install -g firebase-tools
  ```

- Firebase CLI 로그인

  ```js
  firebase login
  ```

- FlutterFire CLI 설치

  - `C:\Users\rigood\AppData\Local\Pub\Cache\bin` 시스템 환경변수 Path에 등록, vscode 재시작

  ```js
  dart pub global activate flutterfire_cli
  ```

#### 플러터에서 Firebase 설정

- 명령어 실행

  ```js
  flutterfire configure
  ```

  - create a new project 선택 -> 프로젝트명 입력(Firebase 전체에서 중복되지 않는 이름)
  - 플랫폼 선택 -> android, ios, web 선택

- core 플러그인 설치

  ```js
  flutter pub add firebase_core
  ```

- auth, cloud, storage 플러그인 설치

  ```js
  flutter pub add firebase_auth
  flutter pub add cloud_firestore
  flutter pub add firebase_storage
  ```

- 플러그인 설치 후 설정 최신화

  ```js
  flutterfire configure
  ```

  - 기존에 만들었던 앱 선택 -> 플랫폼 선택

- main.dart에서 Firebaes 초기화 설정

  ```dart
  // main.dart
  import 'package:firebase_core/firebase_core.dart';
  import 'package:프로젝트명/firebase_options.dart';

  void main async{
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  ```

</br>

### 23.2 AuthenticationRepository

#### 라우터 설정

- Provider를 이용하여 routerProvider를 생성

```dart
// router.dart
final routerProvider = Provider((ref) {
  return GoRouter(
    routes: [
      ...
    ]
  );
}
);
```

- 앱을 StatelessWidget->ConsumerWidget으로 바꾸고, build 메소드 두번째 인자로 WidgetRef 추가, routeConfig에 ref로 접근한 routeProvider를 넣어줌

```dart
// main.dart
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: ref.watch(routerProvider),
```

#### authentication repostiory 생성

- firebase authentication instance 생성
- 로그인여부, 현재 로그인한 사용자를 반환하는 getter 생성
- authRepo를 반환하는 Provider 생성
- authRepo를 통해 로그인여부를 확인하여 로그인되어있지 않으면 SignUp 화면으로 redirect 시킴

```dart
// authentication_repo.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthenticationRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool get isLoggedIn => user != null;
  User? get user => _firebaseAuth.currentUser;
}

final authRepo = Provider((ref) => AuthenticationRepository());
```

```dart
// router.dart
final routerProvider = Provider((ref) {
  return GoRouter(
    initialLocation: "/",
    redirect: (context, state) {
      final isLoggedIn = ref.read(authRepo).isLoggedIn;
      if (!isLoggedIn) {
        if (state.subloc != SignUpScreen.routeURL &&
            state.subloc != LoginScreen.routeURL) {
          return SignUpScreen.routeURL;
        }
      }
      return null;
    },
    routes: [
```
