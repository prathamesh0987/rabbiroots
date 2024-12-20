import 'package:flutter/material.dart';

class AccountDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Account Details',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile Section
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                    'https://s3-alpha-sig.figma.com/img/4eed/dea2/50b16a6f7edf69ea1cf19a2c703ed08d?Expires=1734912000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=oDK7YXd4KT3lW983wBE2sfdaMY1lKKN9og5T6hEZwh-hrAcSqNAkUpPiEYV5nIqit0P7qva1-r4vimS1QX-dXQrW5EcY6BK-JYT388wSGvEkPjINuTNW4KB6pyKQpnqwbN5WyLgjg5zIzLh~L~IWrgdPOq-PbTuQlwDLtIXnQsAgKgkB4iPBpz14GYH0gCHtZXCRQzWX9e-k8KTBKxG6QH-4Gyi-hs7rjnyCznDbTJDhwhq~ul9OoDW1W4pd~QXUfbA0a3oK13jfFSH-PSJFdYwT~q~xnO1K5SjtSqwblUm9I2Xt0pbfcEeK~Jht77~VQhpfaAX6MZ0N9ogC-HwbQg__',
                  ),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Amit',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.edit,
                          size: 16,
                          color: Colors.black54,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.check_box,
                          color: Colors.green,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Verified',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 24),

            // Details Section
            Divider(color: Colors.grey.shade300),
            _buildDetailItem(
              icon: Icons.email,
              text: 'amit123@gmail.com',
            ),
            Divider(color: Colors.grey.shade300),
            _buildDetailItem(
              icon: Icons.phone,
              text: '+91 8987456239',
            ),
            Divider(color: Colors.grey.shade300),
            _buildDetailItem(
              icon: Icons.location_on,
              text: 'Block No. 10 Kothrud Pune,\nMaharashtra 411038',
            ),
            Divider(color: Colors.grey.shade300),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem({required IconData icon, required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.green),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
