import 'package:flutter/material.dart';
import 'package:flutter_application_3/screens/product/payment.dart';
import './screens/product/cartproduct.dart';

class ProductMatchingPage extends StatefulWidget {
  @override
  _ProductMatchingPageState createState() => _ProductMatchingPageState();
}

class _ProductMatchingPageState extends State<ProductMatchingPage> {
  List<MatchedItem> draggedItems = []; // รายการสิ่งของที่ถูกลาก
  List<MatchedItem> matchedItems = []; // รายการสิ่งของที่แมตช์

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('จับคู่สินค้า'),
      ),
      body: Column(
        children: [
          if (draggedItems.isNotEmpty)
            Row(
              children: draggedItems
                  .map((item) => Draggable(
                        data: item,
                        feedback: Image.asset(
                          'assets/images/logo.png', // เปลี่ยนเป็นพาธรูปภาพของคุณ
                          width: item.size,
                          height: item.size,
                        ),
                        child: GestureDetector(
                          onPanUpdate: (details) {
                            setState(() {
                              item.position = Offset(
                                item.position.dx + details.delta.dx,
                                item.position.dy + details.delta.dy,
                              );
                            });
                          },
                          child: Image.asset(
                            'assets/images/logo.png', // เปลี่ยนเป็นพาธรูปภาพของคุณ
                            width: item.size,
                            height: item.size,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          DragTarget<MatchedItem>(
            builder: (context, accepted, rejected) {
              return Wrap(
                children: matchedItems
                    .map((item) => GestureDetector(
                          onTap: () {
                            setState(() {
                              draggedItems.add(item);
                              matchedItems.remove(item);
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(
                                8.0), // ตั้งค่า margin และ padding ที่ต้องการที่นี่
                            child: Image.asset(
                              'assets/images/logo.png', // เปลี่ยนเป็นพาธรูปภาพของคุณ
                              width: item.size,
                              height: item.size,
                            ),
                          ),
                        ))
                    .toList(),
              );
            },
            onAccept: (data) {
              setState(() {
                matchedItems.add(data);
                draggedItems.remove(data);
              });
            },
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     setState(() {
      //       // เพิ่มรูปภาพลากระหว่างพื้นที่
      //       draggedItems.add(MatchedItem(color: Colors.blue));
      //     });
      //   },
      //   child: Icon(Icons.add),
      // ),
      // แก้ไขที่นี่: ให้ปุ่ม "ล้างทั้งหมด" และ "ชำระเงิน" อยู่ด้านล่างสุดและอยู่ในบรรทัดเดียวกัน
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Cart()),
              );
            },
            child: Text("ล้างทั้งหมด"),
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
              fixedSize: Size(200, 50), // ปรับขนาดของปุ่มตรงนี้
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Payment(),
              ));
            },
            child: Text("ชำระเงิน"),
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
              fixedSize: Size(200, 50), // ปรับขนาดของปุ่มตรงนี้
            ),
          ),
        ],
      ),
    );
  }
}

class MatchedItem {
  final Color color;
  double size;
  Offset position;

  MatchedItem({
    required this.color,
    this.size = 100.0,
    this.position = const Offset(0, 0),
  });
}
