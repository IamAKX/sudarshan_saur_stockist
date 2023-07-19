import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:saur_stockist/utils/theme.dart';

import '../../utils/colors.dart';
import '../../widgets/gaps.dart';

class DealerDetail extends StatefulWidget {
  const DealerDetail({super.key});
  static const String routePath = '/dealerDetail';

  @override
  State<DealerDetail> createState() => _DealerDetailState();
}

class _DealerDetailState extends State<DealerDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dealer Name',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    return Column(
      children: [
        allotmentDetailCard(context),
        Text(
          'Assigned Serial Numbers',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Expanded(
          child: Card(
            color: Colors.white,
            margin: const EdgeInsets.all(defaultPadding),
            child: ListView.separated(
                itemBuilder: (context, index) => ListTile(
                      tileColor: Colors.white,
                      title: Text(
                        '200 WUGL-A-58X200-10',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      subtitle: Text('Serial Number : 221548$index'),
                      trailing: IconButton(
                        onPressed: () {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.question,
                            animType: AnimType.bottomSlide,
                            title: 'Are you sure?',
                            desc:
                                'You are about to unassign Serial Number : 221548$index from this dealer.',
                            onDismissCallback: (type) {},
                            autoDismiss: false,
                            btnOkOnPress: () {
                              Navigator.pop(context);
                            },
                            btnCancelOnPress: () {
                              Navigator.pop(context);
                            },
                            btnOkColor: Colors.red,
                            btnCancelColor: primaryColor,
                          ).show();
                        },
                        icon: const Icon(
                          Icons.cancel,
                          color: Colors.red,
                        ),
                      ),
                    ),
                separatorBuilder: (context, index) => const Divider(
                      color: dividerColor,
                    ),
                itemCount: 28),
          ),
        )
      ],
    );
  }

  Card allotmentDetailCard(BuildContext context) {
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
              'Allotment Details',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            verticalGap(defaultPadding * 0.5),
            cardLargeDetail(context, 'Count', '28'),
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
