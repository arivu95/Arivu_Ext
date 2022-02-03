import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:stacked/stacked.dart';
import 'package:swaradmin/shared/app_colors.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:swaradmin/shared/flutter_overlay_loader.dart';
import 'package:swaradmin/shared/ui_helpers.dart';
import 'package:swaradmin/ui/dashboard/pie_chart_model.dart';

void enablePlatformOverrideForDesktop() {
  if (!kIsWeb && (Platform.isMacOS || Platform.isWindows || Platform.isLinux)) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
}

enum LegendShape { Circle, Rectangle }

class PieChartNew extends StatefulWidget {
  @override
  _PieChartNewState createState() => _PieChartNewState();
}

class _PieChartNewState extends State<PieChartNew> {
  List<Color> usercolorList = [piechartFreeUserColor, piecharPaidUserColor];
  List<Color> membercolorList = [
    piechartActiveMemberColor,
    piechartDeActiveMemberColor,
  ];

  ChartType? _chartType = ChartType.disc;
  bool _showCenterText = true;
  double? _ringStrokeWidth = 32;
  double? _chartLegendSpacing = 32;

  bool _showLegendsInRow = false;
  bool _showLegends = true;

  bool _showChartValueBackground = true;
  bool _showChartValues = true;
  bool _showChartValuesInPercentage = false;
  bool _showChartValuesOutside = false;

  LegendShape? _legendShape = LegendShape.Circle;
  LegendPosition? _legendPosition = LegendPosition.right;

  int key = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(25),
        child: ViewModelBuilder<PiechartViewmodel>.reactive(
            onModelReady: (model) async {
              Loader.show(context);
              await model.getmemberscount();
              Loader.hide();
            },
            builder: (context, model, child) {
              Map<String, double> memberdata = {
                "Active": model.act_count,
                "Deactive": model.deact_count,
              };
              Map<String, double> pricedata = {
                "Free User": model.free_user,
                "Paid User": model.paid_user,
              };
              final memberchart = PieChart(
                key: ValueKey(key),
                dataMap: memberdata,
                animationDuration: Duration(milliseconds: 800),
                chartLegendSpacing: _chartLegendSpacing!,
                chartRadius: MediaQuery.of(context).size.width / 3.2 > 300
                    ? 300
                    : MediaQuery.of(context).size.width / 3.2,
                colorList: membercolorList,
                initialAngleInDegree: 0,
                chartType: _chartType!,
                // centerText: _showCenterText ? "HYBRID" : null,
                legendOptions: LegendOptions(
                  showLegendsInRow: _showLegendsInRow,
                  legendPosition: _legendPosition!,
                  showLegends: _showLegends,
                  legendShape: _legendShape == LegendShape.Circle
                      ? BoxShape.circle
                      : BoxShape.rectangle,
                  legendTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                chartValuesOptions: ChartValuesOptions(
                  showChartValueBackground: _showChartValueBackground,
                  showChartValues: _showChartValues,
                  showChartValuesInPercentage: _showChartValuesInPercentage,
                  showChartValuesOutside: _showChartValuesOutside,
                ),
                ringStrokeWidth: _ringStrokeWidth!,
                emptyColor: Colors.grey,
              );

              final userchart = PieChart(
                key: ValueKey(key),
                dataMap: pricedata,
                animationDuration: Duration(milliseconds: 800),
                chartLegendSpacing: _chartLegendSpacing!,
                chartRadius: MediaQuery.of(context).size.width / 3.2 > 300
                    ? 300
                    : MediaQuery.of(context).size.width / 3.2,
                colorList: usercolorList,
                initialAngleInDegree: 0,
                chartType: _chartType!,
                // centerText: _showCenterText ? "HYBRID" : null,
                legendOptions: LegendOptions(
                  showLegendsInRow: _showLegendsInRow,
                  legendPosition: _legendPosition!,
                  showLegends: _showLegends,
                  legendShape: _legendShape == LegendShape.Circle
                      ? BoxShape.circle
                      : BoxShape.rectangle,
                  legendTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                chartValuesOptions: ChartValuesOptions(
                  showChartValueBackground: _showChartValueBackground,
                  showChartValues: _showChartValues,
                  showChartValuesInPercentage: _showChartValuesInPercentage,
                  showChartValuesOutside: _showChartValuesOutside,
                ),
                ringStrokeWidth: _ringStrokeWidth!,
                emptyColor: Colors.grey,
              );

              return Scaffold(
                body: LayoutBuilder(
                  builder: (_, constraints) {
                    if (constraints.maxWidth >= 600) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                       
                          Text('Dashboard')
                              .fontSize(20)
                              .fontWeight(FontWeight.w700),

                          UIHelper.verticalSpaceMedium,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                flex: 2,
                                fit: FlexFit.tight,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Users')
                                        .bold()
                                        .fontSize(21)
                                        .textAlignment(TextAlign.left)
                                        .textColor(activeColor),
                                    UIHelper.verticalSpaceMedium,
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 100.0),
                                      child: memberchart,
                                    ),
                                  ],
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                fit: FlexFit.tight,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Subscriptions')
                                        .bold()
                                        .fontSize(21)
                                        .textAlignment(TextAlign.center)
                                        .textColor(activeColor),
                                    UIHelper.verticalSpaceMedium,
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 100.0),
                                      child: userchart,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    } else {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Dashboard')
                                      .fontSize(20)
                                      .fontWeight(FontWeight.w700),
                                  UIHelper.verticalSpaceMedium,
                                ]),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Users')
                                      .bold()
                                      .fontSize(21)
                                      .textAlignment(TextAlign.center)
                                      .textColor(activeColor),
                                  UIHelper.verticalSpaceMedium,
                                  memberchart,
                                ],
                              ),
                              margin: EdgeInsets.symmetric(
                                vertical: 32,
                              ),
                            ),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Subscriptions')
                                      .bold()
                                      .fontSize(21)
                                      .textAlignment(TextAlign.center)
                                      .textColor(activeColor),
                                  UIHelper.verticalSpaceMedium,
                                  userchart,
                                ],
                              ),
                              margin: EdgeInsets.symmetric(
                                vertical: 32,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              );
            },
            viewModelBuilder: () => PiechartViewmodel()));
  }
}
