import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swaradmin/shared/app_colors.dart';
import 'package:swaradmin/shared/screen_size.dart';
import 'package:swaradmin/shared/ui_helpers.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:swaradmin/ui/members/add_member_view.dart';

class ViewMemberView extends StatefulWidget {
  ViewMemberView({Key? key}) : super(key: key);

  @override
  _ViewMemberViewState createState() => _ViewMemberViewState();
}

class _ViewMemberViewState extends State<ViewMemberView> {
  Widget addHeader(BuildContext context) {
    return SizedBox(
      height: 240,
      child: Stack(
        children: [
          Image.asset(
            'assets/member.jpg',
            height: 140,
            width: Screen.width(context),
            fit: BoxFit.cover,
          ),
          Positioned(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: Screen.width(context) - 32,
                height: 130,
                padding: EdgeInsets.all(8),
                decoration:
                    UIHelper.roundedBorderWithColorWithShadow(6, fieldBgColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.portrait,
                              color: activeColor,
                            ),
                            UIHelper.horizontalSpaceSmall,
                            Text('Arun').bold()
                          ],
                        ),
                        UIHelper.verticalSpaceTiny,
                        Row(
                          children: [
                            Icon(
                              Icons.email,
                              color: activeColor,
                            ),
                            UIHelper.horizontalSpaceSmall,
                            Text('arun@gmail.com')
                          ],
                        ),
                        UIHelper.verticalSpaceTiny,
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today_sharp,
                              color: activeColor,
                            ),
                            UIHelper.horizontalSpaceSmall,
                            Text('10/19/1982')
                          ],
                        ),
                        UIHelper.verticalSpaceTiny,
                        Row(
                          children: [
                            Icon(
                              Icons.run_circle_outlined,
                              color: activeColor,
                            ),
                            UIHelper.horizontalSpaceSmall,
                            Text('35')
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.group,
                            size: 50,
                            color: activeColor,
                          ),
                          Text('Father')
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            bottom: 0,
          ),
          Positioned(
              right: 10,
              top: 10,
              child: GestureDetector(
                onTap: () {
                  Get.to(() => AddMemberView(
                        isEditMode: true,
                      ));
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.edit,
                      size: 15,
                      color: activeColor,
                    ),
                    UIHelper.horizontalSpaceSmall,
                    Text('Edit').textColor(Colors.white).fontSize(13)
                  ],
                ),
              ))
        ],
      ),
    );
  }

  Widget additionalInfoWidget(
      BuildContext context, String title, String value, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: activeColor,
        ),
        UIHelper.horizontalSpaceSmall,
        SizedBox(
          child: Text(title).fontSize(13),
          width: Screen.width(context) / 2.5,
        ),
        Flexible(
          child: Text(value).fontSize(13),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        // appBar: swaradminBar(),
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 0),
            width: Screen.width(context),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              UIHelper.verticalSpaceMedium,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: UIHelper.addHeader(context, "View Member", true),
              ),
              UIHelper.verticalSpaceSmall,
              addHeader(context),
              UIHelper.verticalSpaceSmall,
              Expanded(
                  child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: UIHelper.roundedBorderWithColor(8, fieldBgColor),
                  width: Screen.width(context),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.water_damage_sharp,
                            color: activeColor,
                          ),
                          UIHelper.horizontalSpaceSmall,
                          SizedBox(
                            child: Text('Blood Group').fontSize(13),
                            width: Screen.width(context) / 2.5,
                          ),
                          Flexible(
                            child: Text('O+ve').fontSize(13),
                          )
                        ],
                      ),
                      UIHelper.verticalSpaceSmall,
                      Row(
                        children: [
                          Icon(
                            Icons.phone_android_outlined,
                            color: activeColor,
                          ),
                          UIHelper.horizontalSpaceSmall,
                          SizedBox(
                            child: Text('Mobile Number').fontSize(13),
                            width: Screen.width(context) / 2.5,
                          ),
                          Flexible(
                            child: Text('9988776655').fontSize(13),
                          )
                        ],
                      ),
                      UIHelper.verticalSpaceSmall,
                      additionalInfoWidget(context, 'Alternate Number',
                          '787867656', Icons.phone_android_outlined),
                      UIHelper.verticalSpaceSmall,
                      additionalInfoWidget(context, 'Address',
                          'C/o world, Co123G0', Icons.location_on),
                      UIHelper.verticalSpaceSmall,
                      additionalInfoWidget(
                          context, 'Country', 'USA', Icons.public),
                      UIHelper.verticalSpaceSmall,
                      additionalInfoWidget(
                          context, 'State', 'Vignor', Icons.location_on),
                      UIHelper.verticalSpaceSmall,
                      additionalInfoWidget(
                          context, 'City', 'LA', Icons.location_city),
                      UIHelper.verticalSpaceSmall,
                      additionalInfoWidget(
                          context, 'Zipcode', '67545', Icons.location_pin),
                      UIHelper.verticalSpaceSmall,
                      additionalInfoWidget(
                          context, 'Allergic to', 'NA', Icons.wash_outlined),
                      UIHelper.verticalSpaceSmall,
                    ],
                  ),
                ),
              ))
            ])));
  }
}
