import 'package:app_bar_with_search_switch/app_bar_with_search_switch.dart';
import 'package:flutter/material.dart';
import 'package:saur_stockist/screens/dealers/dealer_detail.dart';
import 'package:saur_stockist/utils/theme.dart';

import '../../utils/colors.dart';

class DealersScreen extends StatefulWidget {
  const DealersScreen({super.key});

  @override
  State<DealersScreen> createState() => _DealersScreenState();
}

class _DealersScreenState extends State<DealersScreen> {
  bool isListVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWithSearchSwitch(
        actionsIconTheme: const IconThemeData(color: primaryColor),
        keepAppBarColors: false,
        backgroundColor: Colors.white,
        animation: (child) => AppBarAnimationSlideLeft(
            milliseconds: 600, withFade: false, percents: 1.0, child: child),
        onChanged: (value) {},
        appBarBuilder: (context) => AppBar(
          title: InkWell(
            onTap: () => setState(() {
              isListVisible = !isListVisible;
            }),
            child: Text(
              'Dealers',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          actions: const [
            AppBarSearchButton(
              buttonHasTwoStates: false,
            )
          ],
        ),
      ),
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) => ListTile(
              leading: Image.asset(
                'assets/images/dummy_logo.jpg',
                width: 60,
              ),
              title: Text(
                'Dealer$index Name',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              subtitle: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '1$index Jun, 2023',
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    color: dividerColor,
                    width: 1,
                    height: 15,
                  ),
                  Text(
                    '2${index * 3} devices',
                  ),
                ],
              ),
              trailing: const Icon(
                Icons.chevron_right,
                color: hintColor,
              ),
              onTap: () => Navigator.pushNamed(context, DealerDetail.routePath),
            ),
        separatorBuilder: (context, index) => const Divider(
              color: dividerColor,
              indent: defaultPadding * 5,
            ),
        itemCount: 10);
  }
}
