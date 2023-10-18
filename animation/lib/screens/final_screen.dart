import 'package:flutter/material.dart';
import 'package:animation/constants/gaps.dart';
import 'package:animation/data/movies.dart';
import 'package:animation/widgets/custom_app_bar.dart';
import 'package:animation/widgets/poster_blur_background.dart';
import 'package:animation/widgets/movie_egg_image.dart';
import 'package:animation/widgets/custom_vertical_divider.dart';
import 'package:animation/widgets/movie_detail_screen/movie_detail_title.dart';
import 'package:animation/widgets/movie_detail_screen/movie_radar_chart.dart';
import 'package:animation/widgets/movie_detail_screen/movie_animating_golden_egg.dart';
import 'package:animation/widgets/movie_detail_screen/movie_animating_reservation_rate.dart';
import 'package:animation/widgets/movie_detail_screen/movie_detail_summary.dart';
import 'package:animation/widgets/movie_detail_screen/movie_youtube_thumbnail.dart';
import 'package:animation/widgets/movie_screen/movie_title.dart';
import 'package:animation/widgets/movie_screen/movie_summary.dart';
import 'package:animation/widgets/movie_screen/movie_golden_egg.dart';
import 'package:animation/widgets/movie_screen/movie_reservation_button.dart';
import 'package:animation/widgets/movie_screen/movie_reservation_rate.dart';
import 'package:animation/widgets/movie_screen/movie_poster.dart';
import 'package:animation/widgets/movie_screen/movie_heart.dart';
import 'package:animation/widgets/movie_screen/movie_rating.dart';
import 'package:animation/widgets/movie_screen/movie_rank.dart';
import 'package:animation/widgets/movie_screen/movie_like_button.dart';

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

  void _onHorizontalPageChanged(int newPage) {
    setState(() {
      _currentHorizontalPage = newPage;
    });
  }

  void _toggleIsLiked(int index) {
    setState(() {
      _isLikedList[index] = !_isLikedList[index];
    });
  }

  void _onPosterDoubleTap(int index) {
    setState(() {
      _isHeartAnimatingList[index] = true;
      _isLikedList[index] = true;
    });
  }

  void _onHeartAnimationEnd(int index) {
    setState(() {
      _isHeartAnimatingList[index] = false;
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
                      MovieDetailTitle(
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
                          MovieAnimatingGoldenEgg(
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
                          MovieAnimatingReservationRate(
                            isAnimating: _isDetailScreenAnimating,
                            reservationRate: movies[_currentHorizontalPage]
                                ["reservationRate"] as double,
                          ),
                        ],
                      ),
                      Gaps.v32,
                      MovieDetailSummary(
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
                                              MovieTitle(
                                                title:
                                                    "${movies[index]["title"]}",
                                              ),
                                              Gaps.v12,
                                              MovieSummary(
                                                summary:
                                                    "${movies[index]["summary"]}",
                                              ),
                                              Gaps.v16,
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  MovieEggImage(
                                                    eggImagePath: movies[index]
                                                            ["eggImagePath"]!
                                                        as String,
                                                    size: 16,
                                                  ),
                                                  Gaps.h4,
                                                  MovieGoldenEgg(
                                                    goldenEgg: movies[index]
                                                        ["goldenEgg"]! as int,
                                                  ),
                                                  Gaps.h5,
                                                  const CustomVerticalDivider(
                                                    height: 12,
                                                  ),
                                                  Gaps.h5,
                                                  MovieReservationRate(
                                                      reservationRate: movies[
                                                                  index][
                                                              "reservationRate"]!
                                                          as double),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        const MovieReservationButton(),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 30 + (1 - verticalScroll) * 113,
                                  child: Transform.scale(
                                    scale: 1 - (difference * 0.3),
                                    child: GestureDetector(
                                      onDoubleTap: () =>
                                          _onPosterDoubleTap(index),
                                      child: Stack(
                                        children: [
                                          MoviePoster(
                                            posterPath:
                                                "assets/covers/${index + 1}.jpg",
                                          ),
                                          MovieHeart(
                                            isAnimating:
                                                _isHeartAnimatingList[index],
                                            onEnd: () =>
                                                _onHeartAnimationEnd(index),
                                          ),
                                          MovieRating(
                                            color: movies[index]["ratingColor"]!
                                                as Color,
                                            rating: movies[index]["rating"]!
                                                as String,
                                          ),
                                          MovieRank(
                                            rank: movies[index]["rank"]! as int,
                                          ),
                                          MovieLikeButton(
                                            isLiked: _isLikedList[index],
                                            onTap: () => _toggleIsLiked(index),
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
