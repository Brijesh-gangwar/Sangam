
import 'package:admin_portal/data/dept_list.dart';
import 'package:flutter/material.dart';

class DeptCard extends StatelessWidget {
   DeptCard({super.key,required this.index});

  int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(deptrt_list[index]),
    );
  }
}
