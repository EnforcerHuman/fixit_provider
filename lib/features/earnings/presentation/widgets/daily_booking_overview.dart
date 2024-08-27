import 'package:fixit_provider/common/color_extension.dart';
import 'package:fixit_provider/features/earnings/data/models/day_booking.dart';
import 'package:flutter/material.dart';

class DailyBookingOverview extends StatelessWidget {
  final DailyBooking bookings;

  const DailyBookingOverview({
    super.key,
    required this.bookings,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Tcolor.gray.withOpacity(0.2),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                const SizedBox(height: 16),
                Expanded(
                  child: _buildBookingsList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
                child: _buildInfoBox('Total Earnings', '\$${bookings.amount}')),
            const SizedBox(width: 16),
            Expanded(
                child: _buildInfoBox(
                    'Total Bookings', '${bookings.totalBooking}')),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoBox(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Tcolor.gray.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Tcolor.primaryColor1.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Tcolor.primaryColor1.withOpacity(0.7),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              color: Tcolor.primaryColor1,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bookings',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Tcolor.primaryColor1,
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: bookings.bookingsofDay.isEmpty
              ? const Center(
                  child: Text('NO BOOKINGS'),
                )
              : ListView.builder(
                  itemCount: bookings.bookingsofDay.length,
                  itemBuilder: (context, index) {
                    final booking = bookings.bookingsofDay[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        leading: CircleAvatar(
                          backgroundColor:
                              Tcolor.primaryColor1.withOpacity(0.1),
                          child: Icon(Icons.event, color: Tcolor.primaryColor1),
                        ),
                        title: Text(
                          'Booking #${booking.id}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(booking.serviceName),
                        trailing: Text(
                          '₹${booking.totalPayment}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Tcolor.primaryColor1,
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
