import 'package:expense_tracker_bloc/Bloc/AmmountBloc/ammount_bloc.dart';
import 'package:expense_tracker_bloc/Bloc/HomeBloc/Home_bloc.dart';
import 'package:expense_tracker_bloc/Bloc/cubit/setDateCubit.dart';
import 'package:expense_tracker_bloc/Bloc/cubit/transactionCubit.dart';
import 'package:expense_tracker_bloc/Models/expenseModel.dart';
import 'package:expense_tracker_bloc/services/HiveHelper/HiveHelper.dart';
import 'package:expense_tracker_bloc/utils/Color/AppColors.dart';
import 'package:expense_tracker_bloc/views/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(ExpenseModelAdapter());
  await Hive.openBox<ExpenseModel>('ExpenseBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TransactionCubit(),
        ),
        BlocProvider(
          create: (context) => DateCubit(),
        ),
        BlocProvider(
          create: (context) => AmmountBloc(HiveHelper(), context),
        ),
        BlocProvider(
          create: (context) => HomeBloc(HiveHelper()),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Expense Tracker',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColor.blackColor),
          useMaterial3: true,
        ),
        home: const HomeView(),
      ),
    );
  }
}
