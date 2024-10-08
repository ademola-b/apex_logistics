import 'package:another_stepper/another_stepper.dart';
import 'package:apex_logistics/components/defaultButton.dart';
import 'package:apex_logistics/components/defaultText.dart';
import 'package:apex_logistics/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:top_modal_sheet/top_modal_sheet.dart';

class DecideRouteController extends GetxController {
  RxBool isDriver =
      true.obs; //based on the authenticated user type or use sharedPreference
  RxBool onlineCard = false.obs;
  RxBool isDriverOnline = false.obs;
  RxBool startRideModal = false.obs;

  Rx<double> leftPosition = 0.0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // listener to display incoming request - to be changed appropriately
    //ever: to be called any time the driverStatus changes
    ever(isDriverOnline, (value) {
      if (value) {
        incomingRequest(Get.context);
      }
    });
  }

  incomingRequest(context, {double? size}) async {
    return await Future.delayed(
        const Duration(seconds: 2),
        () => showTopModalSheet(
            context,
            Container(
              width: MediaQuery.of(context).size.width,
              // padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: requestCard(),
              ),
            )));
  }

  Widget requestCard() {
    final List<StepperData> stepperData = [
      StepperData(
        title: const StepperText(
          "Pick up",
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: "RobotoRegular",
          ),
        ),
        subtitle: const StepperText(
          "6 Tudun Wada Street, Bauchi",
          textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            fontFamily: "RobotoRegular",
          ),
        ),
        iconWidget: Container(
          decoration: const BoxDecoration(
            color: Constants.primaryNormal,
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          child: const Icon(
            Icons.circle,
            color: Constants.whiteNormal,
            size: 18,
          ),
        ),
      ),
      StepperData(
        title: const DefaultText(
          text: "Drop Location",
          size: 16.0,
          weight: FontWeight.bold,
        ),
        subtitle: const Row(children: [
          DefaultText(text: "Wada Street, Bauchi North", size: 14.0),
          SizedBox(width: 20.0),
          DefaultText(text: "Text", size: 14.0),
        ]),
        iconWidget: Container(
          decoration: const BoxDecoration(
            color: Constants.primaryNormal,
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          child: const Icon(
            Icons.location_on_outlined,
            color: Constants.whiteNormal,
            size: 18,
          ),
        ),
      ),
      StepperData(
        title: const StepperText(
          "Drop Location 2",
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: "RobotoRegular",
          ),
        ),
        subtitle: const StepperText(
          "Wada Street, Bauchi North",
          textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            fontFamily: "RobotoRegular",
          ),
        ),
        iconWidget: Container(
          decoration: const BoxDecoration(
            color: Constants.primaryNormal,
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          child: const Icon(
            Icons.location_on_outlined,
            color: Constants.whiteNormal,
            size: 18,
          ),
        ),
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const DefaultText(
                text: "Apex Logistics",
                weight: FontWeight.bold,
                size: 16,
              ),
              const SizedBox(width: 10.0),
              ClipOval(
                // to be changed to user image (memory)
                child: Image.asset(
                  "assets/images/rider.jpg",
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AnotherStepper(
                stepperList: stepperData,
                stepperDirection: Axis.vertical,
                iconWidth: 30,
                iconHeight: 30,
                activeBarColor: Constants.primaryNormal,
                inActiveBarColor: Colors.grey,
                inverted: false,
                verticalGap: 20,
                activeIndex: 1,
                barThickness: 1,
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          //decision buttons
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: DefaultButton(
                    onPressed: () {},
                    buttonColor: Constants.whiteNormal,
                    borderColor: Constants.primaryNormal,
                    buttonHeight: 40,
                    child: const DefaultText(
                        text: "Reject", fontColor: Constants.primaryNormal),
                  ),
                ),
                const SizedBox(width: 20.0),
                Expanded(
                  child: DefaultButton(
                    onPressed: () {
                      Get.close(1);
                      onlineCard.value = false;
                      startRideModal.value = true;
                    },
                    buttonHeight: 40,
                    child: const DefaultText(
                        text: "Accept", fontColor: Colors.white),
                  ),
                )
              ],
            ),
          )

          // stepper
        ],
      ),
    );
  }

  goOnline() {}

  goOffline() {}

  driverStats(Size size) {
    return Container(
        width: size.width,
        height: size.height / 2.5,
        decoration: const BoxDecoration(
          color: Constants.whiteLight,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Row(
            children: [
              SizedBox(
                width: size.width / 2.5,
                height: 300,
                child: statContainer(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: PieChart(
                          chartRadius: size.width / 4,
                          initialAngleInDegree: 0,
                          dataMap: const {
                            "a": 31.0,
                            "b": 69.0
                          }, //a is main value
                          // centerText: "31%",
                          centerWidget: const DefaultText(
                            text: "31%",
                            fontColor: Constants.primaryNormal,
                            size: 20.0,
                          ),
                          chartType: ChartType.ring,
                          ringStrokeWidth: 10,
                          baseChartColor: Colors.grey[50]!.withOpacity(0.15),
                          colorList: const [
                            Constants.primaryNormal,
                            Constants.primaryLight
                          ],
                          legendOptions: const LegendOptions(
                            showLegends: false,
                          ),
                          chartValuesOptions: const ChartValuesOptions(
                            showChartValues: false,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 5.0),
                        child: DefaultText(
                          text: "Confirmation Rate:\n 31%",
                          align: TextAlign.center,
                          fontColor: Constants.primaryNormal,
                          size: 16.0,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: DefaultText(
                          text: "Apex",
                          fontColor: Constants.blackDark,
                          size: 18.0,
                          weight: FontWeight.bold,
                        ),
                      )
                    ])),
              ),
              const SizedBox(width: 20.0),
              Expanded(
                child: Column(children: [
                  Expanded(
                    child: SizedBox(
                      width: size.width / 2,
                      // height: 150,
                      child: statContainer(
                          backgroundColor: Constants.primaryNormal,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  "assets/images/earnings.png",
                                  width: 30,
                                  height: 30,
                                ),
                                const Expanded(
                                    child: SizedBox(height: 10.0)),
                                const DefaultText(
                                  text: "Today's Earnings",
                                  fontColor: Constants.whiteLight,
                                ),
                                const SizedBox(height: 5.0),
                                const Expanded(
                                  child: DefaultText(
                                    text: "N12,000",
                                    size: 18.0,
                                    fontColor: Constants.whiteLight,
                                    weight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Expanded(
                    child: SizedBox(
                      width: size.width / 2,
                      height: 300,
                      child: statContainer(
                          child: const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DefaultText(
                              text: "Driver's Score",
                              fontColor: Constants.blackDark,
                              weight: FontWeight.w600,
                            ),
                            SizedBox(height: 10.0),
                            DefaultText(
                                text: "33%",
                                size: 18.0,
                                weight: FontWeight.bold),
                          ],
                        ),
                      )),
                    ),
                  ),
                ]),
              )
            ],
          ),
        ));
  }

  Container statContainer({Color? backgroundColor, Widget? child}) {
    return Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white,
          border: Border.all(
            color: Constants.primaryNormal,
            width: 1.0,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: child);
  }
}
