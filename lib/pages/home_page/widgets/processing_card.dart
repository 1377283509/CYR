// import 'package:cyr/utils/navigator/custom_navigator.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:provider/provider.dart';
// import 'package:cyr/providers/provider_list.dart';
// import 'package:cyr/pages/page_list.dart';
//
// class ProcessingCard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     String userId = Provider.of<DoctorProvider>(context).user.id;
//     RecordProvider recordProvider = Provider.of<RecordProvider>(context);
//     return Container(
//         margin: const EdgeInsets.symmetric(horizontal: 12),
//         decoration: BoxDecoration(
//             color: Colors.white, borderRadius: BorderRadius.circular(12)),
//         child: ListTile(
//             leading: const Icon(
//               Icons.graphic_eq,
//               color: Colors.red,
//               size: 32,
//             ),
//             onTap: () {
//               navigateTo(context, ProcessingListPage());
//             },
//             title: const Text(
//               "正在处理",
//               style: TextStyle(
//                   color: Colors.black54,
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold),
//             ),
//             trailing: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 FutureBuilder(
//                   future: recordProvider.getProcessingRecordCount(userId),
//                   builder: (BuildContext context, snapshot) {
//                     switch (snapshot.connectionState) {
//                       case ConnectionState.done:
//                         {
//                           return Text(
//                             "${snapshot.data}",
//                             style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black54),
//                           );
//                         }
//                       default:
//                         {
//                           return CupertinoActivityIndicator();
//                         }
//                     }
//                   },
//                 ),
//                 const Icon(
//                   Icons.keyboard_arrow_right,
//                   color: Colors.grey,
//                 )
//               ],
//             )));
//   }
// }
