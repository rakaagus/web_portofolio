import 'package:flutter/cupertino.dart';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_portofolio/utils/base/base_stateful_widget.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends BaseStatefulWidget<LoadingScreen> {
  double _progressValue = 0.0;
  late Timer _timer;

  @override
  String get screenName => "Loading Page";

  @override
  bool get isAppBarVisible => false;

  @override
  void initState() {
    super.initState();
    _startLoadingSimulation();
  }

  void _startLoadingSimulation() {
    const duration = Duration(milliseconds: 50);
    const totalSteps = 100;
    int currentStep = 0;

    _timer = Timer.periodic(duration, (timer) {
      setState(() {
        currentStep++;
        _progressValue = currentStep / totalSteps;
      });

      if (currentStep >= totalSteps) {
        timer.cancel();
        _navigateToMain();
      }
    });
  }

  void _navigateToMain() {
    Navigator.pushReplacementNamed(context, "/home");
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  List<BlocProvider> getListBloc(BuildContext context) => [];

  @override
  Widget generateBody() {
    return Container(
      color: const Color(0xFFF8FAFC),
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: 'logo',
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    )
                  ],
                ),
                child: const FlutterLogo(size: 80),
              ),
            ),
            const SizedBox(height: 48),
            SizedBox(
              width: 280,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: LinearProgressIndicator(
                      value: _progressValue,
                      backgroundColor: const Color(0xFFE0E7FF),
                      color: Theme.of(context).primaryColor,
                      minHeight: 10,
                    ),
                  ),
                  const SizedBox(height: 16),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: _progressValue > 0.1 ? 1.0 : 0.0,
                    child: Text(
                      "Crafting Your Experience...",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF64748B),
                        letterSpacing: 0.5,
                        fontFamily: 'PJS'
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}