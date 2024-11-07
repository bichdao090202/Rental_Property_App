import 'package:flutter/material.dart';
import 'package:rental_property_app/data/models/booking_request.dart';
import 'package:rental_property_app/data/services/api_service.dart';
import 'package:rental_property_app/presentation/widgets/card/booking_request_card.dart';
class BookingRequestsTab extends StatelessWidget {
  final int userId;
  final String type;

  const BookingRequestsTab({super.key, required this.userId, required this.type});

  Future<List<BookingRequest>> _fetchBookingRequests() async {
    final responseData;
    if (type == "renter") {
      responseData = await ApiService().getBookingRequestByRenterId(userId);
    } else {
      responseData = await ApiService().getBookingRequestByLessorId(userId);
    }
    final List<dynamic> bookingRequestList = responseData['data'] ?? [];
    List<BookingRequest> list = bookingRequestList.map((roomData) => BookingRequest.fromJson(roomData)).toList();
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BookingRequest>>(
      future: _fetchBookingRequests(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Không có yêu cầu thuê nào'));
        }

        if (snapshot.data!.isEmpty) {
          return const Center(child: Text('Không có yêu cầu thuê nào'));
        }

        return ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            final bookingRequest = snapshot.data![index];
            return BookingRequestCard(
              request: bookingRequest,
              type: type,
              userId: userId,
            );
          },
        );
      },
    );
  }
}