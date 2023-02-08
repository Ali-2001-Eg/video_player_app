import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player_app/shared/colors.dart';
import 'package:video_player_app/video_info/video_info_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List info = [];

  _initData() async {
    await rootBundle.loadString('assets/json/info.json').then((s) {
      setState(() {
        info = json.decode(s);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homePageBackground,
      body: Container(
        padding: const EdgeInsets.only(top: 70, left: 30, right: 20),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Training',
                  style: TextStyle(
                    fontSize: 30,
                    color: AppColors.homePageTitle,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Expanded(child: Container()),
                Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: AppColors.homePageIcons,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Icon(Icons.calendar_today_outlined),
                const SizedBox(
                  width: 15,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  color: AppColors.homePageIcons,
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Text(
                  'You program',
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColors.homePageSubTitle,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Expanded(child: Container()),
                GestureDetector(
                  onTap:()=>Get.to(()=>VideoInfoPage()),

                  child: Text(
                    'Details',
                    style: TextStyle(
                      fontSize: 20,
                      color: AppColors.homePageDetail,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap:()=>Get.to(()=>VideoInfoPage()),
                  child: Icon(
                    Icons.arrow_forward,
                    size: 20,
                    color: AppColors.homePageIcons,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            //gradient container
            Container(
              padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
              width: MediaQuery.of(context).size.width,
              height: 220,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.gradientFirst.withOpacity(0.8),
                      AppColors.gradientSecond.withOpacity(0.9),
                    ],
                    begin: Alignment.bottomLeft,
                    end: Alignment.centerRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(5, 10),
                      blurRadius: 10,
                      color: AppColors.gradientSecond.withOpacity(0.2),
                    )
                  ],
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(80),
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Next workout',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'Legs Toning',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'and Glutes Workout',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w700),
                  ),
                  Expanded(child: Container()),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Icon(
                        Icons.alarm,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        '60 min',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Expanded(child: Container()),
                      Container(
                        padding: const EdgeInsets.only(right: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(80),
                            boxShadow: [
                              BoxShadow(
                                  offset: const Offset(2, 4),
                                  color: AppColors.gradientFirst,
                                  blurRadius: 50)
                            ]),
                        child: CircleAvatar(
                          radius: 30,
                          child: Icon(
                            Icons.play_arrow,
                            color: AppColors.gradientFirst,
                            size: 35,
                          ),
                          backgroundColor: Colors.white,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            //plan
            SizedBox(
              height: 180,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    margin: const EdgeInsets.only(top: 30),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        image: const DecorationImage(
                            image: const AssetImage('assets/images/cart_1.png'),
                            fit: BoxFit.fill),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 40,
                              offset: const Offset(8, 10),
                              color: AppColors.gradientSecond.withOpacity(0.3)),
                          //top shadow
                          BoxShadow(
                              blurRadius: 10,
                              offset: const Offset(-1, -5),
                              color: AppColors.gradientSecond.withOpacity(0.3)),
                        ]),
                  ),
                  Container(
                    height: 200,
                    width: 350,
                    margin: const EdgeInsets.only(right: 200, bottom: 50),
                    decoration: BoxDecoration(
                      // color: Colors.redAccent.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(30),
                      image: const DecorationImage(
                        image: const AssetImage('assets/images/figure.png'),
                        //fit: BoxFit.fill
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 100,
                    // color: Colors.redAccent.withOpacity(0.3),
                    margin: const EdgeInsets.only(left: 150, top: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'You are doing great',
                          style: TextStyle(
                              color: AppColors.homePageDetail, fontSize: 20),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Keep it up',
                          style: TextStyle(
                              color: AppColors.homePagePlanColor, fontSize: 16),
                        ),
                        Text(
                          'Stick to your plan',
                          style: TextStyle(
                              color: AppColors.homePagePlanColor, fontSize: 15),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Area of focus',
                  style: TextStyle(
                      fontSize: 26,
                      color: AppColors.homePageTitle,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            //to draw in the second line when grids are equal to 3
            Expanded(
                child: OverflowBox(
                  maxWidth: MediaQuery.of(context).size.width,
                  child: MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      //to view just two elements (half)
              itemCount: info.length.toDouble() ~/ 2,
              itemBuilder: (context, index) {
                    //to have another value when index=2
                    int a = index *2;//0 , 2
                    int b = (index*2)+1;//1 ,3
                    return Row(
                      children: [
                        Container(
                          height: 170,
                          //to make spaces between next to grids
                          width: (MediaQuery.of(context).size.width-90)/2,
                          margin: EdgeInsets.only(left: 30,right: 30,bottom: 10,top: 10),
                          decoration: BoxDecoration(
                              color: AppColors.homePageBackground,
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: AssetImage(info[a]['img']),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 3,
                                  offset: Offset(5, 5),
                                  color: AppColors.gradientSecond.withOpacity(0.1),
                                ),
                                BoxShadow(
                                  blurRadius: 3,
                                  offset: Offset(-5, -5),
                                  color: AppColors.gradientSecond.withOpacity(0.1),
                                )
                              ]),
                          padding: EdgeInsets.only(bottom: 10),
                          child: Center(
                            child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  info[a]['title'],
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: AppColors.homePageDetail),
                                )),
                          ),
                        ),
                        //index+1 to view other elements
                        Container(
                          height: 170,
                          width: (MediaQuery.of(context).size.width-90)/2,
                          margin: EdgeInsets.only(bottom: 10,top: 10),

                          decoration: BoxDecoration(
                              color: AppColors.homePageBackground,
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: AssetImage(info[b]['img']),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 3,
                                  offset: Offset(5, 5),
                                  color: AppColors.gradientSecond.withOpacity(0.1),
                                ),
                                BoxShadow(
                                  blurRadius: 3,
                                  offset: Offset(-5, -5),
                                  color: AppColors.gradientSecond.withOpacity(0.1),
                                )
                              ]),
                          padding: EdgeInsets.only(bottom: 10),
                          child: Center(
                            child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  info[b]['title'],
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: AppColors.homePageDetail),
                                )),
                          ),
                        ),
                      ],
                    );
              },
            ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
