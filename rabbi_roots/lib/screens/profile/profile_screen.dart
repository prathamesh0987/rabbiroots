import 'package:flutter/material.dart';
import 'package:rabbi_roots/screens/login_screen.dart';
import 'package:rabbi_roots/screens/past_order_screen.dart';
import 'package:rabbi_roots/screens/profile/about/about.dart';
import 'package:rabbi_roots/screens/profile/account_details/account_details.dart';
import 'package:rabbi_roots/screens/profile/customer_care/customer_care.dart';
import 'package:rabbi_roots/screens/profile/manage_addressees/manage_addresses.dart';
import 'package:rabbi_roots/screens/profile/payments_and_refunds/payments_and_refunds.dart';
import 'package:rabbi_roots/screens/profile/ratings_and_reviews/ratings_and_reviews.dart';
import 'package:rabbi_roots/screens/profile/settings/settings.dart';
import 'package:rabbi_roots/screens/profile/your_orders/your_orders.dart';
import 'package:rabbi_roots/screens/sign_in_screen.dart';
import 'package:rabbi_roots/services/session.dart';
import 'package:rabbi_roots/widgets/profile_header.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.transparent,
        elevation: 1,
      ),
      body: CustomScrollView(
        slivers: [
          // Profile Header Section - Non-scrollable header
          SliverToBoxAdapter(
            child: ProfileHeader(
              name: 'Amit',
              email: 'amit123@gmail.com',
              profileImageUrl:
                  'https://s3-alpha-sig.figma.com/img/4eed/dea2/50b16a6f7edf69ea1cf19a2c703ed08d?Expires=1734912000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=oDK7YXd4KT3lW983wBE2sfdaMY1lKKN9og5T6hEZwh-hrAcSqNAkUpPiEYV5nIqit0P7qva1-r4vimS1QX-dXQrW5EcY6BK-JYT388wSGvEkPjINuTNW4KB6pyKQpnqwbN5WyLgjg5zIzLh~L~IWrgdPOq-PbTuQlwDLtIXnQsAgKgkB4iPBpz14GYH0gCHtZXCRQzWX9e-k8KTBKxG6QH-4Gyi-hs7rjnyCznDbTJDhwhq~ul9OoDW1W4pd~QXUfbA0a3oK13jfFSH-PSJFdYwT~q~xnO1K5SjtSqwblUm9I2Xt0pbfcEeK~Jht77~VQhpfaAX6MZ0N9ogC-HwbQg__',
            ),
          ),
          // Profile Options Section - Scrollable list
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _buildProfileOption(Icons.info, 'About', context),
                _buildProfileOption(Icons.person, 'Account Details', context),
                _buildProfileOption(Icons.shopping_bag, 'Your Orders', context),
                _buildProfileOption(
                    Icons.location_on, 'Manage Addresses', context),
                _buildProfileOption(
                    Icons.payment, 'Payments & Refunds', context),
                _buildProfileOption(Icons.star, 'Ratings and Reviews', context),
                _buildProfileOption(
                    Icons.support_agent, 'Customer Care', context),
                _buildProfileOption(Icons.logout, 'Logout', context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileOption(
      IconData icon, String title, BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.green.shade100,
        child: Icon(
          icon,
          color: Colors.green,
        ),
      ),
      title: Text(title),
      trailing: Icon(Icons.chevron_right),
      onTap: () {
        if (title == "Logout") {
          showLogoutDialog(context);
        }
        if (title == "About") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AboutScreen(),
            ),
          );
        }
        if (title == "Account Details") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AccountDetailsScreen(),
            ),
          );
        }
        if (title == "Your Orders") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PastOrdersScreen(),
            ),
          );
        }
        if (title == "Manage Addresses") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ManageAddressesScreen(),
            ),
          );
        }
        if (title == "Payments & Refunds") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PaymentsAndRefundsScreen(),
            ),
          );
        }
        if (title == "Ratings and Reviews") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RatingsAndReviewsScreen(),
            ),
          );
        }
        if (title == "Customer Care") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CustomerCareScreen(),
            ),
          );
        }
        if (title == "Settings") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SettingsScreen(),
            ),
          );
        }
      },
    );
  }
}

Future<void> showLogoutDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // User must tap a button
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Log out'),
        content: const Text('Are you sure you want to log out?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(); // Dismiss the dialog
            },
          ),
          TextButton(
            child: const Text('Log out'),
            onPressed: () async {
              Session.logout();
              Navigator.of(context).pop(); // Dismiss the dialog
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => SignInScreen(),
                ),
              );
            },
          ),
        ],
      );
    },
  );
}
