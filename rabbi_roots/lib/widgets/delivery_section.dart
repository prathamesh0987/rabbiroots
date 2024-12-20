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
                    'https://s3-alpha-sig.figma.com/img/4eed/dea2/50b16a6f7edf69ea1cf19a2c703ed08d?Expires=1734912000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=oDK7YXd4KT3lW983wBE2sfdaMY1lKKN9og5T6hEZwh-hrAcSqNAkUpPiEYV5nIqit0P7qva1-r4vimS1QX-dXQrW5EcY6BK-JYT388wSGvEkPjINuTNW4KB6pyKQpnqwbN5WyLgjg5zIzLh~L~IWrgdPOq-PbTuQlwDLtIXnQsAgKgkB4iPBpz14GYH0gCHtZXCRQzWX9e-k8KTBKxG6QH-4Gyi-hs7rjnyCznDbTJDhwhq~ul9OoDW1W4pd~QXUfbA0a3oK13jfFSH-PSJFdYwT~q~xnO1K5SjtSqwblUm9I2Xt0pbfcEeK~Jht77~VQhpfaAX6MZ0N9ogC-HwbQg__',
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
