import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saur_stockist/model/dealer_model.dart';
import 'package:saur_stockist/model/warranty_model.dart';
import 'package:saur_stockist/service/api_service.dart';
import 'package:saur_stockist/utils/helper_method.dart';
import 'package:saur_stockist/utils/theme.dart';
import 'package:saur_stockist/widgets/alert_popup.dart';

import '../../model/model_list/warranty_request_list.dart';
import '../../service/snakbar_service.dart';
import '../../utils/colors.dart';
import '../../widgets/gaps.dart';

class DealerDetail extends StatefulWidget {
  const DealerDetail({super.key, required this.data});
  static const String routePath = '/dealerDetail';
  final Map<String, dynamic> data;

  @override
  State<DealerDetail> createState() => _DealerDetailState();
}

class _DealerDetailState extends State<DealerDetail> {
  DealerModel? dealer;
  List<WarrantyModel> filteredList = [];
  WarrantyRequestList? list;
  late ApiProvider _api;

  @override
  void initState() {
    super.initState();
    list = widget.data['list'];
    int id = widget.data['id'];
    dealer = list?.data
        ?.firstWhere((element) => element.dealers?.dealerId == id)
        .dealers;
    for (WarrantyModel model in (list?.data ?? [])) {
      if (model.dealers?.dealerId == id) {
        filteredList.add(model);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SnackBarService.instance.buildContext = context;
    _api = Provider.of<ApiProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${dealer?.dealerName}',
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
                        '${filteredList.elementAt(index).itemDescription}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      subtitle: Text(
                          'Serial Number : ${filteredList.elementAt(index).warrantySerialNo}'),
                      trailing: IconButton(
                        onPressed: () {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.question,
                            animType: AnimType.bottomSlide,
                            title: 'Are you sure?',
                            desc:
                                'You are about to unassign Serial Number : ${filteredList.elementAt(index).warrantySerialNo} from this dealer.',
                            onDismissCallback: (type) {},
                            autoDismiss: false,
                            btnOkOnPress: () async {
                              await _api
                                  .deleteWarrantyRequest(filteredList
                                          .elementAt(index)
                                          .warrantySerialNo ??
                                      '')
                                  .then((value) {
                                if (value) {
                                  Navigator.pop(context);
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.success,
                                    animType: AnimType.bottomSlide,
                                    title: 'Success',
                                    desc: 'Serial number unassigned',
                                    onDismissCallback: (type) {},
                                    autoDismiss: false,
                                    btnOkOnPress: () {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                    btnOkColor: primaryColor,
                                  ).show();
                                }
                              });
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
                itemCount: filteredList.length),
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
            cardLargeDetail(context, 'Count', '${filteredList.length}'),
            cardLargeDetail(context, 'Dealer', '${dealer?.dealerName}'),
            cardLargeDetail(context, 'Business', '${dealer?.businessName}'),
            cardLargeDetail(context, 'Phone', '${dealer?.mobileNo}'),
            cardLargeDetail(context, 'Email', '${dealer?.email}'),
            cardLargeDetail(
                context, 'Address', prepareAddress(dealer?.address)),
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
