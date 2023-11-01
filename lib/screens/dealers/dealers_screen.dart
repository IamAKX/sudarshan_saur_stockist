import 'package:app_bar_with_search_switch/app_bar_with_search_switch.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saur_stockist/model/allocated_model.dart';
import 'package:saur_stockist/model/dealer_short_model.dart';
import 'package:saur_stockist/model/model_list/allocated_list.dart';
import 'package:saur_stockist/model/warranty_model.dart';
import 'package:saur_stockist/screens/dealers/dealer_detail.dart';
import 'package:saur_stockist/utils/theme.dart';

import '../../model/model_list/warranty_request_list.dart';
import '../../service/api_service.dart';
import '../../service/snakbar_service.dart';
import '../../utils/colors.dart';
import '../../utils/enum.dart';
import '../../utils/preference_key.dart';

class DealersScreen extends StatefulWidget {
  const DealersScreen({super.key});

  @override
  State<DealersScreen> createState() => _DealersScreenState();
}

class _DealersScreenState extends State<DealersScreen> {
  AllocatedList? list;
  late ApiProvider _api;
  // Map<int, DealerShortModel> dealerShortMap = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => reloadScreen(),
    );
  }

  reloadScreen() async {
    await _api
        .getAllocatedWarrantyList(SharedpreferenceKey.getUserId())
        .then((value) {
      setState(() {
        list = value;
      });
    });
    // await _api
    //     .getWarrantyRequestListByStockist(SharedpreferenceKey.getUserId())
    //     .then((value) {
    //   setState(() {
    //     list = value;
    //     dealerShortMap.clear();
    //     for (WarrantyModel model in list?.data ?? []) {
    //       if (dealerShortMap.containsKey(model.dealers?.dealerId)) {
    //         DealerShortModel dsm = dealerShortMap[model.dealers?.dealerId]!;
    //         dsm.count = (dsm.count ?? 0) + 1;
    //         dealerShortMap[model.dealers!.dealerId!] = dsm;
    //       } else {
    //         DealerShortModel dsm = DealerShortModel(
    //             count: 1,
    //             id: model.dealers?.dealerId,
    //             image: model.dealers?.image,
    //             name: model.dealers?.dealerName);
    //         dealerShortMap[model.dealers!.dealerId!] = dsm;
    //       }
    //     }
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    SnackBarService.instance.buildContext = context;
    _api = Provider.of<ApiProvider>(context);
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
          title: Text(
            'Allocated Device',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          actions: const [
            // AppBarSearchButton(
            //   buttonHasTwoStates: false,
            // )
          ],
        ),
      ),
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    if (_api.status == ApiStatus.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return ListView.separated(
        itemBuilder: (context, index) {
          AllocatedModel? item = list?.data?.elementAt(index);
          return ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(settingsPageUserIconSize),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(110),
                child: (item?.dealer?.image?.isEmpty ?? true)
                    ? Image.asset(
                        'assets/images/profile_image_placeholder.png',
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                      )
                    : CachedNetworkImage(
                        imageUrl: item?.dealer?.image ?? '',
                        fit: BoxFit.cover,
                        width: 40,
                        height: 40,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Image.asset(
                          'assets/images/profile_image_placeholder.png',
                          width: 40,
                          height: 40,
                        ),
                      ),
              ),
            ),
            title: Text(
              '${item?.dealer?.dealerName ?? ''}',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            subtitle: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${item?.warrantySerialNo}',
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  color: dividerColor,
                  width: 1,
                  height: 15,
                ),
                Text(
                  item?.warrantyRequests?.status ??
                      AllocationStatus.ALLOCATED.name,
                  style: TextStyle(
                      color: getColorByStatus(item?.warrantyRequests?.status ??
                          AllocationStatus.ALLOCATED.name)),
                ),
              ],
            ),
            trailing: const Icon(
              Icons.chevron_right,
              color: hintColor,
            ),
            onTap: () => Navigator.pushNamed(context, DealerDetail.routePath,
                    arguments: list?.data?.elementAt(index))
                .then((value) => reloadScreen()),
          );
        },
        separatorBuilder: (context, index) => const Divider(
              color: dividerColor,
              indent: defaultPadding * 5,
            ),
        itemCount: list?.data?.length ?? 0);
  }
}
