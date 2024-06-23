import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import '../models/invoice_model.dart';
import '../models/unit_model.dart';

part 'invoice_state.dart';

const String invoiceTableName = "InvoiceDetails";
const String unitTableName = "Unit";

class InvoiceCubit extends Cubit<InvoiceState> {
  InvoiceCubit() : super(InvoiceInitial());
  static InvoiceCubit of(BuildContext context) => BlocProvider.of(context);
  Database? db;
  List<InvoiceDetailsModel> invoicesList = [];
  List<UnitModel> units = [];
  var formkey = GlobalKey<FormState>();

  void initiateDatabase() async {
    emit(InvoiceLoadingState());
    try {
      db = await openDatabase(
        'interview.db',
        version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('''
      CREATE TABLE IF NOT EXISTS InvoiceDetails (
        lineNo INTEGER PRIMARY KEY AUTOINCREMENT,
        productName TEXT,
        unitNo INTEGER,
        price DOUBLE,
        quantity DOUBLE,
        total DOUBLE,
        expiryDate INTEGER
      )
    ''');

          await db.execute('''
      INSERT OR IGNORE INTO InvoiceDetails (productName, UnitNo, price, quantity, total, expiryDate)
      VALUES 
        ('Milk', 2, 1.5, 10, 15.0, ${DateTime.parse('2024-12-31').millisecondsSinceEpoch}),
        ('Bread', 3, 0.5, 20, 10.0, ${DateTime.parse('2024-07-01').millisecondsSinceEpoch}),
        ('Rice', 1, 0.8, 25, 20.0, ${DateTime.parse('2025-01-15').millisecondsSinceEpoch}),
        ('Sugar', 1, 1.0, 30, 30.0, ${DateTime.parse('2024-11-30').millisecondsSinceEpoch}),
        ('Butter', 3, 2.0, 5, 10.0, ${DateTime.parse('2024-09-01').millisecondsSinceEpoch})
    ''');

          await db.execute('''
      CREATE TABLE IF NOT EXISTS Unit (
        unitNo INTEGER PRIMARY KEY,
        unitName TEXT
      )
    ''');

          await db.execute('''
      INSERT OR IGNORE INTO Unit (unitNo, unitName)
      VALUES 
        (1, 'Kilogram'),
        (2, 'Liter'),
        (3, 'Piece')
    ''');
        },
        onOpen: (db) async {
          await getInvoices(db: db);
          await getUnits(db: db);
        },
      );
      emit(InvoiceDatabaseOpenedSuccesfully());
    } catch (e) {
      log("Error: ${e.toString()}");
      emit(InvoiceDatabaseOpenedFailed(message: e.toString()));
    }
  }

  Future<void> getInvoices({Database? db}) async {
    emit(InvoiceLoadingState());
    try {
      final database = db ?? this.db;
      final invoiceTableData = await database!.query(invoiceTableName);
      invoicesList =
          invoiceTableData.map((e) => InvoiceDetailsModel.fromMap(e)).toList();
      log(invoiceTableData.toString());
      emit(InvoiceGetInvoicesSuccessState());
    } catch (e) {
      emit(InvoiceGetInvoicesErrorState(message: e.toString()));
    }
  }

  Future<void> getUnits({Database? db}) async {
    emit(InvoiceLoadingState());
    try {
      final database = db ?? this.db;
      final unitData = await database!.query(unitTableName);
      units = unitData.map((e) => UnitModel.fromMap(e)).toList();
      log(unitData.toString());
      emit(InvoiceGetInvoicesSuccessState());
    } catch (e) {
      emit(InvoiceGetInvoicesErrorState(message: e.toString()));
    }
  }

  Future<void> addInvoice() async {
    emit(InvoiceLoadingState());
    try {
      InvoiceDetailsModel invoice = InvoiceDetailsModel(
        productName: productName,
        unitNo: selectedUnit!.unitNo, //add later
        price: double.parse(productPrice!),
        quantity: double.parse(productQuantity!),
        total: double.parse(productTotal!),
        expiryDate: DateTime.now(),
      );
      await db!.insert(invoiceTableName, invoice.toMap());
      emit(InvoiceOperationSuccessState());
      await getInvoices(); // Refresh the list after adding a new invoice
    } catch (e) {
      emit(InvoiceOperationErrorState(message: e.toString()));
    }
  }

  Future<void> updateInvoice(InvoiceDetailsModel invoice) async {
    emit(InvoiceLoadingState());
    try {
      await db!.update(invoiceTableName, invoice.toMap(),
          where: 'lineNo = ?', whereArgs: [invoice.lineNo]);
      emit(InvoiceOperationSuccessState());
      await getInvoices(); // Refresh the list after updating an invoice
    } catch (e) {
      emit(InvoiceOperationErrorState(message: e.toString()));
    }
  }

  Future<void> deleteInvoice(int lineNo) async {
    emit(InvoiceLoadingState());
    try {
      await db!
          .delete(invoiceTableName, where: 'lineNo = ?', whereArgs: [lineNo]);
      emit(InvoiceOperationSuccessState());
      await getInvoices(); // Refresh the list after deleting an invoice
    } catch (e) {
      emit(InvoiceOperationErrorState(message: e.toString()));
    }
  }

  Future<void> addUnit(String? unitName) async {
    emit(InvoiceLoadingState());
    try {
      UnitModel unit = UnitModel(
        unitName: unitName,
      );
      await db!.insert(unitTableName, unit.toMap());
      emit(InvoiceOperationSuccessState());
      await getUnits(); // Refresh the list after adding a new unit
    } catch (e) {
      emit(InvoiceOperationErrorState(message: e.toString()));
    }
  }

  Future<void> updateUnit(UnitModel unit) async {
    emit(InvoiceLoadingState());
    try {
      await db!.update(unitTableName, unit.toMap(),
          where: 'unitNo = ?', whereArgs: [unit.unitNo]);
      emit(InvoiceOperationSuccessState());
      await getUnits(); // Refresh the list after updating a unit
    } catch (e) {
      emit(InvoiceOperationErrorState(message: e.toString()));
    }
  }

  Future<void> deleteUnit(int unitNo) async {
    emit(InvoiceLoadingState());
    try {
      await db!.delete(unitTableName, where: 'unitNo = ?', whereArgs: [unitNo]);
      emit(InvoiceOperationSuccessState());
      await getUnits(); // Refresh the list after deleting a unit
    } catch (e) {
      emit(InvoiceOperationErrorState(message: e.toString()));
    }
  }

  //! ui
  String? productName;
  String? productPrice;
  String? productQuantity;
  String? productTotal;
  DateTime? expiryDate;
  UnitModel? selectedUnit;
  void changeName(String? name) {
    productName = name;
    emit(ChangeNameState());
  }

  void changeUnit(UnitModel? unit) {
    selectedUnit = unit;
    emit(ChangeUnitState());
  }
  void changePrice(String? price) {
    productPrice = price;
    emit(ChangePriceState());
  }

  void changeTotal(String? total) {
    productTotal = total;
    emit(ChangeTotalState());
  }

  void changequantiy(String? quantity) {
    productQuantity = quantity;
    emit(ChangeQuantityState());
  }

  void changeExpiryData(DateTime? dateTime) {
    expiryDate = dateTime;
    emit(ChangeExpiryDateState());
  }
}

//! a) View all records/lines in a list (By Code).
//! 	b) Add new records/lines (By Code).
//! 	c) View all details of a specific records/lines (By Code).
//! 	d) Update a specific records/lines information (By Code).
//! 	e) Delete a specific records/lines (By Code).
//! f) we want them to use any state management package to do delete process
//! 	g) the add/New entry form should be a form not a popup
//! 	h) Expiry date should be a date picker

// create database "Interview"
// 	create table [InvoiceDetails] (
// 				lineNo int
// 				, productName text
// 				, UnitNo int
// 				, price DOUBLE
// 				, quantity DOUBLE
// 				, total DOUBLE
// 				, expiryDate datetime
// 				)
// create table [Unit] (
// 				, unitNo int
// 				, unitName text
// 				)
