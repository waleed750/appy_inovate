import 'package:appy_inovate/cubit/invoice_cubit.dart';
import 'package:appy_inovate/invoice/unit_drop_down_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class NewInvoice extends StatefulWidget {
  const NewInvoice({super.key});

  @override
  State<NewInvoice> createState() => _NewInvoiceState();
}

class _NewInvoiceState extends State<NewInvoice> {
  // int? unitNo,
  //   double? price,
  //   double? quantity,
  //   double? total,
  //   DateTime? expiryDate,
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Invoice"),
      ),
      body: BlocConsumer<InvoiceCubit, InvoiceState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = InvoiceCubit.of(context);
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: cubit.formkey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 100.0,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        decoration:
                            const InputDecoration(hintText: "Name of Invoice"),
                        onChanged: (value) {
                          cubit.changeName(value);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "enter the name of invoice";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 100.0,
                      child: TextFormField(
                        decoration:
                            const InputDecoration(hintText: "Price of invoice"),
                        onChanged: (value) {
                          cubit.changePrice(value);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "enter the price of invoice";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 100.0,
                      child: TextFormField(
                        decoration: const InputDecoration(
                            hintText: "quantity of invoice"),
                        onChanged: (value) {
                          cubit.changequantiy(value);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "enter the quantity of invoice";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 100.0,
                      child: TextFormField(
                        decoration:
                            const InputDecoration(hintText: "total of invoice"),
                        onChanged: (value) {
                          cubit.changeTotal(value);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "enter the total of invoice";
                          }
                          return null;
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white),
                          child: Row(
                            children: [
                              const Text("Expiry Date : "),
                              Text(
                                cubit.expiryDate == null
                                    ? ""
                                    : DateFormat.yMMMd()
                                        .format(cubit.expiryDate!),
                                style: const TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                            onPressed: () async {
                              await selectExpiryDate(context);
                            },
                            child: const Text("Select Date")),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    UnitDropdown(
                        units: cubit.units,
                        onChanged: (value) {
                          cubit.changeUnit(value);
                        }),
                    ElevatedButton(
                        onPressed: () {
                          if (cubit.formkey.currentState!.validate() &&
                              cubit.expiryDate != null &&
                              cubit.selectedUnit != null) {
                            cubit.addInvoice();
                            Navigator.pop(context);
                          } else {
                            const snackBar = SnackBar(
                              content: Text('Fill all the fields'),
                              backgroundColor: Colors.red,
                              duration: Duration(
                                  seconds: 3), 
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        child: const Text("Submit")),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> selectExpiryDate(BuildContext context) async {
    final cubit = InvoiceCubit.of(context);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != cubit.expiryDate) {
      cubit.changeExpiryData(picked);
    }
  }
}
