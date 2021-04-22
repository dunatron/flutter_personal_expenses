import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './models/transaction.dart';
import './widgets/chart.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final isIos = Theme.of(context).platform == TargetPlatform.iOS;

// Recomment to use Material Theme App and then use adaptive Widgets if you want cuppertino feel for some things
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        errorColor: Colors.red,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              button: TextStyle(
                color: Colors.white,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
    );
    // return isIos
    //     ? CupertinoApp(
    //         title: 'Flutter Demo',
    //         home: MyHomePage(),
    //         localizationsDelegates: [
    //           DefaultMaterialLocalizations.delegate,
    //           DefaultCupertinoLocalizations.delegate,
    //           DefaultWidgetsLocalizations.delegate,
    //         ],
    //         theme: CupertinoThemeData(
    //           primaryColor: Colors.purple,
    //         ),
    //       )
    //     : MaterialApp(
    //         title: 'Flutter Demo',
    //         theme: ThemeData(
    //           primarySwatch: Colors.purple,
    //           accentColor: Colors.amber,
    //           errorColor: Colors.red,
    //           fontFamily: 'Quicksand',
    //           textTheme: ThemeData.light().textTheme.copyWith(
    //                 headline6: TextStyle(
    //                   fontFamily: 'OpenSans',
    //                   fontWeight: FontWeight.bold,
    //                   fontSize: 18,
    //                 ),
    //                 button: TextStyle(
    //                   color: Colors.white,
    //                 ),
    //               ),
    //           appBarTheme: AppBarTheme(
    //             textTheme: ThemeData.light().textTheme.copyWith(
    //                   headline6: TextStyle(
    //                     fontFamily: 'OpenSans',
    //                     fontSize: 20,
    //                     fontWeight: FontWeight.bold,
    //                     color: Colors.green,
    //                   ),
    //                 ),
    //           ),
    //         ),
    //         home: MyHomePage(),
    //       );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showChart = false;
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 120.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly Groceries',
      amount: 260.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly Groceries',
      amount: 2000.00,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly Groceries',
      amount: 420.00,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly Groceries',
      amount: 1600.00,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime chosenDate) {
    final newTx = Transaction(
      title: title,
      amount: amount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((txItem) => txItem.id == id);
    });
  }

  void startAddNewTransaction(BuildContext ctx) {
    final test = Theme.of(ctx).platform == TargetPlatform.iOS;
    test
        ? showCupertinoModalPopup(
            context: context,
            builder: (context) {
              return CupertinoActionSheet(
                title: Text("Add Transaction"),
                // message: Text("Select your hobbie"),
                actions: <Widget>[NewTransaction(_addNewTransaction)],
              );
            })
        : showModalBottomSheet(
            context: ctx,
            builder: (_) {
              return NewTransaction(_addNewTransaction);
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isIos = Theme.of(context).platform == TargetPlatform.iOS;
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = isIos
        ? CupertinoNavigationBar(
            middle: Text('Flutter App'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // GestureDetector(
                //   onTap: () => startAddNewTransaction(context),
                //   child: Icon(CupertinoIcons.add),
                // )
                CupertinoButton(
                  onPressed: () => startAddNewTransaction(context),
                  child: Icon(CupertinoIcons.add),
                )
              ],
            ),
          )
        : AppBar(
            title: Text("Flutter App"),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => startAddNewTransaction(context),
              ),
            ],
          );
    final txListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );
    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape)
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Show Chart'),
                  Switch.adaptive(
                    activeColor: Theme.of(context).accentColor,
                    value: _showChart,
                    onChanged: (v) {
                      setState(() {
                        _showChart = v;
                      });
                    },
                  ),
                ],
              ),
            if (!isLandscape)
              Container(
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.3,
                child: Chart(_recentTransactions),
              ),
            if (!isLandscape) txListWidget,
            if (isLandscape)
              _showChart
                  ? Container(
                      height: (mediaQuery.size.height -
                              appBar.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.7,
                      child: Chart(_recentTransactions),
                    )
                  : txListWidget,
          ],
        ),
      ),
    );
    return isIos
        ? CupertinoPageScaffold(
            navigationBar: appBar,
            child: pageBody,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: isIos
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => startAddNewTransaction(context),
                  ),
          );
  }
}
