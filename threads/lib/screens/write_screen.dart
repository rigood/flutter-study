import 'package:flutter/material.dart';
import 'package:threads/constants/gaps.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WriteScreen extends StatefulWidget {
  const WriteScreen({super.key});

  @override
  State<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> {
  String _thread = "";

  final TextEditingController _threadController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _threadController.addListener(() {
      setState(() {
        _thread = _threadController.text;
      });
    });
  }

  @override
  void dispose() {
    _threadController.dispose();
    super.dispose();
  }

  void _closeKeyboard() {
    FocusScope.of(context).unfocus();
  }

  void _onCancelPressed() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
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
        body: Stack(
          children: [
            GestureDetector(
              onTap: _closeKeyboard,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                  left: 15,
                  right: 15,
                  bottom: 70,
                ),
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
                        SizedBox(
                          height: 60,
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Jane_mobbin",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: TextField(
                            minLines: null,
                            maxLines: null,
                            controller: _threadController,
                            decoration: const InputDecoration(
                              hintText: "Start a thread...",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const FaIcon(
                          FontAwesomeIcons.paperclip,
                          color: Colors.grey,
                          size: 18,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              width: size.width,
              child: BottomAppBar(
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                    ),
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
                          onPressed: () {},
                          child: AnimatedOpacity(
                            opacity: _thread.isEmpty ? 0.5 : 1,
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
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
