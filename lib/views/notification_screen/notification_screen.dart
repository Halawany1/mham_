import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mham/controller/home_cubit/home_cubit.dart';
import 'package:mham/core/helper/helper.dart';
import 'package:mham/views/notification_screen/widget/card_notification.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mham/views/notification_screen/widget/empty_notification.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var font = Theme.of(context).textTheme;
    var color = Theme.of(context);
    final locale = AppLocalizations.of(context);

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              locale.notifications,
              style: font.bodyLarge!.copyWith(fontSize: 20.sp),
            ),
            leading: InkWell(
                onTap: () {
                  HomeCubit.get(context).getNotification();
                  Helper.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: color.primaryColor,
                )),
          ),
          body: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollEndNotification &&
                  notification.metrics.extentAfter == 0) {
                if (context.mounted) {
                  if (HomeCubit.get(context)
                      .notificationModel!
                      .notifications!
                      .isNotEmpty) {
                    HomeCubit.get(context).getNotification(
                        page: HomeCubit.get(context).notificationModel!.page! +
                            1);
                  }
                }
              }
              return false;
            },
            child: RefreshIndicator(
              color: color.primaryColor,
              onRefresh: () async{
                cubit.getNotification();
              },
              child: Padding(
                padding: EdgeInsets.all(20.h),
                child: cubit.notifications.isEmpty &&
                        state is! LoadingGetNotificationState &&
                  state is! LoadingUpdateNotificationState
                    ? BuildEmptyNotification()
                    : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListView.separated(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) =>
                                    BuildCardNotification(
                                      index: index,
                                    ),
                                separatorBuilder: (context, index) => SizedBox(
                                      height: 15.h,
                                    ),
                                itemCount: cubit.notifications.length),
                            if (state is LoadingGetNotificationState)
                              SizedBox(
                                height: 20.h,
                              ),
                            if (state is LoadingGetNotificationState)
                              Center(
                                  child: CircularProgressIndicator(
                                color: color.primaryColor,
                              )),
                            if (state is LoadingGetNotificationState)
                              SizedBox(
                                height: 25.h,
                              ),
                          ],
                        ),
                      ),
              ),
            ),
          ),
        );
      },
    );
  }
}
