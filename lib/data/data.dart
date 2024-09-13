import 'package:rental_property_app/models/booking_request.dart';
import 'package:rental_property_app/models/property.dart';
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
    priceOffered: 1200,
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
    priceOffered: 1500,
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
    priceOffered: 1000,
    responseDate: DateTime.parse('2024-08-10'),
    contractId: 101,
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
    priceOffered: 800,
    responseDate: DateTime.parse('2024-06-10'),
    contractId: 102,
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
    priceOffered: 1100,
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
    priceOffered: 950,
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
    priceOffered: 1400,
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
    deposit: 3000,
    gender: 0,
    roomSize: 20,
    ownerId: 1,
    description: "Nhà rộng 10x20m, 3 phòng ngủ...",
    termOfService: termOfService1
  ),
  Property(
    id: 2,
    title: "Căn hộ cho thuê giá rẻ",
    type: "apartment",
    image: "https://lh6.googleusercontent.com/proxy/rVhmNBxYcdrU7epkQMzZ5MGx2fb8JLNXOIRV0Z_vevpPbMzBaZjk5427DStnjO_Y-Gu32zQio_GDzk1KCf3nfgH4evogftgUuChB_SPoLkTxcU7y49jLmNhJljfrR13MwoIwDcu6",
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
    deposit: 3000,
    gender: 0,
    roomSize: 20,
    ownerId: 1,
    description: "Nhà rộng 10x20m, 3 phòng ngủ...",
    termOfService: termOfService1
  ),
  Property(
      id: 2,
      title: "Căn hộ cho thuê giá rẻ",
      type: "apartment",
      image: "https://pt123.cdn.static123.com/images/thumbs/900x600/fit/2021/02/22/cho-thue-phong-tro_1613975723.jpg",
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
      deposit: 3000,
      gender: 0,
      roomSize: 20,
      ownerId: 1,
      description: "Nhà rộng 10x20m, 3 phòng ngủ...",
      termOfService: termOfService1
  ),
  Property(
      id: 2,
      title: "Căn hộ cho thuê giá rẻ",
      type: "apartment",
      image: "https://pt123.cdn.static123.com/images/thumbs/900x600/fit/2023/02/11/c11a6917-a0ac-4de4-9135-1b4c1e166892_1676120670.jpg",
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
      deposit: 3000,
      gender: 0,
      roomSize: 20,
      ownerId: 1,
      description: "Nhà rộng 10x20m, 3 phòng ngủ...",
      termOfService: termOfService1
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


