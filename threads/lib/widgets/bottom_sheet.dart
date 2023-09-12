import 'package:flutter/material.dart';
import 'package:threads/constants/gaps.dart';
import 'package:threads/widgets/report_bottom_sheet.dart';
import 'package:go_router/go_router.dart';

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({super.key});

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  void _onReportTap() {
    context.pop();
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return ReportBottomSheet();
      },
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.32,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 24,
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BottomSheetItem(
                text: "Unfollow",
                hasBorderBottom: true,
                borderBottomArea: BorderBottomAreaType.top,
                onTap: () {},
              ),
              BottomSheetItem(
                text: "Mute",
                hasBorderBottom: false,
                borderBottomArea: BorderBottomAreaType.bottom,
                onTap: () {},
              ),
              Gaps.v20,
              BottomSheetItem(
                text: "Hide",
                hasBorderBottom: true,
                borderBottomArea: BorderBottomAreaType.top,
                onTap: () {},
              ),
              BottomSheetItem(
                text: "Report",
                hasBorderBottom: false,
                textColor: Colors.red,
                borderBottomArea: BorderBottomAreaType.bottom,
                onTap: _onReportTap,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum BorderBottomAreaType { top, bottom, none }

class BottomSheetItem extends StatelessWidget {
  const BottomSheetItem({
    super.key,
    required this.text,
    this.textColor = Colors.black,
    required this.hasBorderBottom,
    required this.borderBottomArea,
    required this.onTap,
  });

  final String text;
  final bool hasBorderBottom;
  final Color? textColor;
  final BorderBottomAreaType borderBottomArea;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: ClipRRect(
        borderRadius: borderBottomArea == BorderBottomAreaType.top
            ? const BorderRadius.vertical(
                top: Radius.circular(10),
              )
            : borderBottomArea == BorderBottomAreaType.bottom
                ? const BorderRadius.vertical(
                    bottom: Radius.circular(10),
                  )
                : BorderRadius.zero,
        child: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xffF2F2F2),
            border: hasBorderBottom
                ? const Border(
                    bottom: BorderSide(
                      color: Color(0xffE8E6E7),
                    ),
                  )
                : null,
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
