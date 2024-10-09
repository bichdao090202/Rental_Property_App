import 'package:rental_property_app/models/booking_request.dart';
import 'package:rental_property_app/models/chargeable_service.dart';
import 'package:rental_property_app/models/contract.dart';
import 'package:rental_property_app/models/property.dart';
import 'package:rental_property_app/models/user.dart';
import '../models/address.dart';
import '../models/utility.dart';
import '../models/property.dart';

// Sample data
final List<User> users = [
  User(id: 1, name: "John Doe"),
  User(id: 2, name: "Jane Smith"),
];

List<ChargeableService> chargeableServices = [
  ChargeableService(
    serviceName: 'Điện',
    quantity: 1,
    unitPrice: 4000,
    unitOfMeasurement: "kWh"
  ),
  ChargeableService(
    serviceName: 'Nước',
    quantity: 1,
    unitPrice: 15000,
      unitOfMeasurement: "m3"
  ),
  ChargeableService(
    serviceName: 'Xe',
    quantity: 1,
    unitPrice: 100000,
      unitOfMeasurement: "chiếc"
  ),
];

final List<Utility> utilities = [
  Utility(id: 1, name: 'WiFi'),
  Utility(id: 2, name: 'Air Conditioner'),
  Utility(id: 3, name: 'Washing Machine'),
  Utility(id: 4, name: 'Parking'),
];

final Address address = Address(
    id: 1,
    city: 'TP.HCM',
    district: 'Gò Vấp',
    ward: "phường 4",
    detail: "109"
);



final List<BookingRequest> bookingRequests = [
  BookingRequest(
    requestId: 1,
    renterId: 1,
    landlordId: 2,
    property: properties[2],
    requestDate: DateTime.parse('2024-08-01'),
    status: "Processing",
    note: "Waiting for landlord approval",
    messageFromRenter: "Interested in renting this cozy apartment.",
    startDate: DateTime.parse('2024-08-15'),
    rentalDuration: 6,
    contractId: 1
  ),
  BookingRequest(
    requestId: 2,
    renterId: 1,
    landlordId: 2,
    property: properties[2],
    requestDate: DateTime.parse('2024-08-02'),
    status: "Processing",
    note: "Waiting for renter to sign and pay",
    messageFromRenter: "Ready to sign the lease for the spacious house.",
    startDate: DateTime.parse('2024-08-20'),
    rentalDuration: 12,
    contractId: 3
  ),
  BookingRequest(
    requestId: 3,
    renterId: 2,
    landlordId: 1,
    property: properties[1],
    requestDate: DateTime.parse('2024-08-05'),
    status: "Success",
    note: "Active",
    messageFromRenter: "Excited to move into the modern studio.",
    messageFromLandlord: "Contract signed and payment received.",
    startDate: DateTime.parse('2024-09-01'),
    rentalDuration: 9,
    responseDate: DateTime.parse('2024-08-10'),
    contractId: 1,

  ),
  BookingRequest(
    requestId: 4,
    renterId: 2,
    landlordId: 1,
    property: properties[1],
    requestDate: DateTime.parse('2024-08-10'),
    status: "Success",
    note: "Expired",
    messageFromRenter: "I enjoyed the stay but the lease has ended.",
    startDate: DateTime.parse('2024-06-01'),
    rentalDuration: 3,
    responseDate: DateTime.parse('2024-06-10'),
    contractId: 1,
  ),
  BookingRequest(
    requestId: 5,
    renterId: 1,
    landlordId: 2,
    property: properties[3],
    requestDate: DateTime.parse('2024-08-12'),
    status: "Failure",
    note: "Landlord rejected",
    messageFromRenter: "Please reconsider my application.",
    startDate: DateTime.parse('2024-09-01'),
    rentalDuration: 4,
    contractId: 2
  ),
  BookingRequest(
    requestId: 6,
    renterId: 2,
    landlordId: 2,
    property: properties[3],
    requestDate: DateTime.parse('2024-08-15'),
    status: "Failure",
    note: "Renter canceled",
    messageFromRenter: "I've decided to cancel the booking.",
    startDate: DateTime.parse('2024-09-15'),
    rentalDuration: 3,
    contractId: 2
  ),
  BookingRequest(
    requestId: 7,
    renterId: 1,
    landlordId: 2,
    property: properties[3],
    requestDate: DateTime.parse('2024-08-20'),
    status: "Processing",
    note: "Waiting for renter to sign and pay",
    messageFromRenter: "I'm ready to proceed with the lease.",
    startDate: DateTime.parse('2024-10-01'),
    rentalDuration: 6,
    contractId: 3
  ),

];

final List<String> services = ['Internet', 'Bảo vệ', 'Camera', 'Bãi đỗ xe', 'Thang máy'];

// Mô phỏng loại phòng
final List<String> roomTypes = ['Căn hộ', 'Nhà riêng', 'Phòng trọ', 'Studio', 'Biệt thự'];

List<Property> properties = [
  Property(
    id: 1,
    title: "Căn hộ cho thuê giá rẻ",
    type: "apartment",
    image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQRfuCW7HDB5lrA2NezJ12b7RnawDK3qPTlsg&s",
      address: Address(
          id: 1,
          city: 'TP.HCM',
          district: 'Gò Vấp',
          ward: "phường 4",
          detail: "109"
      ),
    utilities: [
      Utility(id: 1, name: "tủ lạnh"),
      Utility(id: 2, name: "máy giặc"),
    ],
    price: 3000000,
    deposit: 3000000,
    gender: 0,
    roomSize: 20,
    ownerId: 1,
    description: "Nhà rộng 10x20m, 3 phòng ngủ...",
    termOfService: termOfService1,
    chargeableServices: chargeableServices
  ),
  Property(
    id: 2,
    title: "Căn hộ cho thuê giá rẻ",
    type: "apartment",
    image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQRfuCW7HDB5lrA2NezJ12b7RnawDK3qPTlsg&s",
      address: Address(
          id: 1,
          city: 'TP.HCM',
          district: 'Bình Thạnh',
          ward: "phường 12",
          detail: "77A"
      ),

    utilities: [
      Utility(id: 1, name: "tủ lạnh"),
      Utility(id: 2, name: "máy giặc"),
    ],
    price: 4000000,
    deposit: 5000000,
    gender: 0,
    roomSize: 20,
    ownerId: 1,
    description: "Nhà rộng 10x20m, 3 phòng ngủ...",
    termOfService: termOfService1,
      chargeableServices: chargeableServices
  ),
  Property(
      id: 3,
      title: "Kí túc xá",
      type: "apartment",
      image: "https://pt123.cdn.static123.com/images/thumbs/900x600/fit/2021/02/22/cho-thue-phong-tro_1613975723.jpg",
      address: Address(
          id: 1,
          city: 'TP.HCM',
          district: 'Phú Nhuận',
          ward: "phường 7",
          detail: "12"
      ),

      utilities: [
        Utility(id: 1, name: "tủ lạnh"),
        Utility(id: 2, name: "máy giặc"),
      ],
      price: 1500000,
      deposit: 1500000,
      gender: 0,
      roomSize: 20,
      ownerId: 1,
      description: "Nhà rộng 10x20m, 3 phòng ngủ...",
      termOfService: termOfService1,
      chargeableServices: chargeableServices
  ),
  Property(
      id: 4,
      title: "Căn hộ cho thuê giá rẻ",
      type: "apartment",
      image: "https://pt123.cdn.static123.com/images/thumbs/900x600/fit/2023/02/11/c11a6917-a0ac-4de4-9135-1b4c1e166892_1676120670.jpg",
      address: Address(
          id: 1,
          city: 'TP.HCM',
          district: 'Thủ Đức',
          ward: "phường Linh Trung",
          detail: "109 Kha Vạn Cân"
      ),

      utilities: [
        Utility(id: 1, name: "tủ lạnh"),
        Utility(id: 2, name: "máy giặc"),
      ],
      price: 3000000,
      deposit: 3000000,
      gender: 0,
      roomSize: 20,
      ownerId: 1,
      description: "Nhà rộng 10x20m, 3 phòng ngủ...",
      termOfService: termOfService1,
      chargeableServices: chargeableServices
  ),
];

String termOfService1 = '''
1. Các tài sản cho thuê kèm theo:
- Tủ lạnh
- Máy giặt

2. Tiền thuê và thời hạn thuê
- Thuê 3 tháng: 1 800 000 VND/tháng
- Thuê 6 tháng: 1 700 000 VND/tháng

Tiền thuê nhà không bao gồm chi phí khác như tiền điện, nước, vệ sinh... Khoản tiền này sẽ do người thuê trả theo khối lượng, công suất sử dụng thực tế hàng tháng, được tính theo đơn giá của nhà nước.

3. Tiền cọc thuê nhà
Tiền cọc bằng tiền thuê 1 tháng.

4. Đơn phương chấm dứt hợp đồng thuê nhà:
Trong trường hợp một trong hai bên muốn đơn phương chấm dứt Hợp đồng trước hạn thì phải thông báo bằng văn bản cho bên kia trước 30 (ba mươi) ngày so với ngày mong muốn chấm dứt. Nếu một trong hai bên không thực hiện nghĩa vụ thông báo cho bên kia thì sẽ phải bồi thường cho bên đó một khoản tiền thuê tương đương với thời gian không thông báo và các thiệt hại khác phát sinh do việc chấm dứt hợp đồng trái quy định.

5. Phương thức thanh toán
Việc thanh toán tiền thuê nhà được thực hiện bằng đồng tiền Việt Nam theo hình thức trả trực tiếp bằng tiền mặt.
''';


List<Contract> contracts = [
  Contract(
      id: 1,
      name: "Hợp đồng A - 3 tháng",
      content: '''
HỢP ĐỒNG THUÊ PHÒNG TRỌ

1. Bên cho thuê: Nguyễn Văn A
2. Bên thuê: Trần Văn B

Điều 1: Đối tượng hợp đồng
- Bên cho thuê đồng ý cho bên thuê thuê phòng trọ tại địa chỉ: 123 Đường ABC, Quận 1, TP.HCM
- Thời hạn thuê: 3 tháng, từ ngày 01/09/2024 đến ngày 01/12/2024

Điều 2: Tiền thuê và tiền cọc
- Tiền thuê phòng: 2.000.000 VND/tháng
- Tiền cọc: 1 tháng tiền thuê (2.000.000 VND), thanh toán ngay khi ký hợp đồng.

Điều 3: Quyền và nghĩa vụ của hai bên
- Bên thuê có quyền sử dụng phòng và các tiện ích đi kèm: điện, nước, internet.
- Bên thuê phải thanh toán tiền thuê đúng hạn và tuân thủ quy định chung của khu nhà.

Điều 4: Đơn phương chấm dứt hợp đồng
- Mỗi bên phải thông báo trước 30 ngày nếu muốn chấm dứt hợp đồng sớm.
- Nếu không tuân thủ, bên vi phạm sẽ bồi thường tiền thuê phòng trong khoảng thời gian không thông báo.

Điều 5: Điều khoản khác
- Hợp đồng này có hiệu lực từ ngày ký và được lập thành 2 bản, mỗi bên giữ 1 bản.
    ''',
    landlordId: 1,
    pdfPath: 'assets/hop-dong-thue.pdf',
  ),
  Contract(
      id: 2,
      name: "Hợp đồng B - 9 tháng",
      content: '''
HỢP ĐỒNG THUÊ PHÒNG TRỌ

1. Bên cho thuê: Nguyễn Văn A
2. Bên thuê: Trần Văn C

Điều 1: Đối tượng hợp đồng
- Bên cho thuê đồng ý cho bên thuê thuê phòng trọ tại địa chỉ: 456 Đường DEF, Quận 3, TP.HCM
- Thời hạn thuê: 6 tháng, từ ngày 01/09/2024 đến ngày 01/03/2025

Điều 2: Tiền thuê và tiền cọc
- Tiền thuê phòng: 1.800.000 VND/tháng
- Tiền cọc: 1 tháng tiền thuê (1.800.000 VND), thanh toán ngay khi ký hợp đồng.

Điều 3: Quyền và nghĩa vụ của hai bên
- Bên thuê được quyền sử dụng phòng và các tiện ích như: tủ lạnh, máy giặt, điều hòa.
- Bên thuê phải bảo quản tài sản và chịu trách nhiệm nếu xảy ra hư hỏng.

Điều 4: Đơn phương chấm dứt hợp đồng
- Bên thuê hoặc bên cho thuê có quyền đơn phương chấm dứt hợp đồng nếu không thực hiện đúng nghĩa vụ.

Điều 5: Điều khoản khác
- Hợp đồng có hiệu lực từ ngày ký và được lập thành 2 bản, mỗi bên giữ 1 bản.
    ''',
      landlordId: 1,
      pdfPath: 'assets/hop-dong-thue-nha-o_2810144434_2011152916_0804150405.pdf',
  ),
  Contract(
      id: 3,
      name: "Hợp đồng 19/8 - 12 tháng",
      content: '''
HỢP ĐỒNG THUÊ PHÒNG TRỌ

1. Bên cho thuê: Nguyễn Văn A
2. Bên thuê: Trần Thị D

Điều 1: Đối tượng hợp đồng
- Bên cho thuê cho bên thuê thuê căn phòng tại địa chỉ: 789 Đường XYZ, Quận 7, TP.HCM
- Thời hạn thuê: 12 tháng, từ ngày 01/09/2024 đến ngày 01/09/2025

Điều 2: Tiền thuê và tiền cọc
- Tiền thuê phòng: 1.500.000 VND/tháng
- Tiền cọc: 1 tháng tiền thuê (1.500.000 VND), thanh toán khi ký hợp đồng.

Điều 3: Quyền và nghĩa vụ của hai bên
- Bên thuê được sử dụng các tiện ích như: điện, nước, wifi, bếp chung.
- Bên thuê phải giữ gìn vệ sinh và an ninh chung.

Điều 4: Đơn phương chấm dứt hợp đồng
- Mỗi bên phải thông báo bằng văn bản trước 30 ngày nếu muốn chấm dứt hợp đồng.

Điều 5: Điều khoản khác
- Hợp đồng này có giá trị từ ngày ký và được lập thành 2 bản, mỗi bên giữ 1 bản.
    ''',
    landlordId: 1,
    pdfPath: 'assets/hop-dong-thue-nha-o_2810144434_2011152916_0804150405 (1).pdf',
    // renterId: 2,
    // property: properties[3],
    // dateComplete: DateTime.now(),
    // datePay: DateTime.now(),
    // startRentDate: DateTime(2024, 9, 1),
    // rentalDuration: 12,

  ),

];

void updateContractById(int contractId, BookingRequest request) {
  final index = contracts.indexWhere((contract) => contract.id == contractId);
  if (index != -1) {
    contracts[index].completeContract(request);
  } else {
    print("Contract not found");
  }
}

void addContract(Contract newContract) {
  contracts.add(newContract);
}

Contract getContractById(int id) {
  return contracts.firstWhere(
        (contract) => contract.id == id,
    orElse: () =>
        Contract(id: -1, name: 'Không tìm thấy', content: 'Nội dung hợp đồng không tìm thấy', landlordId: 0,pdfPath: 'assets/hop-dong-thue-nha-o_2810144434_2011152916_0804150405.pdf',));
}

const String platformRules = '''
Chào mừng bạn đến với nền tảng của chúng tôi! Dưới đây là các quy định mà bạn cần tuân thủ:

1. Đăng ký và Tài khoản:
Bạn phải cung cấp thông tin chính xác và đầy đủ khi đăng ký tài khoản. Bạn chịu trách nhiệm về mọi hoạt động xảy ra dưới tài khoản của bạn.

2. Bảo mật và An toàn:
Bạn không được chia sẻ thông tin tài khoản của bạn với bất kỳ ai. Nếu bạn nghi ngờ tài khoản của mình đã bị xâm phạm, hãy thông báo ngay cho chúng tôi.

3. Nội dung và Hành vi:
Bạn không được đăng tải hoặc chia sẻ bất kỳ nội dung nào vi phạm luật pháp, chứa thông tin sai lệch, hoặc mang tính xúc phạm, phân biệt đối xử, hoặc khiêu dâm.

4. Quyền và Trách nhiệm:
Chúng tôi có quyền sửa đổi, tạm ngừng hoặc chấm dứt dịch vụ nếu bạn vi phạm các quy định. Chúng tôi không chịu trách nhiệm cho bất kỳ thiệt hại nào phát sinh từ việc bạn không tuân thủ quy định.

5. Thay đổi Quy định:
Chúng tôi có quyền thay đổi các quy định này bất cứ lúc nào. Các thay đổi sẽ có hiệu lực khi được công bố trên nền tảng của chúng tôi.

Cảm ơn bạn đã tuân thủ các quy định này và hợp tác cùng chúng tôi để tạo ra một môi trường an toàn và thân thiện!
''';


