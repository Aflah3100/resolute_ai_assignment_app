import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapWidget extends StatefulWidget {
  final void Function(LatLng) onMapTap;
  final LatLng? initialLatLng;
  final LatLng? laterLatLng;

  const GoogleMapWidget(
      {super.key,
      required this.onMapTap,
      this.initialLatLng,
      this.laterLatLng});

  @override
  _GoogleMapWidgetState createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  GoogleMapController? mapController;
  LocationData? currentLocation;
  Location location = Location();
  Set<Marker> markers = {};
  bool isLoading = true;
  LatLng? selectedLocation;

  @override
  void initState() {
    super.initState();
    //debugPrint("123> super.initState();");
    _getLocation();
  }

  void _getLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    // Check if location services are enabled
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        setState(() {
          isLoading = false;
        });
        return; // User did not enable location services
      }
    }

    // Check if location permission is granted
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        setState(() {
          isLoading = false;
        });
        _showPermissionDialog(); // Show dialog to open app settings
        return; // Location permission not granted
      }
    }

    // Get current location
    try {
      var locationData = await location.getLocation();
      setState(() {
        currentLocation = locationData;
        isLoading = false;
        _goToUserLocation();
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      //debugPrint('Error getting location: $e');
    }

    // move if there is initialLatLng
    if (widget.initialLatLng != null) {
      _onMapTap(widget.initialLatLng!);
    }
  }

  void _showPermissionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Location permission required'),
        content: Text('Please enable location permission to use'),
        actions: <Widget>[
          TextButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
              location.requestService(); // Open location settings
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.laterLatLng != null) {
      _addMarker(widget.laterLatLng!);
    }
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: _initialCameraPosition(),
          scrollGesturesEnabled: true,
          gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
            Factory<OneSequenceGestureRecognizer>(
              () => EagerGestureRecognizer(),
            ),
          },
          zoomGesturesEnabled: true,
          mapType: MapType.normal,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          onTap: _onMapTap,
          onMapCreated: (GoogleMapController controller) {
            // move if there is initialLatLng
            if (widget.initialLatLng != null) {
              _addMarker(widget.initialLatLng!);
            }
            setState(() {
              mapController = controller;
            });
          },
          markers: markers,
        ),
        Positioned(
          bottom: 24,
          right: 24,
          child: FloatingActionButton(
            onPressed: _goToUserLocation,
            child: const Icon(Icons.my_location),
          ),
        ),
        if (isLoading)
          const Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }

  CameraPosition _initialCameraPosition() {
    if (widget.laterLatLng != null) {
      return CameraPosition(
        target: widget.laterLatLng!,
        zoom: 14.0,
      );
    } else if (widget.initialLatLng != null) {
      return CameraPosition(
        target: widget.initialLatLng!,
        zoom: 14.0,
      );
    } else if (selectedLocation != null) {
      return CameraPosition(
        target: selectedLocation!,
        zoom: 14.0,
      );
    } else if (currentLocation != null) {
      var currentLatLng =
          LatLng(currentLocation!.latitude!, currentLocation!.longitude!);
      // _onMapTap(currentLatLng);
      return CameraPosition(
        target: currentLatLng,
        zoom: 14.0,
      );
    } else {
      return const CameraPosition(
        target: LatLng(11.5564, 104.9282), // Default to Phnom Penh coordinates
        zoom: 14.0,
      );
    }
  }

  void _onMapTap(LatLng tappedPoint) {
    setState(() {
      selectedLocation = tappedPoint;
      isLoading = false;
      _addMarker(tappedPoint);
    });
    widget.onMapTap(tappedPoint); // Call the callback function
  }

  void _addMarker(LatLng tappedPoint) {
    markers.clear(); // Clear existing markers
    markers.add(
      Marker(
        markerId: MarkerId(tappedPoint.toString()),
        position: tappedPoint,
        draggable: true,
        icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueRed), // marker icon
        onDragEnd: (dragEndPosition) {
          _onMarkerDragEnd(dragEndPosition);
        },
      ),
    );
  }

  void _onMarkerDragEnd(LatLng position) {
    _onMapTap(position); // Recursion here soumen bc
  }

  void _goToUserLocation() {
    if (currentLocation != null) {
      var currentLatLng =
          LatLng(currentLocation!.latitude!, currentLocation!.longitude!);
      mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: currentLatLng,
            zoom: 14.0,
          ),
        ),
      );
      _onMapTap(currentLatLng);
    } else {
      Fluttertoast.showToast(msg: 'Please enable location permission');
    }
  }
}
