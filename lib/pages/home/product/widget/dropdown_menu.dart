// import 'package:admin_app/constants/app_color.dart';
// import 'package:flutter/material.dart';


// class CrDropdownMenu extends StatelessWidget {
//   final dropValue = ValueNotifier('');
//   final dropOpcoes = ['Man/lop', 'điebnj', 'động cơ'];
//   CrDropdownMenu({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 20),
//       child: Column(
//         children: [
//           ValueListenableBuilder(
//             valueListenable: dropValue,
//             builder: (BuildContext context, String value, _) {
//               return SizedBox(
//                 width: size.width,
//                 child: DropdownButtonFormField<String>(
//                   decoration: InputDecoration(
//                     label: const Text('data'),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20.0),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20.0),
//                       borderSide: const BorderSide(
//                         color: AppColor
//                             .bgaddimages, // Đổi màu viền khi không được chọn
//                         width: 2.0,
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(20.0),
//                       borderSide: const BorderSide(
//                         color: Colors.blue, // Đổi màu viền khi được chọn
//                         width: 2.0,
//                       ),
//                     ),
//                   ),
//                   isExpanded: true,
//                   icon: const Icon(Icons.drive_eta_outlined),
//                   hint: const Text('data'),
//                   value: (value.isEmpty) ? null : value,
//                   onChanged: (escolhe) => dropValue.value = escolhe.toString(),
//                   items: dropOpcoes
//                       .map(
//                         (op) => DropdownMenuItem(
//                           value: op,
//                           child: Text(op),
//                         ),
//                       )
//                       .toList(),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
