import 'package:bloc/bloc.dart';
import 'package:bloc_project/model/category.dart';
import 'package:bloc_project/model/expense.dart';
import 'package:bloc_project/repositories/expense_repository.dart';
import 'package:equatable/equatable.dart';

part 'expense_list_event.dart';
part 'expense_list_state.dart';

class ExpenseListBloc extends Bloc<ExpenseListEvent, ExpenseListState> {
  ExpenseListBloc({
    required ExpenseRepository repository,
  })  : _repository = repository,
        super( ExpenseListState()) {
    on<ExpenseListEvent>((event, emit) {});
    on<ExpenseListSubscriptionRequested>(_onSubscriptionRequested);
    on<ExpenseListExpenseDeleted>(_onExpenseDeleted);
    on<ExpenseListCategoryFilterChanged>(_onCategoryFilterChanged);
  }
  final ExpenseRepository _repository;

  Future<void> _onSubscriptionRequested(
    ExpenseListSubscriptionRequested event,
    Emitter<ExpenseListState> emit,
  ) async {
    emit(state.copyWith(status: () => ExpenseListStatus.loading));
    final stream = _repository.getAllExpenses();
    await emit.forEach<List<Expense?>>(
      stream,
      onData: (expenses) => state.copyWith(
        status: () => ExpenseListStatus.success,
        expenses: () => expenses,
        totalExpenses: () => expenses
            .map((currentExpense) => currentExpense?.amount)
            .fold(0.0, (a, b) => a + b!),
      ),
      onError: (_, __) => state.copyWith(
        status: () => ExpenseListStatus.failure,
      ),
    );
  }

  Future <void> _onExpenseDeleted(
    ExpenseListExpenseDeleted event,
    Emitter<ExpenseListState> emit,
  )async{
    await _repository.deleteExpense(event.expense.id);
  }

  Future<void> _onCategoryFilterChanged(
    ExpenseListCategoryFilterChanged event,
    Emitter<ExpenseListState> emit,
  ) async {
    emit(state.copyWith(filter: () => event.filter));
  }

}

