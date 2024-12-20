import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart'; // Import geocoding package
import 'package:flutter_typeahead/flutter_typeahead.dart';

class LocationAccessScreen extends StatefulWidget {
  const LocationAccessScreen({Key? key}) : super(key: key);

  @override
  State<LocationAccessScreen> createState() => _LocationAccessScreenState();
}

class _LocationAccessScreenState extends State<LocationAccessScreen> {
  GoogleMapController? _mapController;
  final LatLng _initialPosition =
      const LatLng(18.5204, 73.8567); // Pune coordinates
  LatLng? _selectedLocation;
  TextEditingController _locationController = TextEditingController();

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _onTapMap(LatLng position) {
    setState(() {
      _selectedLocation = position;
      _locationController.text =
          ''; // Clear the search field when tapping on the map
    });
  }

  // Function to search for location manually using geocoding
  Future<void> _searchLocation(String query) async {
    if (query.isEmpty) return;

    try {
      // Get location from the address
      List<Location> locations = await locationFromAddress(query);

      if (locations.isNotEmpty) {
        final LatLng newLocation =
            LatLng(locations[0].latitude, locations[0].longitude);

        setState(() {
          _selectedLocation = newLocation;
          _locationController.text =
              query; // Update search field with the selected address
        });

        // Move the camera to the selected location
        if (_mapController != null) {
          _mapController!.animateCamera(CameraUpdate.newLatLng(newLocation));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No results found for this address")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error geocoding address")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 0, // Hides the default AppBar
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _initialPosition,
                    zoom: 14.0,
                  ),
                  onTap: _onTapMap,
                  markers: _selectedLocation != null
                      ? {
                          Marker(
                            markerId: const MarkerId('selectedLocation'),
                            position: _selectedLocation!,
                          ),
                        }
                      : {},
                ),
                // Floating Buttons for Zoom
                Positioned(
                  top: 10,
                  right: 10,
                  child: Column(
                    children: [
                      FloatingActionButton(
                        heroTag: "zoomIn",
                        mini: true,
                        backgroundColor: Colors.white,
                        onPressed: () {
                          if (_mapController != null) {
                            _mapController!
                                .animateCamera(CameraUpdate.zoomIn());
                          }
                        },
                        child: const Icon(Icons.zoom_in, color: Colors.black),
                      ),
                      const SizedBox(height: 10),
                      FloatingActionButton(
                        heroTag: "zoomOut",
                        mini: true,
                        backgroundColor: Colors.white,
                        onPressed: () {
                          if (_mapController != null) {
                            _mapController!
                                .animateCamera(CameraUpdate.zoomOut());
                          }
                        },
                        child: const Icon(Icons.zoom_out, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Bottom Location Access Section
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.0,
                  offset: Offset(0, -5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Search Location Input Field with TypeAhead
                TypeAheadField(
                  textFieldConfiguration: TextFieldConfiguration(
                    controller: _locationController,
                    decoration: InputDecoration(
                      hintText: "Enter Location Manually",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                    ),
                  ),
                  suggestionsCallback: (pattern) async {
                    if (pattern.isEmpty) {
                      return [];
                    }

                    // Get suggestions using geocoding (Address -> lat, lng)
                    List<Location> locations =
                        await locationFromAddress(pattern);
                    List<String> addressSuggestions = [];

                    // Convert lat/lng into full address strings for each location
                    for (var location in locations) {
                      String address = await _getAddressFromCoordinates(
                          location.latitude, location.longitude);
                      if (address.isNotEmpty) {
                        addressSuggestions.add(address); // Add the full address
                      }
                    }

                    // Return all the full address suggestions
                    return addressSuggestions;
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      title: Text(suggestion), // Display the address suggestion
                    );
                  },
                  onSuggestionSelected: (suggestion) async {
                    // Handle selection of the suggestion
                    await _searchLocation(suggestion);
                  },
                ),

                const SizedBox(height: 10),
                const Text(
                  "OR",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    if (_selectedLocation != null) {
                      // Handle selected location
                      print("Selected Location: $_selectedLocation");
                    } else {
                      // Show a warning if no location is selected
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Please select a location")),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7CD033),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  icon: const Icon(Icons.my_location, color: Colors.white),
                  label: const Text(
                    "Access Location",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                const SizedBox(height: 10),
                const Text(
                  "Rabbiroots will access your location only while using app. "
                  "We will be delivering orders up to 3km only.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Logic for "Continue" button
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF06B2D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    "Continue",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper function to get the full address from coordinates (latitude, longitude)
  Future<String> _getAddressFromCoordinates(
      double latitude, double longitude) async {
    try {
      // Get placemarks for the coordinates (lat, lng)
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isNotEmpty) {
        // Combine multiple address components to form a full address string
        Placemark placemark = placemarks[0];

        // Build full address from available components
        String fullAddress = '';
        if (placemark.name != null) fullAddress += placemark.name! + ', ';
        if (placemark.thoroughfare != null)
          fullAddress += placemark.thoroughfare! + ', '; // Street
        if (placemark.subThoroughfare != null)
          fullAddress += placemark.subThoroughfare! + ', '; // Sub street
        if (placemark.locality != null)
          fullAddress += placemark.locality! + ', '; // City
        if (placemark.administrativeArea != null)
          fullAddress += placemark.administrativeArea! + ', '; // State
        if (placemark.postalCode != null)
          fullAddress += placemark.postalCode! + ', '; // Postal Code
        if (placemark.country != null)
          fullAddress += placemark.country!; // Country

        // Remove trailing comma and space
        if (fullAddress.endsWith(', ')) {
          fullAddress = fullAddress.substring(0, fullAddress.length - 2);
        }

        return fullAddress;
      }
    } catch (e) {
      print("Error getting full address from coordinates: $e");
    }
    return '';
  }
}
