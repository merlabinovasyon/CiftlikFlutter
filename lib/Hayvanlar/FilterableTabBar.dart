import 'package:flutter/material.dart';

class FilterableTabBar extends StatefulWidget {
  final TabController tabController;

  const FilterableTabBar({Key? key, required this.tabController}) : super(key: key);

  @override
  _FilterableTabBarState createState() => _FilterableTabBarState();
}

class _FilterableTabBarState extends State<FilterableTabBar> {
  bool isFilterVisible = false;

  void toggleFilterVisibility() {
    setState(() {
      isFilterVisible = !isFilterVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.filter_list),
          onPressed: toggleFilterVisibility,
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          width: isFilterVisible ? 310 : 0,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: TabBar(
              controller: widget.tabController,
              isScrollable: true,
              tabs: [
                Tab(text: 'Kuzu'),
                Tab(text: 'Buzağı'),
                Tab(text: 'Koyun'),
                Tab(text: 'Koç'),
                Tab(text: 'İnek'),
                Tab(text: 'Boğa'),
                Tab(text: 'Sütten Kesilmiş Kuzu'),
                Tab(text: 'Sütten Kesilmiş Buzağı'),
              ],
              labelColor: Colors.black,
              unselectedLabelColor: Colors.black54,
              indicatorColor: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
