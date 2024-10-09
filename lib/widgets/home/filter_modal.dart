// import 'package:flutter/material.dart';
//
// class FilterModal extends StatefulWidget {
//   @override
//   _FilterModalState createState() => _FilterModalState();
// }
//
// class _FilterModalState extends State<FilterModal>
//     with SingleTickerProviderStateMixin {
//   AnimationController? _controller;
//   Animation<Offset>? _animation;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 300),
//       vsync: this,
//     );
//     _animation = Tween<Offset>(
//       begin: const Offset(1.0, 0.0), // Bắt đầu từ ngoài màn hình bên phải
//       end: Offset.zero, // Đích là vị trí bình thường
//     ).animate(CurvedAnimation(
//       parent: _controller!,
//       curve: Curves.easeInOut,
//     ));
//   }
//
//   void _showFilterModal() {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (context) {
//         return Align(
//           alignment: Alignment.centerRight, // Đặt modal ở bên phải màn hình
//           child: SlideTransition(
//             position: _animation!,
//             child: Container(
//               height: MediaQuery.of(context).size.height, // Full chiều cao
//               width: MediaQuery.of(context).size.width / 3 * 2, // Chiều rộng 2/3
//               color: Colors.white,
//               child: Column(
//                 children: [
//                   AppBar(
//                     title: Text('Lọc'),
//                     automaticallyImplyLeading: false,
//                   ),
//                   Expanded(
//                     child: Center(child: Text('Tùy chọn bộ lọc...')),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//         // return SlideTransition(
//         //   position: _animation!,
//         //   child: Container(
//         //     height: MediaQuery.of(context).size.height,
//         //     width: MediaQuery.of(context).size.width/3*2,// Full chiều cao màn hình
//         //     color: Colors.white,
//         //     child: Column(
//         //       children: [
//         //         AppBar(
//         //           title: Text('Lọc'),
//         //           automaticallyImplyLeading: false,
//         //         ),
//         //         Expanded(
//         //           child: Center(child: Text('Tùy chọn bộ lọc...')),
//         //         ),
//         //       ],
//         //     ),
//         //   ),
//         // );
//       },
//     ).whenComplete(() => _controller!.reset()); // Reset lại animation khi modal đóng
//     _controller!.forward(); // Kích hoạt animation khi mở modal
//   }
//
//   @override
//   void dispose() {
//     _controller?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Filter Modal'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.filter_list),
//             onPressed: _showFilterModal,
//           ),
//         ],
//       ),
//       body: Center(
//         child: Text('Nhấn vào icon bộ lọc để mở FilterModal'),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class FilterModal extends StatefulWidget {
  @override
  _FilterModalState createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<Offset>? _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<Offset>(
      begin: const Offset(1.0, 0.0), // Bắt đầu từ ngoài màn hình bên phải
      end: Offset.zero, // Đích là vị trí bình thường (0,0)
    ).animate(CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeInOut,
    ));
  }

  void _showFilterModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Stack(
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
              alignment: Alignment.centerRight,
              child: SlideTransition(
                position: _animation!,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width ,
                  color: Colors.white,
                  child: Column(
                    children: [
                      AppBar(
                        title: const Text('Lọc'),
                        automaticallyImplyLeading: false,
                      ),
                      const Expanded(
                        child: Center(child: Text('Tùy chọn bộ lọc...')),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    ).whenComplete(() => _controller!.reset()); // Reset lại animation khi modal đóng
    _controller!.forward(); // Kích hoạt animation khi mở modal
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter Modal'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterModal,
          ),
        ],
      ),
      body: const Center(
        child: Text('Nhấn vào icon bộ lọc để mở FilterModal'),
      ),
    );
  }
}
