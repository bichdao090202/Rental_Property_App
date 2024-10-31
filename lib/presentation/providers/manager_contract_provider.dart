import 'package:flutter/material.dart';
import 'package:rental_property_app/data/models/booking_request.dart';
import 'package:rental_property_app/data/models/contract.dart';
import 'package:rental_property_app/data/services/api_service.dart';

class ManagerContractProvider with ChangeNotifier {
  final ApiService apiService;
  List<BookingRequest> bookingRequests = [];
  List<Contract> contracts = [];
  bool isLoading = false;

  ManagerContractProvider(this.apiService);

  Future<void> getListBookingRequestByRenterId(int id) async {
    isLoading = true;
    notifyListeners();
    try {
      final responseData = await apiService.getBookingRequestByRenterId(id);
      final List<dynamic> bookingRequestList = responseData['data'];
      // print(bookingRequestList);
      bookingRequests = bookingRequestList.map((roomData) => BookingRequest.fromJson(roomData)).toList();
    } catch (error) {
      print('Error fetching data: $error');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getListBookingRequestByLessorId(int id) async {
    isLoading = true;
    notifyListeners();
    try {
      final responseData = await apiService.getBookingRequestByLessorId(id);
      final List<dynamic> bookingRequestList = responseData['data'];
      bookingRequests = bookingRequestList.map((roomData) => BookingRequest.fromJson(roomData)).toList();
    } catch (error) {
      print('Error fetching data: $error');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getContractByRenterId(int id) async {
    isLoading = true;
    notifyListeners();
    try {
      final responseData = await apiService.getContractByRenterId(id);
      final List<dynamic> contractsList = responseData['data'];
      contracts = contractsList.map((contract) => Contract.fromJson(contract)).toList();
    } catch (error) {
      print('Error fetching data: $error');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }





}
