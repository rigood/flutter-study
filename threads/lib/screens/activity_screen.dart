import 'package:flutter/material.dart';
import 'package:threads/utils.dart';
import 'package:threads/mock.dart';
import 'package:threads/widgets/activity_item.dart';

class ActivityScreen extends StatefulWidget {
  static String routeName = "activity";

  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

final tabs = [
  "All",
  "Replies",
  "Mentions",
  "Verified",
  "Following",
];

class _ActivityScreenState extends State<ActivityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Activity",
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ],
        ),
      ),
      body: DefaultTabController(
        length: tabs.length,
        child: Column(
          children: [
            PreferredSize(
              preferredSize: const Size.fromHeight(100),
              child: SizedBox(
                height: 40,
                child: TabBar(
                  isScrollable: true,
                  padding: const EdgeInsets.only(left: 5),
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorWeight: 0,
                  indicatorColor: Colors.transparent,
                  indicator: BoxDecoration(
                    color: isDarkMode(context) ? Colors.white : Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelPadding: const EdgeInsets.symmetric(horizontal: 5),
                  labelColor: isDarkMode(context) ? Colors.black : Colors.white,
                  unselectedLabelColor:
                      isDarkMode(context) ? Colors.white : Colors.black,
                  tabs: [
                    for (var tab in tabs)
                      Tab(
                        child: Container(
                          width: 100,
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(child: Text(tab)),
                        ),
                      )
                  ],
                ),
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              child: TabBarView(
                children: [
                  ListView.builder(
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return ActivityItem(
                        userAvatar: mockData[index % 3]["userAvatar"],
                        userName: mockData[index % 3]["userName"],
                        icon: mockData[index % 3]["icon"],
                        iconBackgroundColor: mockData[index % 3]
                            ["iconBackgroundColor"],
                        hours: mockData[index % 3]["hours"],
                        activity: mockData[index % 3]["activity"],
                        activityMessage: mockData[index % 3]["activityMessage"],
                        activityDescription: mockData[index % 3]
                            ["activityDescription"],
                      );
                    },
                  ),
                  ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return ActivityItem(
                        userAvatar: mockData[1]["userAvatar"],
                        userName: mockData[1]["userName"],
                        icon: mockData[1]["icon"],
                        iconBackgroundColor: mockData[1]["iconBackgroundColor"],
                        hours: mockData[1]["hours"],
                        activity: mockData[1]["activity"],
                        activityMessage: mockData[1]["activityMessage"],
                        activityDescription: mockData[1]["activityDescription"],
                      );
                    },
                  ),
                  for (var tab in tabs.skip(2)) Center(child: Text(tab))
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
