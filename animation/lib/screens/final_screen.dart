import 'package:animation/widgets/custom_vertical_divider.dart';
import 'package:animation/widgets/movie_detail_screen/movie_egg_image.dart';
import 'package:animation/widgets/movie_detail_screen/movie_golden_egg.dart';
import 'package:animation/widgets/movie_detail_screen/movie_reservation_rate.dart';
import 'package:animation/widgets/movie_detail_screen/movie_summary.dart';
import 'package:animation/widgets/movie_detail_screen/movie_title.dart';
import 'package:animation/widgets/movie_detail_screen/movie_youtube_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:animation/constants/gaps.dart';
import 'package:animation/data/movies.dart';
import 'package:animation/widgets/custom_app_bar.dart';
import 'package:animation/widgets/poster_blur_background.dart';
import 'package:animation/widgets/heart_animation_widget.dart';
import 'package:animation/widgets/movie_detail_screen/movie_radar_chart.dart';

class FinalScreen extends StatefulWidget {
  const FinalScreen({super.key});

  @override
  State<FinalScreen> createState() => _FinalScreenState();
}

class _FinalScreenState extends State<FinalScreen> {
  int _currentVerticalPage = 1;
  int _currentHorizontalPage = 0;

  late PageController _verticalController;
  late PageController _horizontalController;

  final ValueNotifier<double> _verticalScroll = ValueNotifier(1.0);
  final ValueNotifier<double> _horizontalScroll = ValueNotifier(0.0);

  final List<bool> _isLikedList = List.filled(movies.length, false);
  final List<bool> _isHeartAnimatingList = List.filled(movies.length, false);

  bool _isDetailScreenAnimating = false;

  @override
  void initState() {
    super.initState();

    _verticalController = PageController(
      initialPage: 1,
      viewportFraction: 0.8,
    )..addListener(
        () {
          if (_verticalController.page == null) return;
          _verticalScroll.value = _verticalController.page!;
        },
      );

    _horizontalController = PageController(
      initialPage: _currentHorizontalPage,
      viewportFraction: 0.8,
    )..addListener(
        () {
          if (_horizontalController.page == null) return;
          _horizontalScroll.value = _horizontalController.page!;
        },
      );
  }

  @override
  void dispose() {
    _verticalController.dispose();
    _horizontalController.dispose();
    super.dispose();
  }

  void _scrollToDetailScreen() {
    _verticalController.animateToPage(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.linear,
    );
  }

  void _onVerticalPageChanged(newPage) {
    setState(() {
      _currentVerticalPage = newPage;
      _isDetailScreenAnimating = !_isDetailScreenAnimating;
    });
  }

  void _onHorizontalPageChanged(newPage) {
    setState(() {
      _currentHorizontalPage = newPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _currentVerticalPage == 1
          ? CustomAppBar(
              onUpIconTap: _scrollToDetailScreen,
            )
          : null,
      body: Stack(
        children: [
          AnimatedSwitcher(
            duration: const Duration(
              milliseconds: 500,
            ),
            child: PosterBlurBackground(
              index: _currentHorizontalPage,
            ),
          ),
          PageView(
            scrollDirection: Axis.vertical,
            controller: _verticalController,
            onPageChanged: _onVerticalPageChanged,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 5,
                  bottom: 80,
                  left: 30,
                  right: 30,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      MovieTitle(
                        title: "${movies[_currentHorizontalPage]["title"]}",
                      ),
                      Gaps.v40,
                      MovieRadarChart(
                        isAnimating: _isDetailScreenAnimating,
                        data: movies[_currentHorizontalPage],
                        categories: const [
                          "directing",
                          "actor",
                          "ost",
                          "aesthetic",
                          "story"
                        ],
                      ),
                      Gaps.v40,
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MovieEggImage(
                            eggImagePath: movies[_currentHorizontalPage]
                                ["eggImagePath"]! as String,
                          ),
                          Gaps.h4,
                          MovieGoldenEgg(
                            isAnimating: _isDetailScreenAnimating,
                            goldenEgg: movies[_currentHorizontalPage]
                                ["goldenEgg"] as int,
                          ),
                          Gaps.h5,
                          const CustomVerticalDivider(
                            color: Colors.grey,
                            height: 15,
                          ),
                          Gaps.h5,
                          MovieReservationRate(
                            isAnimating: _isDetailScreenAnimating,
                            reservationRate: movies[_currentHorizontalPage]
                                ["reservationRate"] as double,
                          ),
                        ],
                      ),
                      Gaps.v32,
                      MovieSummary(
                          summary:
                              "${movies[_currentHorizontalPage]["summary"]}"),
                      Gaps.v32,
                      MovieYoutubeThumbnail(
                        youtubeId:
                            "${movies[_currentHorizontalPage]["youtubeId"]}",
                      ),
                    ],
                  ),
                ),
              ),
              PageView.builder(
                scrollDirection: Axis.horizontal,
                controller: _horizontalController,
                onPageChanged: _onHorizontalPageChanged,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return ValueListenableBuilder(
                    valueListenable: _verticalScroll,
                    builder: (context, verticalScroll, child) {
                      return ValueListenableBuilder(
                        valueListenable: _horizontalScroll,
                        builder: (context, horizontalScroll, child) {
                          final difference = (horizontalScroll - index).abs();
                          final scale = 1 - (difference * 0.1);
                          return Transform.scale(
                            scale: scale,
                            child: Stack(
                              clipBehavior: Clip.none,
                              alignment: Alignment.bottomCenter,
                              children: [
                                Positioned(
                                  top: 143 - (1 - verticalScroll) * 113,
                                  child: Container(
                                    height: 430,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.7),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: 280,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 30,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const SizedBox(
                                                height: 210,
                                              ),
                                              Text(
                                                "${movies[index]["title"]}",
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontSize: 28,
                                                  fontFamily:
                                                      "PretendardSemibold",
                                                  fontWeight: FontWeight.w600,
                                                  height: 1.3,
                                                  letterSpacing: -1,
                                                ),
                                              ),
                                              Gaps.v12,
                                              Text(
                                                "${movies[index]["summary"]}",
                                                maxLines: 4,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Colors.grey.shade800,
                                                  fontSize: 11.5,
                                                  fontFamily: "PretendardLight",
                                                  letterSpacing: -0.2,
                                                  height: 1.5,
                                                ),
                                              ),
                                              Gaps.v16,
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    movies[index]
                                                            ["eggImagePath"]!
                                                        as String,
                                                    width: 16,
                                                    height: 16,
                                                  ),
                                                  Gaps.h4,
                                                  Text(
                                                    "${movies[index]["goldenEgg"]!}%",
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      fontFamily:
                                                          "PretendardMedium",
                                                      letterSpacing: -0.5,
                                                    ),
                                                  ),
                                                  Gaps.h5,
                                                  const Text("｜"),
                                                  Gaps.h5,
                                                  Text(
                                                    "예매율 ${movies[index]["reservationRate"]!}%",
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      fontFamily:
                                                          "PretendardMedium",
                                                      letterSpacing: -0.5,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          left: 0,
                                          right: 0,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 14,
                                            ),
                                            decoration: const BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                                colors: [
                                                  Color(0xffFB4657),
                                                  Color(0xffFF7156),
                                                ],
                                              ),
                                            ),
                                            child: const Text(
                                              "예매하기",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 30 + (1 - verticalScroll) * 113,
                                  child: Transform.scale(
                                    scale: 1 - (difference * 0.3),
                                    child: GestureDetector(
                                      onDoubleTap: () {
                                        setState(() {
                                          _isHeartAnimatingList[index] = true;
                                          _isLikedList[index] = true;
                                        });
                                      },
                                      child: Stack(
                                        children: [
                                          Container(
                                            clipBehavior: Clip.hardEdge,
                                            width: 200,
                                            height: 300,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/covers/${index + 1}.jpg"),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  begin: FractionalOffset
                                                      .topCenter,
                                                  end: FractionalOffset
                                                      .bottomCenter,
                                                  colors: [
                                                    Colors.black.withOpacity(0),
                                                    Colors.black
                                                        .withOpacity(0.8),
                                                  ],
                                                  stops: const [0.3, 1.0],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 0,
                                            bottom: 0,
                                            left: 0,
                                            right: 0,
                                            child: Opacity(
                                              opacity:
                                                  _isHeartAnimatingList[index]
                                                      ? 1
                                                      : 0,
                                              child: HeartAnimationWidget(
                                                isAnimationg:
                                                    _isHeartAnimatingList[
                                                        index],
                                                duration: const Duration(
                                                  milliseconds: 700,
                                                ),
                                                onEnd: () {
                                                  setState(() {
                                                    _isHeartAnimatingList[
                                                        index] = false;
                                                  });
                                                },
                                                child: const Icon(
                                                  Icons.favorite,
                                                  size: 80,
                                                  color: Color(0xffED3124),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: -16,
                                            left: 4,
                                            child: Text(
                                              "${movies[index]["rank"]}",
                                              style: TextStyle(
                                                color: Colors.white
                                                    .withOpacity(0.7),
                                                fontSize: 56,
                                                fontStyle: FontStyle.italic,
                                                fontFamily: "OA",
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 0,
                                            right: 0,
                                            child: HeartAnimationWidget(
                                              isAnimationg: _isLikedList[index],
                                              alwaysAnimate: true,
                                              child: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    _isLikedList[index] =
                                                        !_isLikedList[index];
                                                  });
                                                },
                                                icon: Icon(
                                                  _isLikedList[index]
                                                      ? Icons.favorite
                                                      : Icons.favorite_outline,
                                                  color: _isLikedList[index]
                                                      ? Colors.red
                                                      : Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 8,
                                            right: 8,
                                            child: Container(
                                              width: 24,
                                              height: 24,
                                              decoration: BoxDecoration(
                                                color: movies[index]
                                                    ["ratingColor"]! as Color,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "${movies[index]["rating"]}",
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w900,
                                                    fontFamily:
                                                        "PretendardSemibold",
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
