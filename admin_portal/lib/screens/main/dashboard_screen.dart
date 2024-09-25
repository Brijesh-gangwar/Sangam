import 'package:admin_portal/widgets/line_chart.dart';
import 'package:admin_portal/widgets/pie_chart.dart';

import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<String> imgList = [
    'https://via.placeholder.com/600x400/FF0000/FFFFFF?text=Slide+1',
    'https://via.placeholder.com/600x400/00FF00/FFFFFF?text=Slide+2',
    'https://via.placeholder.com/600x400/0000FF/FFFFFF?text=Slide+3',
  ];
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.sizeOf(context).height;
    var b = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: const EdgeInsets.only(
        right: 8,
        bottom: 8,
      ),
      child: Card(
        elevation: 10,
        child: Container(
            width: b * 0.82,
            height: h * 0.84,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(16),
            ),
            child: SingleChildScrollView(
                child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
                  child: Container(
                      width: b * 0.58,
                      height: h * 0.84,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Card(
                            elevation: 12,
                            child: SizedBox(
                              width: b * 0.27,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    const Center(
                                        child: Text(
                                      "Project 1",
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    )),
                                    const Card(
                                      elevation: 12,
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Project admin : ",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  "Anjali",
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Location : ",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  "Ghaziabad",
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "duration : ",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  "6 months",
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Card(
                                      elevation: 12,
                                      child: Center(
                                        child: Column(
                                          children: [
                                            const Text(
                                              "Progress",
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Container(
                                              child: const PieChartSample2(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Container(
                                          child: const Column(
                                            children: [
                                              Center(
                                                child: Text(
                                                  "Tasks",
                                                  style: TextStyle(
                                                      fontSize: 26,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .keyboard_arrow_right_sharp,
                                                    size: 16,
                                                  ),
                                                  Text(
                                                    "gas pipeline checking",
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .keyboard_arrow_right_sharp,
                                                    size: 16,
                                                  ),
                                                  Text(
                                                    "route clearance",
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .keyboard_arrow_right_sharp,
                                                    size: 16,
                                                  ),
                                                  Text(
                                                    "checking end connection",
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .keyboard_arrow_right_sharp,
                                                    size: 16,
                                                  ),
                                                  Text(
                                                    "digging of route",
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .keyboard_arrow_right_sharp,
                                                    size: 16,
                                                  ),
                                                  Text(
                                                    "pipeline route checking",
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),

                          // project 2
                          Card(
                            elevation: 12,
                            child: SizedBox(
                              width: b * 0.27,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    const Center(
                                        child: Text(
                                      "Project 2",
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    )),
                                    const Card(
                                      elevation: 12,
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Project admin : ",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  "Harshit",
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Location : ",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  "Ghaziabad",
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "duration : ",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  "11 months",
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Card(
                                      elevation: 12,
                                      child: Center(
                                        child: Container(
                                          child: const Column(
                                            children: [
                                              Text(
                                                "Progress",
                                                style: TextStyle(
                                                    fontSize: 24,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              PieChartSample2(),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Container(
                                          child: const Column(
                                            children: [
                                              Center(
                                                child: Text(
                                                  "Tasks",
                                                  style: TextStyle(
                                                      fontSize: 26,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .keyboard_arrow_right_sharp,
                                                    size: 16,
                                                  ),
                                                  Text(
                                                    "Road checking",
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .keyboard_arrow_right_sharp,
                                                    size: 16,
                                                  ),
                                                  Text(
                                                    "route clearance",
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .keyboard_arrow_right_sharp,
                                                    size: 16,
                                                  ),
                                                  Text(
                                                    "Route end clearance",
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .keyboard_arrow_right_sharp,
                                                    size: 16,
                                                  ),
                                                  Text(
                                                    "digging of route",
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .keyboard_arrow_right_sharp,
                                                    size: 16,
                                                  ),
                                                  Text(
                                                    "Making road",
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
                // right side part
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 10,
                        child: Container(
                          width: b * 0.2,
                          height: h * 0.26,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: h * 0.26,
                                width: b * 0.3,
                                child: const LineChartSample5(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 10,
                        child: Container(
                          width: b * 0.2,
                          height: h * 0.26,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Column(
                            children: [
                              Center(
                                  child: Text(
                                "Notifications",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              )),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.keyboard_arrow_right_sharp,
                                    size: 16,
                                  ),
                                  Text(
                                    "Meeting of road dept",
                                    style: TextStyle(fontSize: 16),
                                    overflow: TextOverflow.clip,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.keyboard_arrow_right_sharp,
                                    size: 16,
                                  ),
                                  Text(
                                    "Webinar to fire dept",
                                    style: TextStyle(fontSize: 16),
                                    overflow: TextOverflow.clip,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.keyboard_arrow_right_sharp,
                                    size: 16,
                                  ),
                                  Text(
                                    "New project near akgec",
                                    style: TextStyle(fontSize: 16),
                                    overflow: TextOverflow.clip,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 10,
                        child: Container(
                          width: b * 0.2,
                          height: h * 0.26,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Column(
                            children: [
                              Center(
                                  child: Text(
                                "Conflicts",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              )),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.keyboard_arrow_right_sharp,
                                    size: 16,
                                  ),
                                  Text(
                                    "conflicts between road and",
                                    style: TextStyle(fontSize: 16),
                                    overflow: TextOverflow.clip,
                                  ),
                                ],
                              ),
                              Text(
                                "gas pipeline project",
                                style: TextStyle(fontSize: 16),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ))),
      ),
    );
  }
}
