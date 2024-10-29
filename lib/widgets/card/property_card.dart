import 'package:flutter/material.dart';
import 'package:rental_property_app/common/format-data.dart';
import 'package:rental_property_app/data/models/property.dart';

class PropertyCard extends StatelessWidget {
  final Property property;
  final VoidCallback onTap;

  PropertyCard({required this.property, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        // margin: EdgeInsets.all(3),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 70,
                child: Image.network(property.image, height: 70, width: double.infinity, fit: BoxFit.cover),
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${property.address?.city}, ${property.address?.district}, ${property.address?.ward}',
                    style: TextStyle(color: Colors.grey[600], fontSize: 11),
                  ),
                  Text(
                    property.title,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),

                  Text(
                    '${formatCurrency(property.price)} đ',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFF4511E),
                    ),
                  ),
                  Text(
                    'Tiện ích: ${property.utilities?.map((u) => u.name).join(', ') ?? 'Không có tiện ích'}',
                    style: TextStyle(fontSize: 11, color: Colors.grey[700]),
                  ),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
