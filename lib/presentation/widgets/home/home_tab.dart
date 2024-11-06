import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rental_property_app/data/data.dart';
import 'package:rental_property_app/presentation/providers/room_provider.dart';
import 'package:rental_property_app/presentation/widgets/card/room_card.dart';
import 'package:rental_property_app/presentation/widgets/room_detail/room_detail_screen.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<Offset>? _animation;

  String? selectedService;
  String? selectedRoomType;
  String? selectedGender;
  String minPrice = '';
  String maxPrice = '';
  String address = '';
  List<String> selectedServices = [];
  List<String> services = ['Dịch vụ 1', 'Dịch vụ 2', 'Dịch vụ 3'];

  void _toggleService(String service) {
    setState(() {
      if (selectedServices.contains(service)) {
        selectedServices.remove(service);
      } else {
        selectedServices.add(service);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<Offset>(
      begin: const Offset(1.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeInOut,
    ));
    // contracts[1].completeContract(bookingRequests[2]);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RoomProvider>(context, listen: false).getListRooms();
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final roomProvider = Provider.of<RoomProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              const Text('Phổ biến', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              // ListView.builder(
              //   shrinkWrap: true,
              //   itemCount: properties.length,
              //   itemBuilder: (context, index) {
              //     final property = properties[index];
              //     return RoomCard(
              //       property: property,
              //       onTap: () {
              //         Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //             builder: (context) => RoomDetailScreen(property: property),
              //           ),
              //         );
              //       },
              //     );
              //   },
              // )
              roomProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                shrinkWrap: true,
                itemCount: roomProvider.rooms.length,
                itemBuilder: (context, index) {
                  final room = roomProvider.rooms[index];
                  return RoomCard(
                    property: room,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RoomDetailScreen(property: room),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}