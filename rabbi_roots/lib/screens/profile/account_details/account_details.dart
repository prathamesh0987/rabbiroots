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
                    'https://s3-alpha-sig.figma.com/img/4eed/dea2/50b16a6f7edf69ea1cf19a2c703ed08d?Expires=1736121600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=oda-2Ww5yNZa-AF2ys1fcHgEyvA--adJUq~NWttbbj9SJffd8BcqSfcUETwZH-PKlZ2EmnUxfRhV-GQynMmIKy9rFX3pgY3Zh8xnEAVUJOuMl0xGCB5Xu8pcHCvvpSQdv2DBVOHe0-Nm~bEnS8UmWQz5dtiT4PWHXSTAwG2YKm-SV5DtPoSBnbkDTacXZMhs9scY-XW7y5gFjV-jXsIVsNlvppxNNOOPIy4F~QoqUN7-mtd0bV0e0lTm9q6l9WCV~caN0UQAjr-UF-PSFxh97EyVrsm5LmpViTp6SWDbGYjMv20W10NYxiZ~seIi9iTpGVQ0fEzU17UaWBtRdINc5w__',
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
