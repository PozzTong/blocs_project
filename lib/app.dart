import 'package:bloc_project/bloc/expense_list/expense_list_bloc.dart';
import 'package:bloc_project/repositories/expense_repository.dart';
import 'package:bloc_project/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'page/home_page.dart';

class App extends StatelessWidget {
  const App({super.key, required this.expenseRepository});
  final ExpenseRepository expenseRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: expenseRepository,
      child: BlocProvider(
        create: (context) => ExpenseListBloc(
          repository: expenseRepository
        )..add(ExpenseListSubscriptionRequested()),
        child: MaterialApp(
          home: HomePage(),
          theme: AppTheme.theme,
          // theme: ThemeData.light(),
          // darkTheme: ThemeData.dark(),
          // themeMode: ThemeMode.system,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}


