import 'package:flutter/material.dart';
import 'package:payments/ui/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF00796B)),
        useMaterial3: true,
      ),
      home: const Login(),
    );
  }
}

// class MyHomePage extends StatelessWidget {
//   const MyHomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Home Page',
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: Color(0xFF00796B),
//         elevation: 0,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Color(0xFF00796B),
//                 padding: EdgeInsets.symmetric(horizontal: 48, vertical: 16),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               onPressed: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(builder: (context) => const Products()),
//                 );
//               },
//               child: Text(
//                 'Products',
//                 style: TextStyle(
//                   fontSize: 20,
//                   color: Colors.white,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//             // SizedBox(height: 20),
//             // ElevatedButton(
//             //   style: ElevatedButton.styleFrom(
//             //     backgroundColor: Color(0xFF00796B),
//             //     padding: EdgeInsets.symmetric(horizontal: 48, vertical: 16),
//             //     shape: RoundedRectangleBorder(
//             //       borderRadius: BorderRadius.circular(8),
//             //     ),
//             //   ),
//             //   onPressed: () {
//             //     Navigator.of(context).push(
//             //       MaterialPageRoute(builder: (context) => const Payments()),
//             //     );
//             //   },
//             //   child: Text(
//             //     'Got to Payments',
//             //     style: TextStyle(
//             //       fontSize: 20,
//             //       color: Colors.white,
//             //       fontWeight: FontWeight.w600,
//             //     ),
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }
