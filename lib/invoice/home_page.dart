import 'package:appy_inovate/cubit/invoice_cubit.dart';
import 'package:appy_inovate/invoice/item_widget.dart';
import 'package:appy_inovate/invoice/new_invoice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: BlocBuilder<InvoiceCubit, InvoiceState>(
        builder: (context, state) {
          final cubit = InvoiceCubit.of(context);
          if (cubit.invoicesList.isEmpty && cubit.units.isEmpty) {
            return const Center(
              child: Text("No Invoice Found"),
            );
          }
          return Padding(
            padding: const EdgeInsetsDirectional.only(bottom: 60.0),
            child: ListView.builder(
              itemCount: cubit.invoicesList.length,
              itemBuilder: (context, index) {
                return ItemWidget(
                  invoice: cubit.invoicesList[index],
                  unit: cubit.units.where((unit) {
                    int no = cubit.invoicesList[index].unitNo!;
                    return unit.unitNo ==no ;  
                    }).firstOrNull,
                  onEdit: () {},
                  onDelete: () {
                    _showDeleteConfirmationDialog(context, cubit, cubit.invoicesList[index].lineNo!);
                  },
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const NewInvoice();
            }));
          }),
    );
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, InvoiceCubit cubit, int lineNo) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content:
              const Text('Are you sure you want to delete this invoice item?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                cubit.deleteInvoice(lineNo); // Call cubit method to delete
              },
            ),
          ],
        );
      },
    );
  }
}
