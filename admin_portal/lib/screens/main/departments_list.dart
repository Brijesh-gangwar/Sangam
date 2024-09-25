import 'package:admin_portal/data/dept_list.dart';
import 'package:flutter/material.dart';

import '../../widgets/line_chart.dart';

class DepartmentsList extends StatefulWidget {
  const DepartmentsList({super.key});

  @override
  State<DepartmentsList> createState() => _DepartmentsListState();
}

class _DepartmentsListState extends State<DepartmentsList> {
  final List<String> _list = deptrt_list;
  TextEditingController dept_search_controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.sizeOf(context).height;
    var b = MediaQuery.sizeOf(context).width;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
                height: h * 0.04,
                width: b * 0.13,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: const Color.fromARGB(255, 214, 212, 212)),
                child: const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'search here',
                    ),
                  ),
                )),
            const SizedBox(
              width: 4,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color.fromARGB(255, 92, 233, 104),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.add),
                    Text("Add new department"),
                  ],
                ),
              ),
            )
          ],
        ),
        SizedBox(
          width: b * 0.82,
          height: h * 0.74,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: h * 0.1,
                    ),
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Color.fromARGB(255, 126, 117, 120)),
                          child: Column(
                            children: [
                              const Text(
                                "ROAD DEPARTMENT",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Card(
                                    child: SizedBox(
                                      height: h * 0.26,
                                      width: b * 0.3,
                                      child: const Padding(
                                        padding:
                                            EdgeInsets.only(left: 20, top: 20),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Department head : Brijesh Gangwar",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "No. of users : 23",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "No. of resources : 9",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Card(
                                    child: SizedBox(
                                      height: h * 0.26,
                                      width: b * 0.3,
                                      child: const LineChartSample5(),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: h * 0.05,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Color.fromARGB(255, 126, 117, 120)),
                          child: Column(
                            children: [
                              const Text(
                                "Water DEPARTMENT",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Card(
                                    child: SizedBox(
                                      height: h * 0.26,
                                      width: b * 0.3,
                                      child: const Padding(
                                        padding:
                                            EdgeInsets.only(left: 20, top: 20),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Department head : Harshit",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "No. of users : 43",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "No. of resources : 12",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Card(
                                    child: SizedBox(
                                      height: h * 0.26,
                                      width: b * 0.3,
                                      child: const LineChartSample5(),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: h * 0.05,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Color.fromARGB(255, 126, 117, 120)),
                          child: Column(
                            children: [
                              const Text(
                                "Gas Pipeline DEPARTMENT",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Card(
                                    child: SizedBox(
                                      height: h * 0.26,
                                      width: b * 0.3,
                                      child: const Padding(
                                        padding:
                                            EdgeInsets.only(left: 20, top: 20),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Department head : Deepak",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "No. of users : 13",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "No. of resources : 6",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Card(
                                    child: SizedBox(
                                      height: h * 0.26,
                                      width: b * 0.3,
                                      child: const LineChartSample5(),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: h * 0.05,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Color.fromARGB(255, 126, 117, 120)),
                          child: Column(
                            children: [
                              const Text(
                                "Fire DEPARTMENT",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Card(
                                    child: SizedBox(
                                      height: h * 0.26,
                                      width: b * 0.3,
                                      child: const Padding(
                                        padding:
                                            EdgeInsets.only(left: 20, top: 20),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Department head : Anjali ",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "No. of users : 43",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "No. of resources : 6",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Card(
                                    child: SizedBox(
                                      height: h * 0.26,
                                      width: b * 0.3,
                                      child: const LineChartSample5(),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // right side part

              Padding(
                padding: const EdgeInsets.only(top: 6, right: 4, left: 4),
                child: Card(
                  elevation: 10,
                  child: Container(
                    height: h * 0.7,
                    width: b * 0.17,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 51, 49, 49),
                        borderRadius: BorderRadius.circular(12)),
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "List of Departments",
                            style: TextStyle(
                                color: Color.fromARGB(255, 226, 100, 142),
                                fontSize: 20),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: EdgeInsets.all(6.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.keyboard_arrow_right_sharp,
                                  size: 16,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Road Department",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(6.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.keyboard_arrow_right_sharp,
                                  size: 16,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Gas Pipeline Department",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(6.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.keyboard_arrow_right_sharp,
                                  size: 16,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Water Department",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(6.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.keyboard_arrow_right_sharp,
                                  size: 16,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Cleaning Department",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(6.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.keyboard_arrow_right_sharp,
                                  size: 16,
                                  color: Colors.white,
                                ),
                                Text(
                                  "PWD Department",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(6.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.keyboard_arrow_right_sharp,
                                  size: 16,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Fire Department",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
