import 'package:flutter/material.dart';
import 'package:saur_stockist/model/warranty_model.dart';
import 'package:saur_stockist/utils/date_time_formatter.dart';
import 'package:saur_stockist/utils/helper_method.dart';

import '../../utils/colors.dart';
import '../../utils/theme.dart';
import '../../widgets/gaps.dart';

class AssignedDetail extends StatefulWidget {
  static const String routePath = '/assignedDetail';
  final WarrantyModel warrantyModel;

  const AssignedDetail({super.key, required this.warrantyModel});

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
              '${widget.warrantyModel.itemDescription}',
            ),
            cardLargeDetail(context, 'Serial No',
                '${widget.warrantyModel.warrantySerialNo}'),
            cardLargeDetail(context, 'Guarantee',
                '${widget.warrantyModel.guaranteePeriod}'),
            cardLargeDetail(
                context, 'Model No', '${widget.warrantyModel.model}'),
            cardLargeDetail(context, 'LPD', '${widget.warrantyModel.lpd}'),
            cardLargeDetail(
                context,
                'Installed on',
                DateTimeFormatter.onlyDateShort(
                    widget.warrantyModel.installationDate ?? '')),
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
            cardLargeDetail(context, 'Dealer',
                '${widget.warrantyModel.dealers?.dealerName}'),
            cardLargeDetail(context, 'Business',
                '${widget.warrantyModel.dealers?.businessName}'),
            cardLargeDetail(
                context, 'Phone', '${widget.warrantyModel.dealers?.mobileNo}'),
            cardLargeDetail(
                context, 'Email', '${widget.warrantyModel.dealers?.email}'),
            cardLargeDetail(context, 'Place', '${widget.warrantyModel.state}'),
            cardLargeDetail(context, 'Address',
                prepareAddress(widget.warrantyModel.dealers?.address)),
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
