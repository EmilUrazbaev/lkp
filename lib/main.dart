import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import './widgets/contract_card.dart';
import 'widgets/card/card_list.dart';
import 'models/cards.dart';
import './models/transactions.dart';
import './models/contract_model.dart';
import './models/auth.dart';
import 'widgets/transaction/transaction_list.dart';
import './screens/auth_screen.dart';
import './screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Cards>(
          create: null,
          update: (ctx, auth, previousCards) => Cards(
              auth.mainUrl,
              auth.token,
              auth.contractId,
              previousCards == null ? [] : previousCards.items),
        ),
        ChangeNotifierProxyProvider<Auth, Transactions>(
          create: null,
          update: (ctx, auth, previousTransactions) => Transactions(
              auth.mainUrl,
              auth.token,
              auth.contractId,
              previousTransactions == null ? [] : previousTransactions.items),
        ),
        ChangeNotifierProxyProvider<Auth, Contract>(
          create: null,
          update: (ctx, auth, previousContract) => Contract(
              auth.mainUrl,
              auth.token,
              auth.contractId,
              previousContract == null ? null : previousContract.item),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Личный кабинет',
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.grey[200],
            primarySwatch: Colors.indigo,
          ),
          home: auth.isAuth
              ? MyHomePage()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen()),
          routes: {
            // '/card-detail': (ctx) => CardDetailScreen(),
            // '/transaction-detail': (ctx) => TransactionDetailScreen(),
          },
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    ContractCard(),
    CardList(),
    TransactionList(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Личный кабинет'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: GestureDetector(
              onTap: () {
                auth.logout();
              },
              child: Icon(
                Icons.logout,
                size: 26.0,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.subtitles),
            label: 'Договор',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card),
            label: 'Карты',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.swap_vert),
            label: 'Транзакции',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
