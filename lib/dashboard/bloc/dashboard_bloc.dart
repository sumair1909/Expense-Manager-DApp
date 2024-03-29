import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:expense_manager/models/transaction_model.dart';
import 'package:expense_manager/utils/constants.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/io.dart';

part 'dashboard_events.dart';
part 'dashboard_states.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<DashboardInitialFetchEvent>(dashboardInitialFetchEvent);
    on<DashboardDepositEvent>(dashboardDepositEvent);
    on<DashboardWithdrawEvent>(dashboardWithdrawEvent);
  }
  List<TransactionModel> transactions = [];
  Web3Client? _web3client;
  late ContractAbi _abiCode;
  late EthereumAddress _contractAddress;
  late EthPrivateKey _credentials;
  int balance = 0;
  //getting the contract functions
  late DeployedContract _deployedContract;
  late ContractFunction _deposit;
  late ContractFunction _withdraw;
  late ContractFunction _getBalance;
  // late ContractFunction _getTransactions;
  late ContractFunction _getAllTransaction;

  FutureOr<void> dashboardInitialFetchEvent(
      DashboardInitialFetchEvent event, Emitter<DashboardState> emit) async {
    emit(DashboardLoadingState());

    try {
      _web3client = Web3Client(
        rpcUrl,
        http.Client(),
        socketConnector: () => IOWebSocketChannel.connect(wsUrl).cast<String>(),
      );
      //getting the ABI file
      String abiFile = await rootBundle
          .loadString('build/contracts/ExpenseManagerContract.json');
      var abiDecoded = jsonDecode(abiFile);
      _abiCode = ContractAbi.fromJson(
          jsonEncode(abiDecoded['abi']), 'ExpenseManagerContract');
      //getting the contract address
      _contractAddress = EthereumAddress.fromHex(contractAddress);

      //getting the credentials
      _credentials = EthPrivateKey.fromHex(privateKey);
      _deployedContract = DeployedContract(_abiCode, _contractAddress);
      _deposit = _deployedContract.function('deposit');
      _withdraw = _deployedContract.function('withdraw');
      _getBalance = _deployedContract.function('getBalance');
      _getAllTransaction = _deployedContract.function('getAllTransactions');

      final allTransactionsData = await _web3client!.call(
          contract: _deployedContract,
          function: _getAllTransaction,
          params: []);
      log("The transactions data is:${allTransactionsData.toString()}");
      final balanceData = await _web3client!.call(
          contract: _deployedContract,
          function: _getBalance,
          params: [EthereumAddress.fromHex(address)]);
      log("The balance data is:${balance.toString()}");
      List<TransactionModel> trans = [];
      for (int i = 0; i < allTransactionsData[0].length; i++) {
        TransactionModel transactionModel = TransactionModel(
            address: allTransactionsData[0][i].toString(),
            amount: allTransactionsData[1][i].toString(),
            reason: allTransactionsData[2][i].toString(),
            timestamp: DateTime.fromMillisecondsSinceEpoch(
                allTransactionsData[3][i]..toInt()));
        trans.add(transactionModel);
      }
      transactions = trans;

      balance = balanceData[0].toInt();

      emit(DashboardSuccessState(transactions: transactions, balance: balance));
    } catch (e) {
      log(e.toString());
      emit(DashboardErrorState());
    }
  }

  FutureOr<void> dashboardDepositEvent(
      DashboardDepositEvent event, Emitter<DashboardState> emit) async {
    try {
      final depositEventData = await _web3client!.call(
          contract: _deployedContract,
          function: _deposit,
          params: [
            event.transactionModel.amount,
            event.transactionModel.reason
          ]);
      log("Deposit Data: ${depositEventData.toString()}");
    } on Exception catch (e) {
      log("Some error ocurred while deposit: ${e.toString()}");
      emit(DashboardErrorState());
    }
  }

  FutureOr<void> dashboardWithdrawEvent(
      DashboardWithdrawEvent event, Emitter<DashboardState> emit) async {
    try {
      final withdrawEventData = await _web3client!.call(
          contract: _deployedContract,
          function: _withdraw,
          params: [
            event.transactionModel.amount,
            event.transactionModel.reason
          ]);
      log("Withdraw Data: ${withdrawEventData.toString()}");
    } on Exception catch (e) {
      log("Some error ocurred while withdraw: ${e.toString()}");
    }
  }
}
