import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Who We Are',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Welcome to Fixit, a leading provider of on-demand home services in Kerala, India. Our mission is to connect homeowners with reliable, skilled professionals for all their service needs. We are dedicated to ensuring that every service request is handled with the utmost care and professionalism, providing peace of mind to our customers.',
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Our Story',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Founded with a vision to simplify home maintenance, Fixit was established to address the growing need for reliable and accessible home services. Our team brings together a wealth of experience in the service industry, with a commitment to delivering high-quality solutions for every household. From plumbing and electrical work to cleaning and repairs, we aim to make home management effortless.',
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Our Values',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildValueItem('Quality',
                    'We are committed to providing top-notch services with the highest standards of quality.'),
                _buildValueItem('Reliability',
                    'Our professionals are vetted and trained to ensure that every job is completed efficiently and effectively.'),
                _buildValueItem('Customer Satisfaction',
                    'Your satisfaction is our priority. We strive to exceed your expectations with every service.'),
                _buildValueItem('Innovation',
                    'We continuously seek to improve and innovate our service offerings to better meet your needs.'),
              ],
            ),
            const SizedBox(height: 16.0),
            const Text(
              'What We Do',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildServiceItem('Plumbing',
                    'From fixing leaks to installing new fixtures, our skilled plumbers are here to help.'),
                _buildServiceItem('Electrical Work',
                    'Safe and reliable electrical services, including repairs, installations, and inspections.'),
                _buildServiceItem('Cleaning Services',
                    'Comprehensive cleaning solutions to keep your home spotless and fresh.'),
                _buildServiceItem('Repairs and Maintenance',
                    'General home repairs and maintenance to ensure your home stays in top shape.'),
              ],
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Our Team',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Our team consists of dedicated professionals who are passionate about delivering excellent service. Each member is carefully selected for their expertise and commitment to customer satisfaction. We work together to ensure that every service request is handled with the highest level of professionalism and care.',
              // style: Theme.of(context).textTheme.bodyText1,
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Contact Us',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 8.0),
            _buildContactInfo('Email', 'support@fixit.com'),
            _buildContactInfo('Phone', '+91-123-456-7890'),
            _buildContactInfo('Address',
                'Fixit, Main Street, Kannur, Kerala, India, PIN: 670706'),
          ],
        ),
      ),
    );
  }

  Widget _buildValueItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: <Widget>[
          const Icon(Icons.check_circle, color: Colors.green),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              '$title: $description',
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: <Widget>[
          const Icon(Icons.build, color: Colors.blueAccent),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              '$title: $description',
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Icon(Icons.contact_mail, color: Colors.blueAccent),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              '$label: $value',
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }
}
