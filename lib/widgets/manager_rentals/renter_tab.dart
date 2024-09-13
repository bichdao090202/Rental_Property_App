import 'package:flutter/material.dart';
import 'package:rental_property_app/data/data.dart';
import 'package:rental_property_app/widgets/manager_rentals/booking_request_card_from_renter.dart';

class RenterTab extends StatefulWidget {
  @override
  _RenterTabState createState() => _RenterTabState();

}

class _RenterTabState extends State<RenterTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          children: [
            Container(
                width: double.maxFinite,
                child:
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: bookingRequests.length,
                    itemBuilder: (context, index) {
                      final request = bookingRequests[index];
                      return BookingRequestCardFromRenter(request: request);
                    }
                )
            )
          ],
        )
    );
          // Text('Combo box: Chấp nhận, từ chối, đang chờ'),
          // Text('Danh sách các yêu cầu thuê'),
  }
}