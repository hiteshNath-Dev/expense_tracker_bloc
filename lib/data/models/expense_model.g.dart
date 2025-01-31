// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpenseModelAdapter extends TypeAdapter<ExpenseModel> {
  @override
  final int typeId = 0;

  @override
  ExpenseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExpenseModel(
      amount: fields[0] as String,
      category: fields[3] as String,
      descrip: fields[1] as String,
      date: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ExpenseModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.amount)
      ..writeByte(1)
      ..write(obj.descrip)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.category);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ExpenseCategoryAdapter extends TypeAdapter<ExpenseCategory> {
  @override
  final int typeId = 1;

  @override
  ExpenseCategory read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ExpenseCategory.food;
      case 1:
        return ExpenseCategory.transportation;
      case 2:
        return ExpenseCategory.shopping;
      case 3:
        return ExpenseCategory.utilities;
      case 4:
        return ExpenseCategory.healthcare;
      case 5:
        return ExpenseCategory.entertainment;
      case 6:
        return ExpenseCategory.education;
      case 7:
        return ExpenseCategory.groceries;
      case 8:
        return ExpenseCategory.rent;
      case 9:
        return ExpenseCategory.other;
      default:
        return ExpenseCategory.food;
    }
  }

  @override
  void write(BinaryWriter writer, ExpenseCategory obj) {
    switch (obj) {
      case ExpenseCategory.food:
        writer.writeByte(0);
        break;
      case ExpenseCategory.transportation:
        writer.writeByte(1);
        break;
      case ExpenseCategory.shopping:
        writer.writeByte(2);
        break;
      case ExpenseCategory.utilities:
        writer.writeByte(3);
        break;
      case ExpenseCategory.healthcare:
        writer.writeByte(4);
        break;
      case ExpenseCategory.entertainment:
        writer.writeByte(5);
        break;
      case ExpenseCategory.education:
        writer.writeByte(6);
        break;
      case ExpenseCategory.groceries:
        writer.writeByte(7);
        break;
      case ExpenseCategory.rent:
        writer.writeByte(8);
        break;
      case ExpenseCategory.other:
        writer.writeByte(9);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
