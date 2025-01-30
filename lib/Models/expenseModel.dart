import 'package:hive/hive.dart';
part 'expenseModel.g.dart';

@HiveType(typeId: 0)
class ExpenseModel extends HiveObject {
  @HiveField(0)
  String ammount;

  @HiveField(1)
  String ammountType;

  @HiveField(2)
  String descrip;

  @HiveField(3)    
  String date;

  ExpenseModel(
      {required this.ammount,
      required this.ammountType,
      required this.descrip,
      required this.date});
}
