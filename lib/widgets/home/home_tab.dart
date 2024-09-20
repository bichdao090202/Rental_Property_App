import 'package:flutter/material.dart';
import 'package:rental_property_app/data/data.dart';
import 'package:rental_property_app/widgets/card/property_card.dart';
import 'package:rental_property_app/widgets/property_detail/property_detail_screen.dart';

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
  List<String> services = ['Dịch vụ 1', 'Dịch vụ 2', 'Dịch vụ 3']; // Danh sách dịch vụ

  void _toggleService(String service) {
    setState(() {
      if (selectedServices.contains(service)) {
        selectedServices.remove(service); // Xóa dịch vụ nếu đã chọn
      } else {
        selectedServices.add(service); // Thêm dịch vụ nếu chưa chọn
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
      begin: const Offset(1.0, 1.0), // Bắt đầu từ ngoài màn hình bên phải
      end: Offset.zero, // Đích là vị trí bình thường (0,0)
    ).animate(CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeInOut,
    ));

    contracts[1].completeContract(bookingRequests[2]);
  }

  void _showFilterModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,

      builder: (context) {
        // return Column(
        //   children: [
        //     Text('Dịch vụ đã chọn vụ đã chọn: ${selectedServices.join(', ')}'),
        //     Text('Dịch : ${selectedServices.join(', ')}')
        //   ],
        // );
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState){
              return  Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(); // Đóng modal khi nhấn bên ngoài
                    },
                    child: Container(
                      color: Colors.transparent, // Khu vực bên ngoài modal
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: SlideTransition(
                      position: _animation!,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        height: MediaQuery.of(context).size.height, // Full chiều cao
                        width: MediaQuery.of(context).size.width / 3 * 2, // Chiều rộng 2/3
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            AppBar(
                              title: Text('Lọc'),
                              automaticallyImplyLeading: false,
                            ),
                            const Text('Chọn dịch vụ:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

                            Wrap(
                              spacing: 8.0, // Khoảng cách giữa các nút
                              runSpacing: 4.0, // Khoảng cách giữa các hàng
                              children: services.map((service) {
                                bool isSelected = selectedServices.contains(service);
                                return ChoiceChip(
                                  label: Text(service),
                                  selected: isSelected,
                                  onSelected: (bool selected) {
                                   setState((){
                                     _toggleService(service);
                                   });
                                  },
                                );
                              }).toList(),
                            ),
                            Text('Dịch vụ đã chọn: ${selectedServices.join(', ')}'),

                            DropdownButtonFormField<String>(
                              value: selectedRoomType,
                              hint: Text('Chọn loại phòng'),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedRoomType = newValue!;
                                });
                              },
                              items: roomTypes.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                            SizedBox(height: 10),

                            // Nhập địa chỉ
                            TextField(
                              decoration: InputDecoration(
                                labelText: 'Địa chỉ',
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  address = value;
                                });
                              },
                            ),
                            SizedBox(height: 10),

                            // Nhập giá tiền
                            Row(
                              children: [
                                Flexible(
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: 'Giá thấp nhất',
                                      border: OutlineInputBorder(),
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        minPrice = value;
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(width: 10),
                                Flexible(
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: 'Giá cao nhất',
                                      border: OutlineInputBorder(),
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        maxPrice = value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),

                            // Dropdown giới tính
                            DropdownButtonFormField<String>(
                              value: selectedGender,
                              hint: Text('Giới tính'),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedGender = newValue!;
                                });
                              },
                              items: <String>['Nam', 'Nữ', 'Cả hai'].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
        );
      },
    ).whenComplete(() => _controller!.reset()); // Reset lại animation khi modal đóng
    _controller!.forward(); // Kích hoạt animation khi mở modal
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: _showFilterModal,
          ),
        ],
        title: Text('Home'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: 10),

              Text('Phổ biến', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),

              // ListView.builder(
              //   shrinkWrap: true,
              //   physics: NeverScrollableScrollPhysics(),
              //   itemCount: popularItems.length,
              //   itemBuilder: (context, index) {
              //     final item = popularItems[index];
              //     return Card(
              //       margin: EdgeInsets.symmetric(vertical: 8),
              //       child: ListTile(
              //         leading: Image.network(item['image'], width: 80, height: 80, fit: BoxFit.cover),
              //         title: Text(item['title']),
              //         subtitle: Text('Giá: ${item['price']} \nĐịa chỉ: ${item['address']['district']}, ${item['address']['city']}'),
              //       ),
              //     );
              //   },
              // ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: properties.length,
                itemBuilder: (context, index) {
                  final property = properties[index];
                  return PropertyCard(
                    property: property,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PropertyDetailScreen(property: property),
                        ),
                      );
                    },
                  );
                  // return ListTile(
                  //   leading: Image.network(property.image),
                  //   title: Text(property.title),
                  //   subtitle: Text('${property.city}, ${property.district}'),
                  //   onTap: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => PropertyDetailScreen(property: property),
                  //       ),
                  //     );
                  //   },
                  // );
                },
              )

            ],
          ),
        ),
      ),
    );
  }
  
  
}