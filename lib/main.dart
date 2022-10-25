import 'package:flutter/material.dart';

void main() {
  runApp(
    const App(),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GPay',
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: false,
        fontFamily: 'Product Sans',
      ),
      home: const RewardsScreen(),
    );
  }
}

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({super.key});

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  @override
  Widget build(BuildContext context) {
    // Google Pay rewards page UI in Flutter
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          const SliverAppBar(
            // backgroundColor: Color.fromRGBO(246, 211, 181, 1),
            backgroundColor: Colors.white,
            pinned: true,
            expandedHeight: 200.0,
            leading: Icon(
              Icons.arrow_back_ios,
              color: Color.fromRGBO(60, 64, 67, 1),
            ),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              expandedTitleScale: 6,
              title: Text(
                'GPay',
                style: TextStyle(
                  // fontSize: 90,
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(60, 64, 67, 1),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: Icon(
                  Icons.more_horiz,
                  color: Color.fromRGBO(60, 64, 67, 1),
                ),
              ),
            ],
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(24, 16, 0, 0),
              child: Text(
                'My Rewards',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(60, 64, 67, 1),
                ),
              ),
            ),
          ),
        ],
        body: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: GridView.builder(
            padding: const EdgeInsets.all(16.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12.0,
              crossAxisSpacing: 12.0,
              childAspectRatio: 1.0,
            ),
            itemBuilder: (context, index) => Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                image: const DecorationImage(
                  image: AssetImage('assets/images/rewards_card.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
