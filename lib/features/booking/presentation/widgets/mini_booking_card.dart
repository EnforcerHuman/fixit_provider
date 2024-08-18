import 'package:flutter/material.dart';

class MiniBookingCard extends StatelessWidget {
  final String service;
  final double amount;
  final String bookingDate;
  final String bookedOn;
  final Color cardColor;
  final IconData serviceIcon;

  const MiniBookingCard({
    super.key,
    required this.service,
    required this.amount,
    required this.bookingDate,
    required this.bookedOn,
    this.cardColor = Colors.blue,
    this.serviceIcon = Icons.cleaning_services,
  });

  @override
  Widget build(BuildContext context) {
    //screeen Dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // card width as a percentage of screen width for responsiveness
    final cardWidth = screenWidth * 0.90;
    final cardHeight = screenHeight * 0.25;

    return Container(
      width: cardWidth,
      height: cardHeight,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [cardColor, cardColor.withOpacity(0.7)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: cardColor.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(cardWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(serviceIcon, color: Colors.white, size: cardWidth * 0.1),
                Text(
                  '\₹${amount.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: cardWidth * 0.05,
                  ),
                ),
              ],
            ),
            SizedBox(height: cardHeight * 0.05),
            Text(
              service,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: cardWidth * 0.06,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: cardHeight * 0.02),
            Text(
              'Date: $bookingDate',
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: cardWidth * 0.04,
              ),
            ),
            SizedBox(height: cardHeight * 0.03),
            Row(
              children: [
                Icon(Icons.access_time,
                    color: Colors.white, size: cardWidth * 0.05),
                SizedBox(width: cardWidth * 0.02),
                Text(
                  'Created $bookedOn',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: cardWidth * 0.04,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
