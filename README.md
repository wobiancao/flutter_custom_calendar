
## FlutterCalendarWidget

Flutter上的一个日历控件，可以定制成自己想要的样子。

## 原项目地址
[flutter_custom_calendar](https://github.com/fluttercandies/flutter_custom_calendar)

## fork后插件pub.dev地址 
[get_flutter_custom_calendar](https://pub.dev/packages/get_flutter_custom_calendar)

## [2.0.0+1] 仅更新master get状态管理分支
- 周视图、月视图 添加"回到今天"
- 额外数据可以随时注入

## [2.0.0]
- null-safety 支持
- 主分支状态管理改成getx
- provider状态管理保留


Language: [English](README_en.md)|中文简体

- [FlutterCalendarWidget](#fluttercalendarwidget)
  - [概述](#%e6%a6%82%e8%bf%b0)
  - [在线Demo](#%e5%9c%a8%e7%ba%bfdemo)
  - [效果图](#%e6%95%88%e6%9e%9c%e5%9b%be)
- [使用](#%e4%bd%bf%e7%94%a8)
- [2.0版本](#20%e7%89%88%e6%9c%ac)
- [注意事项](#%e6%b3%a8%e6%84%8f%e4%ba%8b%e9%a1%b9)
- [主要API文档](#%e4%b8%bb%e8%a6%81api%e6%96%87%e6%a1%a3)

### 概述

* 支持公历，农历，节气，传统节日，常用节假日
* 日期范围设置，默认支持的最大日期范围为1971.01-2055.12
* 禁用日期范围设置，比如想实现某范围的日期内可以点击，范围外的日期置灰
* 支持单选、多选模式，提供多选超过限制个数的回调和多选超过指定范围的回调。
* 跳转到指定日期，默认支持动画切换
* 自定义日历Item，支持组合widget的方式和利用canvas绘制的方式
* 自定义顶部的WeekBar
* 根据实际场景，可以给Item添加自定义的额外数据，实现各种额外的功能。比如实现进度条风格的日历，实现日历的各种标记
* 支持周视图的展示,支持月份视图和星期视图的展示与切换联动



### 效果图

<table>
<tbody>
    <td>
<img src="https://github.com/wobiancao/flutter_custom_calendar/blob/master/screenshot/Screenshot_2023-12-13-15-30-50-868_com.example.example.jpg?raw=true" width="280" height="620">
</td>
<td>
<img src="https://github.com/wobiancao/flutter_custom_calendar/blob/master/screenshot/Screenshot_2023-12-13-15-30-55-491_com.example.example.jpg?raw=true" width="280" height="620">
</td>
<tr>
<td>
<img src="https://github.com/wobiancao/flutter_custom_calendar/blob/master/screenshot/Screenshot_2023-12-13-14-15-11-356_com.example.example.jpg?raw=true" width="280" height="620">
</td>
<td>
<img src="https://github.com/wobiancao/flutter_custom_calendar/blob/master/screenshot/Screenshot_2023-12-13-14-15-18-720_com.example.example.jpg?raw=true" width="280" height="620">
</td>
</tr>

<td>
<img src="https://github.com/wobiancao/flutter_custom_calendar/blob/master/screenshot/Screenshot_2023-12-13-14-15-23-860_com.example.example.jpg?raw=true" width="280" height="620">
</td>
<td>
<img src="https://github.com/wobiancao/flutter_custom_calendar/blob/master/screenshot/WX20231213-162215@2x.png?raw=true" width="280" height="578">
</td>




</tbody>
</table>


## 使用

1.在pubspec.yaml文件里面添加依赖:
```
flutter_custom_calendar:
    git:
      url: https://github.com/wobiancao/flutter_custom_calendar.git
```
or
```
get_flutter_custom_calendar: ^2.0.0+1
```

2.导入flutter_custom_calendar库
```
import 'package:get_flutter_custom_calendar/flutter_custom_calendar.dart';
```

3.创建CalendarViewWidget对象，配置CalendarController
```
CalendarController controller= new CalendarController(
        minYear: 2018,
        minYearMonth: 1,
        maxYear: 2020,
        maxYearMonth: 12,
        showMode: CalendarConstants.MODE_SHOW_MONTH_AND_WEEK);
CalendarViewWidget calendar= CalendarViewWidget(
              calendarController: controller,
            ),
```

* boxDecoration用来配置整体的背景
* 利用CalendarController来配置一些数据，并且可以通过CalendarController进行一些操作或者事件监听，比如滚动到下一个月，获取当前被选中的Item等等。

4.操作日历

```
controller.currentDayPage();//月视图或周视图下 都可回到当月或当周page
```
```
controller.changeExtraData(customExtraData);//额外数据随时可以注入
```

```
controller.toggleExpandStatus();//月视图和周视图的切换
```

```
controller.previousPage();//操作日历切换到上一页
```

```
controller.nextPage();//操作日历切换到下一页
```


## 2.0版本
主要改动：
* UI配置相关的参数，移动到CalendarView的构造方法里面（旧版本是在controller里面配置）
* 日历支持padding和margin属性，item的大小计算修改
* 实现日历整体自适应高度
* controller提供changeExtraDataMap的方法，可以随时动态的修改自定义数据extraDataMap
* 支持显示月视图和周视图的情况，优先显示周视图，MODE_SHOW_WEEK_AND_MONTH
* 支持verticalSpacing和itemSize属性


## 注意事项

* 如果使用2.0之前的版本，则需要将UI配置相关的参数，移动到CalendarView的构造方法里面（旧版本是在controller里面配置）
* 暂时没有发现其他问题，如果有其他问题，可以跟我说一下。
* 如果你用这个库做了日历，可以将展示结果分享给我，我贴到文档上进行展示

## 主要API文档

[API Documentation](API.md)
