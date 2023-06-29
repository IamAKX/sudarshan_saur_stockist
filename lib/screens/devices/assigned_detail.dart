import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/theme.dart';
import '../../widgets/gaps.dart';

class AssignedDetail extends StatefulWidget {
  static const String routePath = '/assignedDetail';

  const AssignedDetail({super.key});

  @override
  State<AssignedDetail> createState() => _AssignedDetailState();
}

class _AssignedDetailState extends State<AssignedDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: ListView(
        children: [
          dealerDetailCard(context),
          deviceDetailCard(
            context,
          )
        ],
      ),
    );
  }

  Card deviceDetailCard(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(defaultPadding),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Device Details',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            verticalGap(defaultPadding * 0.5),
            cardLargeDetail(
              context,
              'System info',
              '200 WUGL-A 58X2100-10 Guarantee*',
            ),
            cardLargeDetail(context, 'Serial No', '136283837'),
            cardLargeDetail(context, 'Brand', 'Saur Sudarshan'),
            cardLargeDetail(context, 'Model No', '58X2100'),
            cardLargeDetail(context, 'Capacity', '25L'),
            cardLargeDetail(context, 'Manufacture', '21 Feb, 2023'),
          ],
        ),
      ),
    );
  }

  Card dealerDetailCard(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(defaultPadding),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dealer Details',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            verticalGap(defaultPadding * 0.5),
            cardLargeDetail(context, 'Dealer', 'Dealer Full Name'),
            cardLargeDetail(context, 'Business', 'ABC Enterprise Pvt. Ltd.'),
            cardLargeDetail(context, 'Phone', '9801265744'),
            cardLargeDetail(context, 'Sold on', '15 Jun 2023'),
            cardLargeDetail(context, 'Place', 'Chennai'),
            cardLargeDetail(context, 'Address',
                'Cathedral Rd, Parthasarathypuram, Teynampet, Chennai, Tamil Nadu - 600018'),
          ],
        ),
      ),
    );
  }

  Row cardLargeDetail(BuildContext context, String key, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            key,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: textColorLight,
                ),
          ),
        ),
        horizontalGap(10),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: textColorDark, fontWeight: FontWeight.w400, height: 1.5),
          ),
        )
      ],
    );
  }
}
