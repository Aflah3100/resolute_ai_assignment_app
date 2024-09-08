
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class GoogleMapFullScreen extends StatefulWidget {
//   // final void Function(LatLng) onMapTap;
//   final LatLng? initialLatLng;
//   const GoogleMapFullScreen({super.key, this.initialLatLng});

//   @override
//   State<GoogleMapFullScreen> createState() => _GoogleMapFullScreenState();
// }

// class _GoogleMapFullScreenState extends State<GoogleMapFullScreen> {
//   LatLng? selectedLatLng;

//   @override
//   void initState() {
//     super.initState();
//     selectedLatLng = widget.initialLatLng;
//   }

//   Future<bool> _onWillPop() async {
//     if (selectedLatLng != null) {
//       Navigator.pop(context, selectedLatLng);
//     } else {
//       Navigator.pop(context);
//     }
//     return false; // Prevent default pop behavior
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(translation(context).select_address),
//       ),
//       body: WillPopScope(
//         onWillPop: _onWillPop,
//         child: GoogleMapWidget(
//           onMapTap: (mTappedPoint) => {selectedLatLng = mTappedPoint},
//           initialLatLng: selectedLatLng,
//         ),
//       ),
//     );
//   }
// }
