import 'dart:ui';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseStatefulWidget<T extends StatefulWidget> extends State<T> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final double desktopBreakPoint = 900;
  String screenName = "UnnamedScreen";
  bool isUseAppBar = true;
  bool hasBackButton = false;
  bool resizeToAvoidBottomInset = true;
  bool appBarUseBackIcon = false;

  late ScrollController baseScrollController;
  bool isAppBarVisible = true;
  double _lastScrollOffset = 0.0;

  bool showBackToTop = false;

  // ========================================================
  // STATE MANAGEMENT UNTUK 2 JENIS LOADING
  // ========================================================
  // Variabel static ini akan bertahan selama tab browser tidak di-refresh total
  static bool _hasDoneInitialLoad = false;

  bool _isInitialLoading = false;
  bool _isPageTransitionLoading = false;
  double _loadingProgressValue = 0.0;
  Timer? _loadingTimer;

  @override
  void initState() {
    super.initState();
    baseScrollController = ScrollController();
    baseScrollController.addListener(_baseScrollListener);

    _determineLoadingType();
  }

  void _determineLoadingType() {
    if (!_hasDoneInitialLoad) {
      // 1. INITIAL LOADING (Pertama kali buka atau ketika web di-refresh total)
      _isInitialLoading = true;
      _startLoadingSimulation(isInitial: true);
    } else {
      // 2. TRANSITION LOADING (Hanya dipicu saat pindah rute/halaman internal via menu)
      _isPageTransitionLoading = true;
      _startLoadingSimulation(isInitial: false);
    }
  }

  void _startLoadingSimulation({required bool isInitial}) {
    // Jika hanya transisi halaman internal, durasi dibuat super cepat (instant & responsif)
    final duration = isInitial ? const Duration(milliseconds: 15) : const Duration(milliseconds: 3);
    const totalSteps = 100;
    int currentStep = 0;

    _loadingTimer = Timer.periodic(duration, (timer) {
      if (!mounted) return;
      setState(() {
        currentStep++;
        _loadingProgressValue = currentStep / totalSteps;
      });

      if (currentStep >= totalSteps) {
        timer.cancel();
        setState(() {
          if (isInitial) {
            _isInitialLoading = false;
            _hasDoneInitialLoad = true; // Kunci agar loading besar tidak terulang saat navigasi biasa
          } else {
            _isPageTransitionLoading = false;
          }
        });
      }
    });
  }

  void _baseScrollListener() {
    double screenHeight = MediaQuery.of(context).size.height;

    if (baseScrollController.offset <= 0) {
      if (!isAppBarVisible) setState(() => isAppBarVisible = true);
      return;
    }

    if (baseScrollController.offset > screenHeight * 0.5 && !showBackToTop) {
      setState(() => showBackToTop = true);
    } else if (baseScrollController.offset <= screenHeight * 0.5 && showBackToTop) {
      setState(() => showBackToTop = false);
    }

    if (baseScrollController.offset > _lastScrollOffset && isAppBarVisible) {
      setState(() => isAppBarVisible = false);
    } else if (baseScrollController.offset < _lastScrollOffset && !isAppBarVisible) {
      setState(() => isAppBarVisible = true);
    }
    _lastScrollOffset = baseScrollController.offset;
  }

  @override
  void dispose() {
    baseScrollController.dispose();
    _loadingTimer?.cancel(); // Mencegah memory leak akibat timer yang masih berjalan
    super.dispose();
  }

  @required
  Widget generateBody();

  @required
  List<BlocProvider> getListBloc(BuildContext context);

  Widget? generateBottomBar() => null;
  Widget? generateSideBar() => null;
  String getTitleLabel() => "";
  Widget? getRightAction() => null;
  Widget? getLeftIcon() => null;

  @override
  Widget build(BuildContext context) {
    return _provideBlocProvider(
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isDesktop = constraints.maxWidth >= desktopBreakPoint;
          return Scaffold(
            key: scaffoldKey,
            extendBody: true,
            extendBodyBehindAppBar: true,
            resizeToAvoidBottomInset: resizeToAvoidBottomInset,
            appBar: null,
            body: Stack(
              children: [
                Positioned.fill(child: _buildContent()),
                if (_isPageTransitionLoading)
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: SafeArea(
                      child: LinearProgressIndicator(
                        value: _loadingProgressValue,
                        backgroundColor: Colors.transparent,
                        color: Theme.of(context).primaryColor,
                        minHeight: 4,
                      ),
                    ),
                  ),
                if (!_isInitialLoading && isDesktop && generateSideBar() != null)
                  Positioned(
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: generateSideBar()!,
                  ),
                Positioned(
                  right: isDesktop ? 30 : 25,
                  bottom: isDesktop ? 40 : 110,
                  child: _buildBackToTopButton(isDesktop),
                ),
                if (!_isInitialLoading && isUseAppBar)
                  _buildFloatingAppBar(isDesktop),
              ],
            ),
            bottomNavigationBar: (!_isInitialLoading && !isDesktop) ? generateBottomBar() : null,
          );
        },
      ),
    );
  }

  Widget _buildContent() {
    if (_isInitialLoading) {
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
                        value: _loadingProgressValue,
                        backgroundColor: const Color(0xFFE0E7FF),
                        color: Theme.of(context).primaryColor,
                        minHeight: 10,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Crafting Your Experience...",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF64748B),
                        letterSpacing: 0.5,
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
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: generateBody(),
    );
  }

  Widget _buildFloatingAppBar(bool isDesktop) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      top: isAppBarVisible ? 20 : -100,
      left: isDesktop ? 20 : 15,
      right: isDesktop ? (generateSideBar() != null ? 100 : 20) : 15,
      child: Container(
        alignment: Alignment.center,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              height: 60,
              constraints: const BoxConstraints(maxWidth: 1600),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: (isDark ? Colors.black : Colors.white).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isDark ? Colors.white.withOpacity(0.1) : Colors.white.withOpacity(0.4),
                  width: 1.5,
                ),
              ),
              child: Row(
                children: [
                  if (appBarUseBackIcon)
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: isDark ? Colors.white : Colors.black87,
                        size: 20,
                      ),
                      onPressed: () => Navigator.maybePop(context),
                    )
                  else if (getLeftIcon() != null)
                    getLeftIcon()!,

                  const SizedBox(width: 5),
                  const FlutterLogo(size: 30),
                  const SizedBox(width: 10),
                  Text(
                    getTitleLabel(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  if (getRightAction() != null) getRightAction()!,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackToTopButton(bool isDesktop) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedScale(
      duration: const Duration(milliseconds: 300),
      scale: showBackToTop ? 1.0 : 0.0,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: showBackToTop ? 1.0 : 0.0,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isDark ? 0.3 : 0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              )
            ],
          ),
          child: GestureDetector(
            onTap: () {
              baseScrollController.animateTo(0,
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(isDark ? 0.08 : 0.2),
                        Colors.white.withOpacity(isDark ? 0.02 : 0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.white.withOpacity(isDark ? 0.15 : 0.4),
                      width: 1.2,
                    ),
                  ),
                  child: Icon(
                    Icons.keyboard_arrow_up_rounded,
                    color: isDark ? Colors.white : Colors.black87,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _provideBlocProvider({required Widget child}) {
    final providers = getListBloc(context);
    return providers.isEmpty
        ? child
        : MultiBlocProvider(providers: providers, child: child);
  }
}