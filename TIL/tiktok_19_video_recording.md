## 틱톡클론 강의 내용 정리 (#19 video recording)

### 19.0 Introduction

#### 이번 섹션에서 배울 내용

- 비디오 녹화, 사진 촬영
- 전면/후면 카메라 전환, 플래시 모드 변경, 카메라 줌(확대/축소)
- 녹화한 비디오를 휴대폰에 저장하기, 휴대폰 저장소에서 비디오 파일 가져오기
- 권한 허용 요청하기(마이크, 카메라, 저장소 등)
- 애니메이션 효과

#### 준비사항

- iOS 사용자
  - iOS 시뮬레이터에는 카메라 시뮬레이터가 없음
  - 안드로이드 스튜디오 설치하거나, 컴퓨터와 휴대폰 직접 연결하여 테스트
- Android 사용자
  - 휴대폰에서 개발자 옵션 활성화 -> USB 디버깅 켜기 -> 컴퓨터와 휴대폰 연결하여 테스트

</br>

### 19.1 Installation

#### 파일 생성

- features > videos > video_recording_screen.dart 파일 생성 > StatefulWidget으로 VideoRecordingScreen 클래스 생성

#### 카메라 패키지 설치

```dart
flutter pub add camera
```

#### Android 설정

```dart
// android > app > build.gradle 파일 > defaultConfig 항목

// 코드 삭제
minSdkVersion flutter.minSdkVersion

// 코드 추가
minSdkVersion 21
```

#### 권한 설정 관련 패키지 설치

```dart
flutter pub add permission_handler

또는

// pubspec.yaml 파일
permission_handler: ^10.2.0
```

</br>

### 19.2 CameraController

- 앱이 실행되면 사용자에게 카메라, 마이크 권한 요청하기
  - initState 메소드에서 initPermission 함수 실행
  - permission_handler 패키지를 이용하여 카메라, 마이크 권한 요청
  - 권한허용여부를 나타내는 \_hasPermission 변수 생성
  - isDenied, isPermanentlyDenied가 아니면 \_hasPermission을 true로 변경
  - 권한 허용되면 initCamera 함수 실행
- 권한 허용되면 카메라 설정하기
  - camera 패키지를 이용하여 카메라 기기 목록 받아오기
  - 사용 가능한 카메라가 없으면 return
  - 카메라 기기를 지정하여 \_camerController 설정하고 초기화
- 카메라 미리보기 화면
  - 권한이 없거나 카메라 초기화되기 전까지는 로딩 화면 띄우기
  - 카메라 셋팅되면 카메라 미리보기 화면 띄우기

</br>

### 19.3 Selfie Mode

- 셀카모드 여부를 나타내는 변수 생성

```dart
bool _isSelfieMode = false;
```

- 셀카모드이면 전면카메라, 셀카모드가 아니면 후면카메라 설정

```dart
    _cameraController = CameraController(
      cameras[_isSelfieMode ? 1 : 0],
      ResolutionPreset.ultraHigh,
    );
```

- 카메라 전환하는 함수 만들고, 화면 상단에 카메라 전환 아이콘 배치하기

```dart
  Future<void> _toggleSelfieMode() async {
    _isSelfieMode = !_isSelfieMode;
    await initCamera();
    setState(() {});
  }

Stack(
  children: [
    CameraPreview(_cameraController),
    Positioned(
      top: 30,
      right: 30,
      child: IconButton(
        onPressed: _toggleSelfieMode,
        icon: const FaIcon(
          FontAwesomeIcons.cameraRotate,
          color: Colors.white,
        ),
      ),
    ),
  ],
),
```

</br>

### 19.4 Flash Mode

- 플래시모드를 저장하는 변수를 생성하고, 카메라가 초기화되면 플래시모드 기본값을 저장

```dart
late FlashMode _flashMode;

Future<void> initCamera() async {
  ...

  await _cameraController.initialize();
  _flashMode = _cameraController.value.flashMode;
}
```

- 플래시모드를 설정하는 함수 만들고, 화면 상단에 아이콘 배치

```dart
 Future<void> _setFlashMode(FlashMode newFlashMode) async {
    await _cameraController.setFlashMode(newFlashMode);
    _flashMode = newFlashMode;
    setState(() {});
  }
```

</br>

### 19.5 Recording Animation

#### with 키워드로 Ticker 제공

```dart
// 단일 애니메이션 -> SingleTickerProviderStateMixin 사용
// 여러개 애니메이션 -> TickerProviderStateMixin 사용
class _VideoRecordingScreenState extends State<VideoRecordingScreen>
    with TickerProviderStateMixin {
}
```

#### 빨간색 녹화버튼의 크키가 커지는 애니메이션

```dart
  late final AnimationController _recordingButtonAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(
      milliseconds: 300,
    ),
  );

  late final Animation<double> _recordingButtonAnimation = Tween(
    begin: 1.0,
    end: 1.3,
  ).animate(_recordingButtonAnimationController);
```

#### 10초 동안 로딩바가 채워지는 애니메이션

```dart
 late final AnimationController _progressnAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(
      seconds: 10,
    ),
    lowerBound: 0.0,
    upperBound: 1.0,
  );

  @override
  void initState() {
    super.initState();
    initPermission();
    _progressnAnimationController.addListener(() {
      setState(() {});
    });
    _progressnAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _stopRecording();
      }
    });
  }
```

#### 애니메이션 시작, 종료 설정

```dart
  void _startRecording(TapUpDetails _) {
    _recordingButtonAnimationController.forward();
    _progressnAnimationController.forward();
  }

  void _stopRecording() {
    _recordingButtonAnimationController.reverse();
    _progressnAnimationController.reset();
  }

    Positioned(
                    bottom: 40,
                    child: GestureDetector(
                      onTapUp: _startRecording,
                      onTapDown: (tapDownDetails) => _stopRecording(),
                      child: ScaleTransition(
                        scale: _recordingButtonAnimation,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: 95,
                              height: 95,
                              child: CircularProgressIndicator(
                                color: Colors.red,
                                strokeWidth: 6,
                                value: _progressnAnimationController.value,
                              ),
                            ),
                            Container(
                              width: 80,
                              height: 80,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
```
