import 'package:flutter/material.dart';
import 'package:rental_property_app/common/get-status.dart';
import 'package:rental_property_app/data/models/contract.dart';
import 'package:rental_property_app/data/services/api_service.dart';

class CancelContractModal extends StatelessWidget {
  final Function() onClose;
  final Contract contract;
  final String type;
  final int userId;

  const CancelContractModal({
    Key? key,
    required this.onClose,
    required this.contract,
    required this.type,
    required this.userId,
  }) : super(key: key);


  Widget _buildNotificationText() {
    switch (type) {
      case "cancel":
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "• Yêu cầu của bạn sẽ được gửi đến đối tác để họ xem xét và phản hồi.",
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 8),
            Text(
              "• Xin lưu ý rằng nếu việc hủy bỏ không được sự đồng ý của cả hai bên, bạn sẽ mất khoản tiền đặt cọc đã thanh toán khi ký hợp đồng cho đối tác để bồi thường.",
              style: TextStyle(fontSize: 14),
            ),
          ],
        );
      case "confirm":
        return Text(
          "Đối tác không đồng ý yêu cầu hủy của bạn, vẫn hủy? Xin lưu ý rằng, bạn sẽ mất khoản tiền đặt cọc đã thanh toán khi ký hợp đồng cho đối tác để bồi thường.",
          style: TextStyle(fontSize: 14),
        );
      case "handle":
        return Text(
          "Bạn vừa nhận được yêu cầu hủy hợp đồng thuê nhà từ phía đối tác. "
              "Xin lưu ý rằng nếu bạn đồng ý hủy hợp đồng, toàn bộ quá trình sẽ kết thúc mà không ảnh hưởng đến khoản tiền đặt cọc. "
              "Tuy nhiên, nếu bạn không đồng ý, đối tác sẽ mất khoản tiền đặt cọc đã thanh toán khi ký hợp đồng để bồi thường cho bạn.",
          style: TextStyle(fontSize: 14),
        );
      default:
        return SizedBox.shrink();
    }
  }

  Widget _buildActionButtons() {
    switch (type) {
      case "cancel":
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              onPressed: () async {
                final body = {
                  ...contract.toJson(),
                  'canceled_by': userId,
                  'cancel_status': 1,
                  'renter_id': contract.renter.id,
                  'lessor_id': contract.lessor.id,
                  'room_id': contract.room!.id,
                };
                await ApiService().updateContract(body, contract.id);
                onClose();
              },
              child: Text('Xác nhận', style: TextStyle(color: Colors.white)),
            ),
            SizedBox(width: 12),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              onPressed: onClose,
              child: Text('Bỏ'),
            ),
          ],
        );
      case "confirm":
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              onPressed: () async {
                final body = {
                  ...contract.toJson(),
                  'cancel_status': 4,
                  'status': 5,
                  'renter_id': contract.renter.id,
                  'lessor_id': contract.lessor.id,
                  'room_id': contract.room!.id,
                  'canceled_by': contract.canceledBy!.id,
                };
                await ApiService().updateContract(body, contract.id);
                // Implement createTransaction here
                onClose();
              },
              child: Text('Đồng ý', style: TextStyle(color: Colors.white)),
            ),
            SizedBox(width: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              onPressed: () async {
                final body = {
                  ...contract.toJson(),
                  'pay_mode': 0,
                  'canceled_by': null,
                  'renter_id': contract.renter.id,
                  'lessor_id': contract.lessor.id,
                  'room_id': contract.room!.id,
                };
                await ApiService().updateContract(body, contract.id);
                onClose();
              },
              child: Text('Không hủy nữa', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      case "handle":
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              onPressed: () async {
                final body = {
                  ...contract.toJson(),
                  'pay_mode': 4,
                  'status': 6,
                  'renter_id': contract.renter.id,
                  'lessor_id': contract.lessor.id,
                  'room_id': contract.room!.id,
                  'canceled_by': contract.canceledBy!.id,
                };
                await ApiService().updateContract(body, contract.id);
                // Implement createTransaction here
                onClose();
              },
              child: Text('Đồng ý', style: TextStyle(color: Colors.white)),
            ),
            SizedBox(width: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              onPressed: () async {
                final body = {
                  ...contract.toJson(),
                  'pay_mode': 2,
                  'renter_id': contract.renter.id,
                  'lessor_id': contract.lessor.id,
                  'room_id': contract.room!.id,
                  'canceled_by': contract.canceledBy!.id,
                };
                await ApiService().updateContract(body, contract.id);
                onClose();
              },
              child: Text('Không đồng ý', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      default:
        return SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Xác nhận hủy hợp đồng',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: onClose,
                  ),
                ],
              ),
              Divider(height: 24),
              Text(
                'Thông tin hợp đồng:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),
              _buildContractInfo(),
              Divider(height: 24),
              Text(
                'Thông báo:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),
              _buildNotificationText(),
              SizedBox(height: 24),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContractInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow('Mã hợp đồng (ID)', contract.id.toString()),
        _buildInfoRow('Trạng thái', getContractStatus(contract.status)),
        _buildInfoRow('Tiền cọc', '${contract.room!.deposit} VNĐ'),
        _buildInfoRow(
          'Đang chờ hủy',
          contract.canceledBy == null
              ? 'Không'
              : contract.canceledBy!.id == contract.renter.id
              ? 'Người thuê'
              : 'Chủ trọ',
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}