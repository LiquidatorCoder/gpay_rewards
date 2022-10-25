import 'dart:math';

import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

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
  late LinkedScrollControllerGroup _controllers;
  late ScrollController _cloudsController;
  late ScrollController _groundController;
  late ScrollController _middleGroundController;
  late ScrollController _rewardsBGController;
  late ScrollController _rewardsController;

  @override
  void initState() {
    super.initState();
    _controllers = LinkedScrollControllerGroup();
    _cloudsController = ScrollController();
    _groundController = ScrollController();
    _middleGroundController = ScrollController();
    _rewardsBGController = _controllers.addAndGet();
    _rewardsController = _controllers.addAndGet();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _rewardsController.animateTo(
        800,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      ),
    );

    _controllers.addOffsetChangedListener(
      () {
        final cloudsPosition = (_rewardsController.offset *
                (_cloudsController.position.maxScrollExtent /
                    _rewardsController.position.maxScrollExtent))
            .clamp(0, _cloudsController.position.maxScrollExtent)
            .toDouble();
        final middleGroundPosition = (_rewardsController.offset *
                (_middleGroundController.position.maxScrollExtent /
                    _rewardsController.position.maxScrollExtent))
            .clamp(0, _middleGroundController.position.maxScrollExtent)
            .toDouble();
        final groundPosition = (_rewardsController.offset *
                (_groundController.position.maxScrollExtent /
                    _rewardsController.position.maxScrollExtent))
            .clamp(0, _groundController.position.maxScrollExtent)
            .toDouble();

        setState(
          () {
            _cloudsController.jumpTo(
              cloudsPosition,
            );
            _middleGroundController.jumpTo(
              middleGroundPosition,
            );
            _groundController.jumpTo(
              groundPosition,
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _cloudsController.dispose();
    _groundController.dispose();
    _rewardsBGController.dispose();
    _rewardsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Google Pay rewards page UI in Flutter
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        physics: const ClampingScrollPhysics(),
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            backgroundColor: Colors.white,
            pinned: true,
            expandedHeight: 200.0,
            leading: const Icon(
              Icons.arrow_back_ios,
              color: Color.fromRGBO(60, 64, 67, 1),
            ),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              background: SizedBox(
                height: 200 + MediaQuery.of(context).padding.top,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    ListView.builder(
                      controller: _cloudsController,
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => SizedBox(
                        height: 200,
                        width: 800,
                        child: Image.asset(
                          'assets/images/clouds.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      itemCount: 1,
                    ),
                    ListView.builder(
                      controller: _groundController,
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => SizedBox(
                        height: 200,
                        width: 1200,
                        child: Image.asset(
                          'assets/images/ground.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      itemCount: 1,
                    ),
                    ListView.builder(
                      controller: _middleGroundController,
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => SizedBox(
                        height: 200,
                        width: 1800,
                        child: Image.asset(
                          'assets/images/middle_ground.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      itemCount: 1,
                    ),
                    ListView.builder(
                      controller: _rewardsController,
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => SizedBox(
                        height: 200,
                        width: 2400,
                        child: Image.asset(
                          'assets/images/rewards.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      itemCount: 1,
                    ),
                    ListView.builder(
                      controller: _rewardsBGController,
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 36,
                          width: 36,
                          margin: EdgeInsets.fromLTRB(
                            6,
                            0,
                            6,
                            24 + sin(index / 1.73).clamp(-1, 1) * 20,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: index < 3 || index > (2400 ~/ 48) - 4
                                ? Colors.transparent
                                : index > (2400 ~/ 120)
                                    ? Colors.blue.shade50
                                    : Colors.blue,
                          ),
                          child: index < 3 || index > (2400 ~/ 48) - 4
                              ? Container(
                                  margin: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey.shade100,
                                  ),
                                )
                              : index > (2400 ~/ 120)
                                  ? Center(
                                      child: Text(
                                        (index - 2).toString(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    )
                                  : const Center(
                                      child: Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      ),
                                    ),
                        ),
                      ),
                      itemCount: 2400 ~/ 48,
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).padding.top),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                            text: '₹',
                            style: TextStyle(
                              fontFamily: 'Product Sans',
                              fontSize: 24,
                              fontWeight: FontWeight.normal,
                              color: Color.fromRGBO(60, 64, 67, 1),
                            ),
                            children: [
                              TextSpan(
                                text: '30',
                                style: TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: '\nTotal rewards',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              titlePadding: EdgeInsetsDirectional.only(
                bottom: innerBoxIsScrolled ? 16 : 80,
              ),
              title: innerBoxIsScrolled
                  ? const Text(
                      '₹30 Total rewards',
                      style: TextStyle(
                        fontFamily: 'Product Sans',
                        fontWeight: FontWeight.normal,
                        color: Color.fromRGBO(60, 64, 67, 1),
                      ),
                    )
                  : null,
            ),
            actions: const [
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
            physics: const ClampingScrollPhysics(),
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
