import 'package:expense_tracker_bloc/presentation/bloc/home/home_bloc.dart';
import 'package:expense_tracker_bloc/presentation/bloc/home/home_event.dart';
import 'package:expense_tracker_bloc/presentation/bloc/home/home_state.dart';
import 'package:expense_tracker_bloc/presentation/pages/add_amount_page.dart';
import 'package:expense_tracker_bloc/presentation/widgets/total_balance.dart';
import 'package:expense_tracker_bloc/core/constants/image_asset.dart';
import 'package:expense_tracker_bloc/core/constants/app_colors.dart';
import 'package:expense_tracker_bloc/core/utils/extension.dart';
import 'package:expense_tracker_bloc/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    context.read<HomeBloc>().add(HomeLoadedEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Image.asset(
            ImageAsset.leadingHome,
            height: context.mh * 0.06,
            width: context.mw * 0.06,
            color: AppColor.blackColor,
          ),
        ),
        title: Text(
          'DashBoard',
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoadedState) {
            return Column(
              children: [
                TotalBalanceComp(
                    value: state.totalbalance.toString(),
                    Incnomevalue: state.totalIncome.toString(),
                    Expensevalue: state.totalExpense.toString()),
                0.03.ph(context),
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    // reverse: true,
                    itemCount: state.expenseList.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: Key(state.expenseList[index].key.toString()),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (direction) {
                          context.read<HomeBloc>().add(
                              HomeDeleteEvent(state.expenseList[index].key));
                        },
                        child: Column(
                          children: [
                            ListTile(
                              leading: Container(
                                height: context.mh * 0.14,
                                width: context.mh * 0.07,
                                margin:
                                    EdgeInsets.only(right: context.mw * 0.03),
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                        colors: [
                                          AppColor.blackColor,
                                          AppColor.blueColor,
                                        ],
                                        begin: Alignment.center,
                                        end: Alignment.topLeft),
                                    borderRadius: BorderRadius.circular(20)),
                                child: const Icon(Icons.currency_exchange,
                                    size: 20, color: Colors.white),
                              ),
                              title: Text(state.expenseList[index].descrip,
                                  style: GoogleFonts.poppins(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold)),
                              subtitle: Text(Utils.dateFormated(
                                  state.expenseList[index].date.toString())),
                              trailing: state.expenseList[index].amountType ==
                                      'TransactionType.income'
                                  ? Container(
                                      margin: EdgeInsets.only(
                                          right: context.mw * 0.03),
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Icon(
                                        Icons.arrow_downward,
                                        size: 30,
                                        color: Colors.green[700],
                                      ),
                                    )
                                  : Container(
                                      margin: EdgeInsets.only(
                                          right: context.mw * 0.03),
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Icon(
                                        Icons.arrow_upward,
                                        size: 30,
                                        color: Colors.red[700],
                                      ),
                                    ),
                            ),
                            const Divider(
                              endIndent: 30,
                              indent: 30,
                            )
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            );
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.blackColor,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const addAmount(),
              ));
        },
        child: const Icon(
          Icons.add,
          color: AppColor.whiteColor,
        ),
      ),
    );
  }
}
