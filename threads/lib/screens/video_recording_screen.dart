import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:threads/constants/gaps.dart';
import 'package:threads/screens/video_preveiw_screen.dart';

class VideoRecordingScreen extends StatefulWidget {
  const VideoRecordingScreen({super.key});

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  bool _hasPermission = false;
  List<String> _deniedPermissions = [];

  late CameraController _cameraController;

  bool _isSelfieMode = false;
  late FlashMode _flashMode;

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

  late final AnimationController _progressnAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(
      seconds: 10,
    ),
    lowerBound: 0.0,
    upperBound: 1.0,
  );

  Future<void> _setFlashMode(FlashMode newFlashMode) async {
    await _cameraController.setFlashMode(newFlashMode);
    _flashMode = newFlashMode;
    setState(() {});
  }

  Future<void> _toggleSelfieMode() async {
    _isSelfieMode = !_isSelfieMode;
    await initCamera();
    setState(() {});
  }

  Future<void> initCamera() async {
    final cameras = await availableCameras();

    if (cameras.isEmpty || cameras.length < 2) return;

    _cameraController = CameraController(
      cameras[_isSelfieMode ? 1 : 0],
      ResolutionPreset.ultraHigh,
    );

    await _cameraController.initialize();
    await _cameraController.prepareForVideoRecording();

    _flashMode = _cameraController.value.flashMode;

    setState(() {});
  }

  Future<void> initPermission() async {
    final cameraPermission = await Permission.camera.request();
    final micPermission = await Permission.microphone.request();

    final cameraDenied =
        cameraPermission.isDenied || cameraPermission.isPermanentlyDenied;
    final micDenied =
        micPermission.isDenied || micPermission.isPermanentlyDenied;

    if (!cameraDenied && !micDenied) {
      _hasPermission = true;
      await initCamera();
    } else {
      _deniedPermissions = [
        if (cameraDenied) "카메라",
        if (micDenied) "마이크",
      ];
    }
    setState(() {});
  }

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
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _progressnAnimationController.dispose();
    _recordingButtonAnimationController.dispose();
    _cameraController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.detached:
        break;

      case AppLifecycleState.hidden:
        break;

      case AppLifecycleState.inactive:
        _cameraController.dispose();
        break;

      case AppLifecycleState.paused:
        break;

      case AppLifecycleState.resumed:
        // if (!_hasPermission || !_cameraController.value.isInitialized) return;
        break;

      default:
    }
  }

  Future<void> _startRecording(TapUpDetails _) async {
    if (_cameraController.value.isRecordingVideo) return;

    await _cameraController.startVideoRecording();

    _recordingButtonAnimationController.forward();
    _progressnAnimationController.forward();
  }

  Future<void> _stopRecording() async {
    if (!_cameraController.value.isRecordingVideo) return;

    _recordingButtonAnimationController.reverse();
    _progressnAnimationController.reset();

    final video = await _cameraController.stopVideoRecording();

    if (!mounted) return;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(
          video: video,
          isPicked: false,
        ),
      ),
    );
  }

  Future<void> _onPickVideoPressed() async {
    final video = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );

    if (video == null) return;

    if (!mounted) return;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(
          video: video,
          isPicked: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: !_hasPermission || !_cameraController.value.isInitialized
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _deniedPermissions.isNotEmpty
                    ? [
                        Text(
                          "${_deniedPermissions.join(", ")}에 대한\n 권한을 허용해주세요.",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            height: 1.3,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Gaps.v40,
                        TextButton(
                          onPressed: () {
                            openAppSettings();
                          },
                          child: const Text(
                            "권한 설정",
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                        )
                      ]
                    : [
                        const CircularProgressIndicator.adaptive(),
                        Gaps.v40,
                        const Text(
                          "설정중",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
              )
            : Stack(
                alignment: Alignment.center,
                children: [
                  CameraPreview(_cameraController),
                  Positioned(
                    top: 30,
                    right: 15,
                    child: Column(
                      children: [
                        CameraButton(
                          onPressed: _toggleSelfieMode,
                          icon: FontAwesomeIcons.cameraRotate,
                        ),
                        CameraButton(
                          onPressed: () => _setFlashMode(FlashMode.off),
                          icon: Icons.flash_off_rounded,
                          isSelected: _flashMode == FlashMode.off,
                        ),
                        CameraButton(
                          onPressed: () => _setFlashMode(FlashMode.always),
                          icon: Icons.flash_on_rounded,
                          isSelected: _flashMode == FlashMode.always,
                        ),
                        CameraButton(
                          onPressed: () => _setFlashMode(FlashMode.auto),
                          icon: Icons.flash_auto_rounded,
                          isSelected: _flashMode == FlashMode.auto,
                        ),
                        CameraButton(
                          onPressed: () => _setFlashMode(FlashMode.torch),
                          icon: Icons.flashlight_on_rounded,
                          isSelected: _flashMode == FlashMode.torch,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    width: MediaQuery.of(context).size.width,
                    bottom: 40,
                    child: Row(
                      children: [
                        const Spacer(),
                        GestureDetector(
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
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: IconButton(
                              onPressed: _onPickVideoPressed,
                              icon: const FaIcon(
                                FontAwesomeIcons.image,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class CameraButton extends StatelessWidget {
  final dynamic onPressed;
  final IconData icon;
  final bool? isSelected;

  const CameraButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: FaIcon(
        icon,
        color: isSelected! ? Colors.yellow : Colors.white,
      ),
    );
  }
}
