import 'package:animation/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:animation/data/chart_titles.dart';

class MovieRadarChart extends StatelessWidget {
  final bool isAnimating;
  final Map<String, dynamic> data;
  final List<String> categories;

  const MovieRadarChart({
    super.key,
    required this.isAnimating,
    required this.data,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: RadarChart(
        RadarChartData(
          radarShape: RadarShape.polygon,
          radarBorderData: BorderSide(
            color: Colors.grey.withOpacity(0.3),
          ),
          getTitle: (index, _) {
            return RadarChartTitle(
              text: chartTitles[index],
              angle: 0,
            );
          },
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
          titlePositionPercentageOffset: 0.25,
          tickCount: 2,
          ticksTextStyle: const TextStyle(
            color: Colors.transparent,
          ),
          tickBorderData: BorderSide(
            color: Colors.grey.withOpacity(0.3),
          ),
          gridBorderData: BorderSide(
            color: Colors.grey.withOpacity(0.3),
          ),
          dataSets: [
            // 실제 데이터
            RadarDataSet(
              fillColor: ColorThemes.primary1.withOpacity(0.3),
              borderColor: ColorThemes.primary1,
              dataEntries: [
                for (var category in categories)
                  RadarEntry(
                    value: isAnimating ? data[category]! as double : 0,
                  ),
              ],
            ),
            // 최대값 설정을 위한 가짜 데이터
            RadarDataSet(
              fillColor: Colors.transparent,
              borderColor: Colors.transparent,
              dataEntries: [
                for (int i = 0; i < 5; i++) const RadarEntry(value: 1)
              ],
            ),
          ],
        ),
        swapAnimationCurve: Curves.linear,
        swapAnimationDuration: const Duration(seconds: 1),
      ),
    );
  }
}
