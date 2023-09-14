## 틱톡클론 강의 내용 정리 (#21 MVVM with provider)

### 21.0 Introduction

#### 이번 섹션에서 학습할 내용

- 설정화면에 영상 자동재생 옵션 추가
- 설정을 기기 저장소에 저장
- MVVM 아키텍쳐 (Model, View, View Model) 사용하여 설정화면 구현
- Repository 패턴 사용

</br>

### 21.1 MVVM

#### 아키텍쳐가 필요한 이유

- 관심사의 분리(하나의 파일은 한 가지 일만 한다.)
- 코드를 패턴에 따라 정리하면 유지보수가 편해짐

#### 아키텍쳐의 3가지 특징

- 개발자를 방해하지 않는다.
- 코드를 정리할 수 있게 해준다.
- 직관적이다.

#### MVVM

- Model: 데이터 (ex: automute: t/f, autosave: t/f)
- View: 화면, 사용자 입력, 이벤트 발생
- ViewModel: View와 Model을 연결 (ex: chnageNotifier)

#### Repository

- 별도의 파일에 구현된 클래스
- 저장소에 데이터 저장하는 역할 (ex: Firebase와 통신)

</br>

### 21.2 VideoPlaybackConfigRepository

#### model 생성

- 데이터 형태를 클래스로 만들고 생성자를 만든다.

```dart
class PlaybackConfigModel {
  bool muted;
  bool autoplay;

  PlaybackConfigModel({
    required this.muted,
    required this.autoplay,
  });
}
```

#### viewmodel 생성

```dart
class PlaybackConfigViewModel extends ChangeNotifier {}
```

#### repository 생성

- 데이터를 지속(persist)시키고, 데이터를 읽는 역할을 한다.
- sharedPreferences 패키지를 이용하여 기기 저장소에 데이터를 저장하고 가져온다.

```dart
import 'package:shared_preferences/shared_preferences.dart';

class PlaybackConfigRepository {
  static const String _autoplay = "autoplay";
  static const String _muted = "muted";

  final SharedPreferences _preferences;

  PlaybackConfigRepository(this._preferences);

  Future<void> setMuted(bool value) async {
    _preferences.setBool(_muted, value);
  }

  Future<void> setAutoplay(bool value) async {
    _preferences.setBool(_autoplay, value);
  }

  bool isMuted() {
    return _preferences.getBool(_muted) ?? false;
  }

  bool isAutoplay() {
    return _preferences.getBool(_autoplay) ?? false;
  }
}
```

</br>

### 21.3 PlaybackConfigViewModel

#### viewmodel 구현

```dart
class PlaybackConfigViewModel extends ChangeNotifier {
  final PlaybackConfigRepository _repository;

  late final PlaybackConfigModel _model = PlaybackConfigModel(
    muted: _repository.isMuted(),
    autoplay: _repository.isAutoplay(),
  );

  PlaybackConfigViewModel(this._repository);

  bool get muted => _model.muted;

  bool get autoplay => _model.autoplay;

  void setMuted(bool value) {
    _repository.setMuted(value);
    _model.muted = value;
    notifyListeners();
  }

  void setAutoplay(bool value) {
    _repository.setAutoplay(value);
    _model.autoplay = value;
    notifyListeners();
  }
}
```

#### main.dart에서 Provider 초기화

- SharedPreferences의 instance에 접근
- instance를 이용하여 Repository를 초기화
- Repository를 이용하여 ViewModel을 초기화

```dart
// main.dart

void main() async {
  final preferences = await SharedPreferences.getInstance();
  final repository = PlaybackConfigRepository(preferences);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => PlaybackConfigViewModel(repository),
      )
    ],
    child: const TikTokApp(),
  ));
}
```

#### watch, read 차이

- watch: 변하는 값을 알고 싶을 때, 값이 변하면 rebuild 됨
- read: 변하지 않는 값을 한번만 읽고 싶을 때, 주로 메소드를 불러올 때 사용

</br>

### 21.4 Views

#### addListener 달아주기

```dart
// video_post.dart

// initState 메소드에 코드 추가
  context
        .read<PlaybackConfigViewModel>()
        .addListener(_onPlaybackConfigChanged);
```

#### 변경된 값을 화면에 적용

```dart
// video_post.dart

  void _onPlaybackConfigChanged() {
    if (!mounted) return;
    final muted = context.read<PlaybackConfigViewModel>().muted;
    if (muted) {
      _videoPlayerController.setVolume(0);
    } else {
      _videoPlayerController.setVolume(1);
    }
  }
```

</br>

### 21.5 Code Challenge

- 기본적으로 설정 화면의 음소거 설정을 따르되, 비디오 화면에서 개별 영상의 음소거를 조절할 수 있도록 변경하기
