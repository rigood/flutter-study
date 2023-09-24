import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:threads/constants/gaps.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:threads/screens/camera_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:threads/view_models/upload_post_vm.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:threads/view_models/users_vm.dart';

class WriteScreen extends ConsumerStatefulWidget {
  const WriteScreen({super.key});

  @override
  ConsumerState<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends ConsumerState<WriteScreen> {
  String _text = "";
  String _imgPath = "";

  final TextEditingController _threadTextEditingController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    _threadTextEditingController.addListener(() {
      setState(() {
        _text = _threadTextEditingController.text;
      });
    });
  }

  @override
  void dispose() {
    _threadTextEditingController.dispose();
    super.dispose();
  }

  void _hideKeyboard() {
    FocusScope.of(context).unfocus();
  }

  void _onCancelPressed() {
    context.pop();
  }

  Future<void> _onAttachmentTap() async {
    final data = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const CameraScreen(),
      ),
    );

    if (data["shouldOpenImagePicker"]) {
      final picture = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 40,
      );

      if (picture == null) return;

      _imgPath = picture.path;
    } else {
      _imgPath = data["imgPath"];
    }

    setState(() {});
  }

  void _removeImage() {
    setState(() {
      _imgPath = "";
    });
  }

  void _uploadPost() {
    ref.read(uploadPostProvider.notifier).uploadPost(
          _text,
          File(_imgPath),
          context,
        );

    context.pushReplacement("/");
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: GestureDetector(
            onTap: _onCancelPressed,
            child: const Align(
              alignment: Alignment.center,
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          leadingWidth: 80,
          centerTitle: true,
          title: const Text(
            "New Thread",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          shape: Border(
            bottom: BorderSide(
              color: Colors.grey.shade300,
              width: 1,
            ),
          ),
        ),
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: _hideKeyboard,
          child: Stack(
            children: [
              const Row(
                children: [
                  Column(
                    children: [],
                  )
                ],
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 15,
                    left: 15,
                    right: 15,
                    bottom: 48,
                  ),
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        const Column(
                          children: [
                            CircleAvatar(
                              radius: 17,
                              backgroundColor: Colors.grey,
                              child: CircleAvatar(
                                radius: 16,
                                backgroundImage:
                                    AssetImage("assets/images/cocomong.jpg"),
                              ),
                            ),
                            Gaps.v5,
                            Expanded(
                              child: VerticalDivider(
                                color: Colors.grey,
                              ),
                            ),
                            Gaps.v5,
                            Opacity(
                              opacity: 0.3,
                              child: CircleAvatar(
                                radius: 9,
                                backgroundColor: Colors.grey,
                                child: CircleAvatar(
                                  radius: 8,
                                  backgroundImage:
                                      AssetImage("assets/images/cocomong.jpg"),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Gaps.h10,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ref.read(usersProvider).value?.name ??
                                    "Anonmyous",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              TextField(
                                minLines: null,
                                maxLines: null,
                                controller: _threadTextEditingController,
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                                decoration: const InputDecoration(
                                  hintText: "Start a thread...",
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                ),
                              ),
                              if (_imgPath != "")
                                Stack(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 200,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey.shade300,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                        image: DecorationImage(
                                          image: FileImage(
                                            File(_imgPath),
                                          ),
                                          fit: BoxFit.cover,
                                          alignment: Alignment.center,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 5,
                                      right: 5,
                                      child: IconButton(
                                        onPressed: _removeImage,
                                        icon: FaIcon(
                                          FontAwesomeIcons.solidCircleXmark,
                                          color: Colors.black.withOpacity(0.5),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              if (_imgPath != "") Gaps.v10,
                              IconButton(
                                onPressed: _onAttachmentTap,
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                icon: const FaIcon(
                                  FontAwesomeIcons.paperclip,
                                  color: Colors.grey,
                                  size: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                width: size.width,
                child: BottomAppBar(
                    elevation: 0,
                    color: Colors.white,
                    child: Row(
                      children: [
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              "Anyone can reply",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: _uploadPost,
                          child: AnimatedOpacity(
                            opacity: _text.isEmpty ? 0.5 : 1,
                            duration: const Duration(milliseconds: 300),
                            child: const Text(
                              "Post",
                              style: TextStyle(
                                color: Color(0xff1D6EEA),
                                fontSize: 16,
                              ),
                            ),
                          ),
                        )
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
