import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../flutter_custom_calendar.dart';
import '../utils/date_util.dart';
import 'month_view.dart';

/**
 * 周视图，只显示本周的日子
 */
class WeekView extends StatefulWidget {
  final int year;
  final int month;
  final DateModel firstDayOfWeek;
  final CalendarConfiguration configuration;

  const WeekView(
      {required this.year,
      required this.month,
      required this.firstDayOfWeek,
      required this.configuration});

  @override
  _WeekViewState createState() => _WeekViewState();
}

class _WeekViewState extends State<WeekView> {
  late List<DateModel> items;

  late Map<DateModel, Object> extraDataMap; //自定义额外的数据

  @override
  void initState() {
    super.initState();
    extraDataMap = widget.configuration.extraDataMap;
    items = DateUtil.initCalendarForWeekView(
        widget.year, widget.month, widget.firstDayOfWeek.getDateTime(), 0,
        minSelectDate: widget.configuration.minSelectDate!,
        maxSelectDate: widget.configuration.maxSelectDate!,
        extraDataMap: extraDataMap,
        offset: widget.configuration.offset);

    //第一帧后,添加监听，generation发生变化后，需要刷新整个日历
    WidgetsBinding.instance?.addPostFrameCallback((callback) {
      var calendarLogic = Get.find<CalendarLogic>();
      ever(calendarLogic.generation, (callback) async{
        items = DateUtil.initCalendarForWeekView(
            widget.year, widget.month, widget.firstDayOfWeek.getDateTime(), 0,
            minSelectDate: widget.configuration.minSelectDate!,
            maxSelectDate: widget.configuration.maxSelectDate!,
            extraDataMap: extraDataMap,
            offset: widget.configuration.offset);
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var calendarLogic = Get.find<CalendarLogic>();
    CalendarConfiguration configuration = calendarLogic.calendarConfiguration;
    return new GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7, mainAxisSpacing: 10),
        itemCount: 7,
        itemBuilder: (context, index) {
          DateModel dateModel = items[index];
          //判断是否被选择
          if (configuration.selectMode == CalendarSelectedMode.multiSelect) {
            if (calendarLogic.selectedDateList.contains(dateModel)) {
              dateModel.isSelected = true;
            } else {
              dateModel.isSelected = false;
            }
          }
          if (configuration.selectMode == CalendarSelectedMode.singleSelect) {
            if (calendarLogic.selectDateModel == dateModel) {
              dateModel.isSelected = true;
            } else {
              dateModel.isSelected = false;
            }
          }
          if (configuration.selectMode ==
              CalendarSelectedMode.mutltiStartToEndSelect) {
            if (calendarLogic.selectedDateList.contains(dateModel)) {
              dateModel.isSelected = true;
            } else {
              dateModel.isSelected = false;
            }
          }

          return ItemContainer(
              dateModel: dateModel,
              clickCall: () {
                setState(() {});
              });
        });
  }
}
