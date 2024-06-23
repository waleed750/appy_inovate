import 'dart:developer';

import 'package:appy_inovate/models/unit_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:appy_inovate/models/invoice_model.dart';

class ItemWidget extends StatelessWidget {
  final InvoiceDetailsModel invoice;
  final UnitModel? unit;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ItemWidget({
    super.key,
    required this.unit,
    required this.invoice,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    log("Unit ${unit?.unitNo}");
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                invoice.productName.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Price: ${invoice.price.toString()}',
                  ),
                  Text(
                    'Quantity: ${invoice.quantity.toString()}',
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Text(
                'Total: ${invoice.total?.toStringAsFixed(2)} \$',
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                'Expiry Date: ${DateFormat.yMMMd().format(invoice.expiryDate!)}',
              ),
              const SizedBox(height: 8.0),
              Text(
                'Unit: ${unit!.unitName}',
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(width: 8.0),
                  IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: onDelete,
                    tooltip: 'Delete',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
