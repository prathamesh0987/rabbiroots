import 'package:flutter/material.dart';
import 'package:location/location.dart' as loc;
import 'package:geocoding/geocoding.dart';
import 'package:rabbi_roots/screens/location_access_screen.dart';
import 'package:rabbi_roots/screens/location_access_screen2.dart';
import 'package:rabbi_roots/screens/profile/profile_screen.dart';

class DeliverySection extends StatefulWidget {
  const DeliverySection({Key? key}) : super(key: key);

  @override
  _DeliverySectionState createState() => _DeliverySectionState();
}

class _DeliverySectionState extends State<DeliverySection> {
  loc.Location _location = loc.Location();
  String _currentLocation = "Fetching location...";
  bool _isLocationEnabled = false;

  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  // Initialize the location service
  Future<void> _initializeLocation() async {
    bool _serviceEnabled;
    loc.PermissionStatus _permissionGranted;

    // Check if the location service is enabled
    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        setState(() {
          _currentLocation = "Location services are disabled";
        });
        return;
      }
    }

    // Check if the app has location permission
    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == loc.PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != loc.PermissionStatus.granted) {
        setState(() {
          _currentLocation = "Location permission denied";
        });
        return;
      }
    }

    // Fetch the current location
    loc.LocationData _locationData = await _location.getLocation();

    // Use geocoding to get the address from latitude and longitude
    List<Placemark> placemarks = await placemarkFromCoordinates(
      _locationData.latitude!,
      _locationData.longitude!,
    );

    // Extract the address from placemarks (you can customize which fields you want)
    Placemark place = placemarks[0]; // Get the first place in the list
    String address =
        "${place.street}, ${place.locality} ,${place.administrativeArea}";

    // Update the UI with the fetched address
    setState(() {
      _currentLocation = address;
    });
  }

  // New screen to open when the arrow is tapped
  void _navigateToNewScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            LocationAccessScreen(), // Replace with your new screen widget
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: const Color(0xFFF06B2D),
                    radius: 25,
                    child: const Icon(Icons.location_on, color: Colors.white),
                  ),
                  const SizedBox(width: 9),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Deliver To',
                        style: TextStyle(
                          color: Color(0xFF056839),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Inter',
                        ),
                      ),
                      Text(
                        _currentLocation,
                        style: const TextStyle(
                          color: Color(0xFF9D9D9D),
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 9),
                  GestureDetector(
                    onTap:
                        _navigateToNewScreen, // Call method when the arrow is tapped
                    child: const Icon(
                      Icons.arrow_drop_down,
                      color: Color(0xFF056839),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  // Handle tap here
                  // You can navigate to a new screen or perform any other action
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(),
                    ),
                  );
                },
                child: const CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://s3-alpha-sig.figma.com/img/4eed/dea2/50b16a6f7edf69ea1cf19a2c703ed08d?Expires=1736121600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=oda-2Ww5yNZa-AF2ys1fcHgEyvA--adJUq~NWttbbj9SJffd8BcqSfcUETwZH-PKlZ2EmnUxfRhV-GQynMmIKy9rFX3pgY3Zh8xnEAVUJOuMl0xGCB5Xu8pcHCvvpSQdv2DBVOHe0-Nm~bEnS8UmWQz5dtiT4PWHXSTAwG2YKm-SV5DtPoSBnbkDTacXZMhs9scY-XW7y5gFjV-jXsIVsNlvppxNNOOPIy4F~QoqUN7-mtd0bV0e0lTm9q6l9WCV~caN0UQAjr-UF-PSFxh97EyVrsm5LmpViTp6SWDbGYjMv20W10NYxiZ~seIi9iTpGVQ0fEzU17UaWBtRdINc5w__',
                  ),
                  radius: 22.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Hello Amit, Good Afternoon !!',
            style: TextStyle(
              color: Color(0xFF056839),
              fontSize: 16,
              fontWeight: FontWeight.w400,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }
}

// New Screen
class NewScreen extends StatelessWidget {
  const NewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Screen"),
      ),
      body: Center(
        child: const Text("This is a new screen!"),
      ),
    );
  }
}
