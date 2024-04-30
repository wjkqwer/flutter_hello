import 'package:flutter/material.dart';
import 'package:flutter_todos/screen/anonymous_route_screen.dart';
import 'package:flutter_todos/screen/demo_all_screen.dart';
import 'package:flutter_todos/screen/edit_todo_screen.dart';
import 'package:flutter_todos/screen/stats_screen.dart';
import 'package:flutter_todos/screen/todos_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        AnonymousRouteScreen.routeName: (context) {
          return const AnonymousRouteScreen();
        }
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

//枚举类
enum HomeTab { demo, todos, stats }

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  HomeTab _selectedTab = HomeTab.demo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IndexedStack(
          index: _selectedTab.index,
          children: const [DemoAllScreen(), TodosScreen(), StatsScreen()],
        ),
        //中间浮动“添加”按钮
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          shape: CircleBorder(), //设置圆形
          onPressed: () {
            //导航
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return EditTodoScreen();
            }));
          },
          child: Icon(Icons.add),
        ),
        //底部tab栏
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _HomeTabButton(
                  groupValue: _selectedTab,
                  value: HomeTab.demo,
                  icon: const Icon(Icons.list_rounded),
                  onPressed: () {
                    _switchTab(HomeTab.demo);
                  }),
              _HomeTabButton(
                  groupValue: _selectedTab,
                  value: HomeTab.todos,
                  icon: const Icon(Icons.list_rounded),
                  onPressed: () {
                    _switchTab(HomeTab.todos);
                  }),
              _HomeTabButton(
                  groupValue: _selectedTab,
                  value: HomeTab.stats,
                  icon: const Icon(Icons.show_chart_rounded),
                  onPressed: () {
                    _switchTab(HomeTab.stats);
                  })
            ],
          ),
        ));
  }

  void _switchTab(HomeTab homeTab) {
    if (_selectedTab == homeTab) return;
    setState(() {
      _selectedTab = homeTab;
    });
  }
}

class _HomeTabButton extends StatelessWidget {
  final HomeTab groupValue;
  final HomeTab value;
  final Icon icon;
  final VoidCallback onPressed;

  _HomeTabButton(
      {required this.groupValue,
      required this.value,
      required this.icon,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed,
        icon: icon,
        color: value == groupValue ? Colors.blue : Colors.grey);
  }
}
