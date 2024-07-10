import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'SutOlcumController.dart';

class FilterableSutTabBar extends StatefulWidget {
  final TabController tabController;

  const FilterableSutTabBar({Key? key, required this.tabController}) : super(key: key);

  @override
  _FilterableSutTabBarState createState() => _FilterableSutTabBarState();
}

class _FilterableSutTabBarState extends State<FilterableSutTabBar> {
  bool isFilterVisible = false;
  final SutOlcumController controller = Get.find();

  void toggleFilterVisibility() {
    setState(() {
      isFilterVisible = !isFilterVisible;
    });
  }

  void _onTabChanged() {
    String tableName = '';
    switch (widget.tabController.index) {
      case 0:
        tableName = 'sutOlcumInekTable';
        break;
      case 1:
        tableName = 'sutOlcumKoyunTable';
        break;
    }
    controller.fetchSutOlcum(tableName);
  }

  @override
  void initState() {
    super.initState();
    widget.tabController.addListener(_onTabChanged);
  }

  @override
  void dispose() {
    widget.tabController.removeListener(_onTabChanged);
    super.dispose();
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
                Tab(text: 'İnek Süt Ölçüm'),
                Tab(text: 'Koyun Süt Ölçüm'),
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
