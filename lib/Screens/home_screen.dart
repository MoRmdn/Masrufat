import 'package:auto_size_text/auto_size_text.dart';
import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/material.dart';
import 'package:masrufat/Providers/accounts_provider.dart';
import 'package:masrufat/Screens/add_account.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import '../Widgets/add_account_widget.dart';

enum loadPage {
  credit,
  depit,
}

class HomeScreen extends StatefulWidget {
  static const String routeNamed = '/homeScreen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController accNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController balanceController = TextEditingController();
  final autoSizeGroup = AutoSizeGroup();
  var _bottomNavIndex = 0; //default index of a first screen

  late AnimationController _animationController;
  late Animation<double> animation;
  late CurvedAnimation curve;

  final iconList = <IconData>[
    Icons.savings_rounded,
    Icons.money,
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    curve = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        0.5,
        1.0,
        curve: Curves.fastOutSlowIn,
      ),
    );
    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(curve);

    Future.delayed(
      const Duration(seconds: 1),
      () => _animationController.forward(),
    );
  }

  // ignore: unused_element
  Future<void> _askedToLead(BuildContext ctx) async {
    await showDialog(
        context: ctx,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Select AccountType'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(AddAccount.routeNamed,
                      arguments: accountType.credit);
                },
                child: const Text('Credit Account'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Navigator.of(context).pushNamed(AddAccount.routeNamed,
                  //     arguments: accountType.debit);
                  showModalBottomSheet(
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0)),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    context: ctx,
                    builder: (BuildContext context) => Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 5),
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  RowBuilder(
                                    title: 'Account Name',
                                    lableTitle: 'Name',
                                    keyboardType: TextInputType.text,
                                    textController: accNameController,
                                    txtFieldColor: Colors.white,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  RowBuilder(
                                    title: 'Description',
                                    lableTitle: 'info',
                                    keyboardType: TextInputType.text,
                                    textController: descriptionController,
                                    txtFieldColor: Colors.white,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  RowBuilder(
                                    title: 'Balance',
                                    lableTitle: '00.0',
                                    keyboardType: TextInputType.number,
                                    textController: balanceController,
                                    txtFieldColor: Colors.white,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  RowBuilder(
                                    title: 'Account Name',
                                    lableTitle: 'Name',
                                    keyboardType: TextInputType.text,
                                    textController: accNameController,
                                    txtFieldColor: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                child: const Text('Debit Account'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accounts'),
        actions: [
          IconButton(
            onPressed: () => _askedToLead(context),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: NavigationScreen(
        iconList[_bottomNavIndex],
      ),
      floatingActionButton: ScaleTransition(
        scale: animation,
        child: FloatingActionButton(
          elevation: 8,
          backgroundColor: Colors.indigo,
          child: Icon(
            Icons.add,
            color: Colors.amber,
          ),
          onPressed: () {
            _animationController.reset();
            _animationController.forward();
            _askedToLead(context);
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: iconList.length,
        tabBuilder: (int index, bool isActive) {
          final color = isActive ? Colors.amber : Colors.white;
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconList[index],
                size: 24,
                color: color,
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: index == 0
                    ? AutoSizeText(
                        "Accounts",
                        maxLines: 1,
                        style: TextStyle(color: color),
                        group: autoSizeGroup,
                      )
                    : AutoSizeText(
                        "Expenses",
                        maxLines: 1,
                        style: TextStyle(color: color),
                        group: autoSizeGroup,
                      ),
              )
            ],
          );
        },
        backgroundColor: Colors.indigo,
        activeIndex: _bottomNavIndex,
        splashColor: Colors.amber,
        notchAndCornersAnimation: animation,
        splashSpeedInMilliseconds: 300,
        notchSmoothness: NotchSmoothness.defaultEdge,
        gapLocation: GapLocation.center,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: (index) => setState(() => _bottomNavIndex = index),
      ),
    );
  }
}

class NavigationScreen extends StatefulWidget {
  final IconData iconData;

  NavigationScreen(this.iconData) : super();

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> animation;

  @override
  void didUpdateWidget(NavigationScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.iconData != widget.iconData) {
      _startAnimation();
    }
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward();
    super.initState();
  }

  _startAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: Center(
        child: CircularRevealAnimation(
          animation: animation,
          centerOffset: Offset(80, 80),
          maxRadius: MediaQuery.of(context).size.longestSide * 1.1,
          child: Icon(
            widget.iconData,
            color: HexColor('#FFA400'),
            size: 160,
          ),
        ),
      ),
    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
