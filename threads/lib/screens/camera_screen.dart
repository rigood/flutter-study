import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:threads/constants/gaps.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver {
  late CameraController _cameraController;

  bool _appActivated = true;
  bool _hasPermissions = false;
  List<String> _deniedPermissions = [];
  bool _isSelfieMode = false;
  bool _isFlashOn = false;
  bool _isSavingPicture = false;

  void _onBackButtonTap() {
    Navigator.of(context).pop({
      "imgPath": "",
      "shouldOpenImagePicker": false,
    });
  }

  void _onGalleryTap() {
    Navigator.of(context).pop({
      "imgPath": "",
      "shouldOpenImagePicker": true,
    });
  }

  Future<void> _takePicture() async {
    setState(() {
      _isSavingPicture = true;
    });

    final picture = await _cameraController.takePicture();

    if (!mounted) return;

    Navigator.of(context).pop({
      "imgPath": picture.path,
      "shouldOpenImagePicker": false,
    });
  }

  Future<void> _toggleSelfieMode() async {
    _isSelfieMode = !_isSelfieMode;
    await _initCamera();
    setState(() {});
  }

  Future<void> _toggleFlash() async {
    _isFlashOn = !_isFlashOn;
    await _cameraController.setFlashMode(
      _isFlashOn ? FlashMode.always : FlashMode.off,
    );
    setState(() {});
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();

    if (cameras.isEmpty || cameras.length < 2) return;

    _cameraController = CameraController(
      cameras[_isSelfieMode ? 1 : 0],
      ResolutionPreset.ultraHigh,
    );

    await _cameraController.initialize();

    setState(() {});
  }

  Future<void> _initPermissions() async {
    final cameraPermission = await Permission.camera.request();
    final micPermission = await Permission.microphone.request();

    final cameraDenied =
        cameraPermission.isDenied || cameraPermission.isPermanentlyDenied;
    final micDenied =
        micPermission.isDenied || micPermission.isPermanentlyDenied;

    if (!cameraDenied && !micDenied) {
      _hasPermissions = true;
      await _initCamera();
    } else {
      _hasPermissions = false;
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
    _initPermissions();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    if (_cameraController.value.isInitialized) {
      _cameraController.dispose();
    }
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (!_cameraController.value.isInitialized) return;

    switch (state) {
      case AppLifecycleState.resumed:
        _appActivated = true;
        await _initPermissions();
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        _appActivated = false;
        setState(() {});
        _cameraController.dispose();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        leading: IconButton(
          onPressed: _onBackButtonTap,
          icon: const FaIcon(
            FontAwesomeIcons.chevronLeft,
            size: 18,
          ),
        ),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: _isSavingPicture ||
                !_appActivated ||
                !_hasPermissions ||
                !_cameraController.value.isInitialized
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_isSavingPicture ||
                        !_appActivated ||
                        !_cameraController.value.isInitialized)
                      const CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    Gaps.v40,
                    Text(
                      _isSavingPicture
                          ? "사진 저장중"
                          : !_hasPermissions
                              ? "${_deniedPermissions.join(", ")}에 대한\n 권한을 허용해주세요."
                              : !_cameraController.value.isInitialized
                                  ? "카메라 실행중"
                                  : "로딩중",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
              )
            : Stack(
                alignment: Alignment.center,
                children: [
                  CameraPreview(_cameraController),
                  Positioned(
                    bottom: 130,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: IconButton(
                              onPressed: _toggleFlash,
                              icon: Icon(
                                _isFlashOn ? Icons.flash_auto : Icons.flash_off,
                                color:
                                    _isFlashOn ? Colors.yellow : Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: _takePicture,
                            child: SizedBox(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  const SizedBox(
                                    width: 85,
                                    height: 85,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 3,
                                      value: 1,
                                    ),
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    width: 70,
                                    height: 70,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: IconButton(
                              onPressed: _toggleSelfieMode,
                              icon: const Icon(
                                Icons.cameraswitch_sharp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Expanded(
                          child: Spacer(),
                        ),
                        const Expanded(
                          child: Text(
                            "Camera",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: _onGalleryTap,
                              child: const Text(
                                "Gallery",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
