import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../flutter_custom_calendar.dart';
import '../utils/LogUtil.dart';
import 'week_view.dart';

class WeekViewPager extends StatefulWidget {
  const WeekViewPager({Key? key}) : super(key: key);

  @override
  _WeekViewPagerState createState() => _WeekViewPagerState();
}

class _WeekViewPagerState extends State<WeekViewPager>
    with AutomaticKeepAliveClientMixin {
  late int lastMonth; //保存上一个月份，不然不知道月份发生了变化
  late CalendarLogic calendarLogic;

//  PageController newPageController;

  @override
  void initState() {
    super.initState();
    LogUtil.log(TAG: this.runtimeType, message: "WeekViewPager initState");

    calendarLogic = Get.find<CalendarLogic>();

    lastMonth = calendarLogic.lastClickDateModel.month;
  }

  @override
  void dispose() {
    LogUtil.log(TAG: this.runtimeType, message: "WeekViewPager dispose");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    LogUtil.log(TAG: this.runtimeType, message: "WeekViewPager build");

    //    获取到当前的CalendarProvider对象,设置listen为false，不需要刷新
    
    CalendarConfiguration configuration =
        calendarLogic.calendarConfiguration;
    return Container(
      height: configuration.itemSize ?? MediaQuery.of(context).size.width / 7,
      child: PageView.builder(
        onPageChanged: (position) {
          if (calendarLogic.expandStatus.value == true) {
            return;
          }

          LogUtil.log(
              TAG: this.runtimeType,
              message:
                  "WeekViewPager PageView onPageChanged,position:$position");
          DateModel firstDayOfWeek = configuration.weekList[position];
          int currentMonth = firstDayOfWeek.month;
//          周视图的变化
          configuration.weekChangeListeners.forEach((listener) {
            listener(firstDayOfWeek.year, firstDayOfWeek.month);
          });
          if (lastMonth != currentMonth) {
            LogUtil.log(
                TAG: this.runtimeType,
                message:
                    "WeekViewPager PageView monthChange:currentMonth:$currentMonth");
            configuration.monthChangeListeners.forEach((listener) {
              listener(firstDayOfWeek.year, firstDayOfWeek.month);
            });
            lastMonth = currentMonth;
            if (calendarLogic.lastClickDateModel == null || calendarLogic.lastClickDateModel.month != currentMonth) {
              DateModel temp = new DateModel();
              temp.year = firstDayOfWeek.year;
              temp.month = firstDayOfWeek.month;
              temp.day = firstDayOfWeek.day + 14;
              print('83 周视图的变化: $temp');
              calendarLogic.lastClickDateModel = temp;
            }
          }
//          calendarLogic.lastClickDateModel = configuration.weekList[position]
//            ..day += 4;
        },
        controller: calendarLogic.calendarConfiguration.weekController,
        itemBuilder: (context, index) {
          DateModel dateModel = configuration.weekList[index];
          print('dateModel: $dateModel');
          return new WeekView(
            year: dateModel.year,
            month: dateModel.month,
            firstDayOfWeek: dateModel,
            configuration: calendarLogic.calendarConfiguration,
          );
        },
        itemCount: configuration.weekList.length,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
