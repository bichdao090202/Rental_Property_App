import 'package:flutter/material.dart';
import 'package:rental_property_app/data/models/room.dart';
import 'package:rental_property_app/data/services/api_service.dart';

class RoomProvider with ChangeNotifier {
  final ApiService apiService;
  List<Room> rooms = [];
  bool isLoading = false;

  RoomProvider(this.apiService);

  Future<void> getListRooms() async {
    isLoading = true;
    notifyListeners();

    try {
      final responseData = await apiService.getListRoom();
      final List<dynamic> roomList = responseData['data'];
      // print(roomList);
      rooms = roomList.map((roomData) => Room.fromJson(roomData)).toList();

    } catch (error) {
      print('Error fetching data: $error');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
