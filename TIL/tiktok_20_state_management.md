## 틱톡클론 강의 내용 정리 (#20 State Management)

### 20.0 Introduction

#### State management

- 데이터 변경을 감지하고 실제 데이터를 변경하는 방식
- 위젯과 데이터를 분리하여 앱을 체계적으로 관리할 수 있음
- Inherited Widget, changeNotifier, provider, Riverpod 등 학습 예정

</br>

### 20.6 InheritedWidget

#### InheritedWidget 장점

- 위젯 트리 맨 위에 정의된 값을 하위 위젯에서 사용할 수 있음
- 예시: main.dart에서 정의한 Theme의 색상 사용

#### InheritedWidget 생성

```dart
// common/widgets/video_config/video_config.dart

class VideoConfig extends InheritedWidget {
  const VideoConfig({super.key, required super.child});

  final bool autoMute = false;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
  // 데이터가 변경됐을 때 이 위젯을 상속받는 위젯을 rebuild할지 여부를 결정
    return true;
  }
}
```

#### InheritedWidget 설정

```dart
// main.dart
@override
  Widget build(BuildContext context) {
    // MaterialApp을 VideoConfig 위젯으로 감싸준다.
    return VideoConfig(
      child: MaterialApp.router(
```

#### of 생성자 만들기

- BuildContext에서 VideonConfig 타입의 InheritedWidget을 찾아서 반환
- 위젯트리에서 해당 위젯을 찾을 수 있을지 확신할 수 없기 때문에 null-safety를 위해 뒤에 느낌표 붙임

```dart
// video_config.dart
  static VideoConfig of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<VideoConfig>()!;
  }
```

#### 하위 위젯에서 사용하기

```dart
VideoConfig.of(context).autoMute
```

</br>

### 20.7 InheritedWidget part Two

#### InheritedWidget 문제점

- 데이터를 업데이트 할 수 없음

#### InheritedWidget과 StatefulWidget 합치기

- InheritedWidget을 반환하는 StatefulWidget을 생성하여 데이터와 데이터 변경 메소드를 만들고, InheritedWidget에게 전달

- 데이터가 변경되면 InheritedWidget이 rebuild되고, InheritedWidget을 상속받는 위젯도 새로운 데이터로 rebuild됨

- 데이터는 StatefulWidget에서 관리하고, InheritedWidget은 데이터와 데이터 수정방법을 공유하는 역할만 한다.

```dart
class VideoConfigData extends InheritedWidget {
  final bool autoMute;

  final void Function() toggleMuted;

  const VideoConfigData({
    super.key,
    required this.toggleMuted,
    required this.autoMute,
    required super.child,
  });

  static VideoConfigData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<VideoConfigData>()!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}

class VideoConfig extends StatefulWidget {
  final Widget child;

  const VideoConfig({
    super.key,
    required this.child,
  });

  @override
  State<VideoConfig> createState() => _VideoConfigState();
}

class _VideoConfigState extends State<VideoConfig> {
  bool autoMute = false;

  void toggleMuted() {
    setState(() {
      autoMute = !autoMute;
    });
  }

  @override
  Widget build(BuildContext context) {
    return VideoConfigData(
      toggleMuted: toggleMuted,
      autoMute: autoMute,
      child: widget.child,
    );
  }
}
```

#### 하위 위젯에서 사용

```dart
IconButton(
    icon: FaIcon(
      VideoConfigData.of(context).autoMute
        ? FontAwesomeIcons.volumeOff
        : FontAwesomeIcons.volumeHigh,
      color: Colors.white,
    ),
    onPressed: VideoConfigData.of(context).toggleMuted,
),
```

</br>

### 20.9 ChangeNotifier

#### ChangeNotifier 생성

- ChangeNotifier 안에 데이터와 데이터 변경 함수를 작성
- notifyListeners를 사용하여 데이터가 변경되었음을 알림

```dart
class VideoConfig extends ChangeNotifier {
  bool autoMute = false;

  void toggleAutoMute() {
    autoMute = !autoMute;
    notifyListeners();
  }
}

final videoConfig = VideoConfig();
```

#### AnimtaedBuilder 사용하여 데이터 변경 감지

- AnimatedBuilder를 사용하면 데이터 변경을 감지하여 변경된 부분만 rebuild 해줌

```dart
// settings_screen.dart
ListView(
        children: [
          AnimatedBuilder(
            animation: videoConfig,
            builder: (context, child) => SwitchListTile.adaptive(
              value: videoConfig.autoMute,
              onChanged: (value) {
                videoConfig.toggleAutoMute();
              },
              title: const Text("Mute video"),
              subtitle: const Text("Videos will be muted by default."),
            ),
          ),
```

#### addListener 사용하여 데이터 변경 감지

- initState에서 VideonConfig의 addListener 등록

```dart
// video_post.dart
import 'package:tiktok_clone/common/widgets/video_config/video_config.dart';

bool _autoMute = videoConfig.autoMute;

  @override
  void initState() {
    super.initState();
    videoConfig.addListener(() {
      setState(() {
        _autoMute = videoConfig.value;
      });
    });
  }

// 버튼 클릭 시 값 토글
onPressed: videoConfig.toggleAutoMute,
```

</br>

### 20.10 ValueNotifier

- 값이 하나일 때 사용

#### ValueNotifier 생성

```dart
// video_config.dart
final videoConfig = ValueNotifier(false);
```

#### addListener 사용하여 데이터 변경 감지

```dart
// video_post.dart
import 'package:tiktok_clone/common/widgets/video_config/video_config.dart';

bool _autoMute = videoConfig.value;

  @override
  void initState() {
    super.initState();
    videoConfig.addListener(() {
      setState(() {
        _autoMute = videoConfig.value;
      });
    });
  }

// 버튼 클릭 시 값 변경
 onPressed: () {
    videoConfig.value = !videoConfig.value;
},
```

#### builder 사용하여 데이터 변경 감지

```dart
// settings_screen.dart

ListView(
        children: [
          ValueListenableBuilder(
            valueListenable: videoConfig,
            builder: (context, value, child) => SwitchListTile.adaptive(
              value: value,
              onChanged: (value) {
                videoConfig.value = !videoConfig.value;
              },
              title: const Text("Mute video"),
              subtitle: const Text("Videos will be muted by default."),
            ),
          ),
```

</br>

### 20.11 Provider

#### 패키지 설치

```dart
// pubspec.yaml의 dependencies
provider: 6.0.5
```

#### 앱을 provider로 감싸기

- provider가 1개일 때는 직접 해당 provider로 감싸고
- provider가 여러개일 때는 MultiProvider로 감싸고, providers 리스트 설정

```dart
// main.dart
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => VideoConfig(),
        )
      ],
      child: MaterialApp.router(

// video_config.dart
class VideoConfig extends ChangeNotifier {
  bool isMuted = false;
  bool isAutoplay = false;

  void toggleIsMuted() {
    isMuted = !isMuted;
    notifyListeners();
  }

  void toggleAutoplay() {
    isAutoplay = !isAutoplay;
    notifyListeners();
  }
}
```

#### 하위 위젯에서 데이터 접근

```dart
// watch로 변경된 위젯을 rebuild
context.watch<VideoConfig>().isMuted

// read로 데이터 변경 메소드에 접근
context.read<VideoConfig>().toggleIsMuted()
```
