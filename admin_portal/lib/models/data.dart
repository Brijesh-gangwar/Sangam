// import 'package:flutter/material.dart';
// import 'package:flutter_practice/api/get_data/model/mulit_data_api_services.dart';
// import 'package:flutter_practice/api/get_data/model/mulit_data_model.dart';

// class screen_multi_data_api_withmodel extends StatefulWidget {
//   const screen_multi_data_api_withmodel({super.key});

//   @override
//   State<screen_multi_data_api_withmodel> createState() =>
//       _screen_multi_data_api_withmodelState();
// }

// class _screen_multi_data_api_withmodelState
//     extends State<screen_multi_data_api_withmodel> {
//   var isloading = false;
//   mulit_data_model contentdata = mulit_data_model();

//   get_multi_data() {
//     isloading = true;

//     mulit_data_api_services().getmulti_data_withmodel().then((value) {
//       setState(() {
//         contentdata = value!;
//         isloading = false;
//       });
//     }).onError((error, stackTrace) {
//       print(error);
//       isloading = false;
//     });
//   }

//   @override
//   void setState(VoidCallback fn) {
//     // TODO: implement setState
//     super.setState(fn);
//     get_multi_data();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         title: Text("multi data with model"),
//       ),
//       body: isloading == true
//           ? CircularProgressIndicator()
//           : ListView.builder(
//               itemCount: contentdata.data!.length,
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                     child: Column(
//                       children: [
//                         Text(contentdata.data![index].name.toString()),
//                         Text(contentdata.data![index].pantoneValue.toString()),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }
