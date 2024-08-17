import 'package:fixit_provider/common/widgets/round_button.dart';
import 'package:flutter/material.dart';

class BookingCard extends StatelessWidget {
  final String service;
  final double amount;
  final String bookingDate;
  final String bookedOn;
  final VoidCallback onButtonPressed;

  const BookingCard({
    super.key,
    required this.service,
    required this.amount,
    required this.bookingDate,
    required this.bookedOn,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final isSmallScreen = width < 600;
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: EdgeInsets.all(isSmallScreen ? 16.0 : 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Icon(Icons.plumbing, size: isSmallScreen ? 24 : 32),
                      const SizedBox(width: 8),
                      Text(
                        service,
                        style: TextStyle(
                          fontSize: isSmallScreen ? 18 : 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: isSmallScreen ? 12 : 16),
                  _buildInfoRow(
                      'Amount per hour', '₹${amount.toStringAsFixed(2)}'),
                  SizedBox(height: 8),
                  _buildInfoRow('Booking date', bookingDate),
                  SizedBox(height: 8),
                  _buildInfoRow('Booking Requested', bookedOn, isBlue: true),
                  SizedBox(height: isSmallScreen ? 16 : 24),
                  SizedBox(
                      width: double.infinity,
                      child: RoundButton(
                          title: 'View Details', onPressed: onButtonPressed)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isBlue = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: Colors.grey[600])),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isBlue ? Colors.blue : null,
          ),
        ),
      ],
    );
  }
}
