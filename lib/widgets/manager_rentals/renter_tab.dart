import 'package:flutter/material.dart';
import 'package:rental_property_app/data/data.dart';

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
                      return ListTile(
                        onTap: (){
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context)
                              {
                                return Container(
                                  padding: EdgeInsets.all(16),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      const Text(
                                        'Chi tiết yêu cầu đặt phòng',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 16),
                                      Text('Request ID: ${request.requestId}'),
                                      Text('Trạng thái: ${request
                                          .getStatusString()}'),
                                      Text('Ghi chú: ${request
                                          .getNoteString()}'),
                                      Text('Ngày yêu cầu: ${request
                                          .requestDate}'),
                                      Text('Ngày bắt đầu: ${request
                                          .startDate}'),
                                      Text('Thời gian thuê: ${request
                                          .rentalDuration} tháng'),
                                      Text('Giá đề xuất: ${request
                                          .priceOffered} 000 vnd'),
                                      Text('Tin nhắn từ khách hàng: ${request
                                          .messageFromRenter}'),
                                      Text('Tin nhắn từ chủ trọ: ${request
                                          .messageFromLandlord ?? "Chưa có"}'),
                                    ],
                                  ),
                                );
                              }
                              );
                        },
                        isThreeLine: true,
                        leading: Image.network(request.property.image, width: 70,),
                        title: Text('Request ID: ${request.requestId} '),
                        subtitle: Text(
                          'Trạng thái: ${request.getStatusString()}\n',
                          style: TextStyle(fontSize: 12),
                        ),
                        trailing:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (request.note == "Waiting for renter to sign and pay")
                              ElevatedButton(
                                onPressed: () {
                                  print('Button for renter to sign and pay clicked');
                                },
                                child: const Text(
                                  'Thanh toán',
                                  style: TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                          ],
                        )
                      );
                    }
                )
            )
          ],
        )
    );
          // Text('Renter Tab'),
          // Text('Combo box: Chấp nhận, từ chối, đang chờ'),
          // Text('Danh sách các yêu cầu thuê'),
          // Text('Status: Đang chờ chủ trọ đồng ý, Đang chờ khách hàng ký và thanh toán, Đang có hiệu lực, Hết hạn, Chủ nhà từ chối, Khách hàng hủy'),
  }
}