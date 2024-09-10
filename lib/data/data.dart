import 'package:rental_property_app/models/booking_request.dart';
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
);

final List<Property> properties = [
  Property(id: 1, title: "Cozy Apartment", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQRfuCW7HDB5lrA2NezJ12b7RnawDK3qPTlsg&s", ownerId: 1, address: address, utilities: [utilities[0], utilities[1]], price: 3000 ),
  Property(id: 2, title: "Spacious House", image: "https://lh6.googleusercontent.com/proxy/rVhmNBxYcdrU7epkQMzZ5MGx2fb8JLNXOIRV0Z_vevpPbMzBaZjk5427DStnjO_Y-Gu32zQio_GDzk1KCf3nfgH4evogftgUuChB_SPoLkTxcU7y49jLmNhJljfrR13MwoIwDcu6", ownerId: 1, address: address, utilities: [utilities[0], utilities[1]], price: 3000 ),
  Property(id: 3, title: "Modern Studio", image: "https://pt123.cdn.static123.com/images/thumbs/900x600/fit/2021/02/22/cho-thue-phong-tro_1613975723.jpg", ownerId: 2, address: address, utilities: [utilities[0], utilities[1]], price: 3000 ),
  Property(id: 4, title: "Charming Cottage", image: "https://pt123.cdn.static123.com/images/thumbs/900x600/fit/2023/02/11/c11a6917-a0ac-4de4-9135-1b4c1e166892_1676120670.jpg", ownerId: 2, address: address, utilities: [utilities[0], utilities[1]], price: 3000 ),
];

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
  BookingRequest(
    requestId: 8,
    renterId: 1,
    landlordId: 2,
    property: properties[3],
    requestDate: DateTime.parse('2024-08-22'),
    status: "Success",
    note: "Active",
    messageFromRenter: "Looking forward to moving into the charming cottage.",
    messageFromLandlord: "All set for the move-in date.",
    startDate: DateTime.parse('2024-09-15'),
    rentalDuration: 8,
    priceOffered: 1300,
    responseDate: DateTime.parse('2024-08-25'),
    contractId: 103,
  ),
  BookingRequest(
    requestId: 9,
    renterId: 2,
    landlordId: 1,
    property: properties[0],
    requestDate: DateTime.parse('2024-08-25'),
    status: "Processing",
    note: "Waiting for landlord approval",
    messageFromRenter: "Interested in renting the cozy apartment.",
    startDate: DateTime.parse('2024-10-01'),
    rentalDuration: 6,
    priceOffered: 1200,
  ),
  BookingRequest(
    requestId: 10,
    renterId: 2,
    landlordId: 1,
    property: properties[0],
    requestDate: DateTime.parse('2024-08-28'),
    status: "Failure",
    note: "Landlord rejected",
    messageFromRenter: "Request rejected by the landlord.",
    startDate: DateTime.parse('2024-10-15'),
    rentalDuration: 12,
    priceOffered: 1600,
  ),
];

final List<Property> popularProperties = [
  Property(
    id: 1,
    title: 'Căn hộ cho thuê giá rẻ',
    image: 'http://jhsdf',
    address: Address(
      id: 1,
      city: 'TP.HCM',
      district: 'Gò Vấp',
    ),
    utilities: [utilities[0], utilities[1]],
    price: 3000,
    ownerId: 1,
  ),
  // Add more sample properties as needed
];
