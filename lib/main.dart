import 'package:expense_tracker_bloc/presentation/bloc/amount/amount_bloc.dart';
import 'package:expense_tracker_bloc/presentation/bloc/home/home_bloc.dart';
import 'package:expense_tracker_bloc/presentation/bloc/date/date_cubit.dart';
import 'package:expense_tracker_bloc/presentation/bloc/transaction/transaction_cubit.dart';
import 'package:expense_tracker_bloc/data/models/expense_model.dart';
import 'package:expense_tracker_bloc/data/data_sources/local/hive_helper.dart';
import 'package:expense_tracker_bloc/core/constants/app_colors.dart';
import 'package:expense_tracker_bloc/presentation/pages/home_page.dart';
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
          create: (context) => AmountBloc(HiveHelper(), context),
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
