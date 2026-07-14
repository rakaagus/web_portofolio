import 'dart:ui';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_portofolio/presentation/bloc/loading/initial_loading.dart';
import 'package:web_portofolio/presentation/bloc/loading/page_transition.dart';

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
  static bool _hasDoneInitialLoad = false;

  bool _isInitialLoading = false;
  bool _isPageTransitionLoading = _hasDoneInitialLoad;
  double _loadingProgressValue = 0.0;
  bool _isExitingPage = false;
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
      _isInitialLoading = true;
      _startLoadingSimulation(isInitial: true);
    } else {
      _startLoadingSimulation(isInitial: false);
    }
  }

  void _startLoadingSimulation({required bool isInitial}) {
    final duration = isInitial ? const Duration(milliseconds: 39) : const Duration(milliseconds: 10);
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
            _hasDoneInitialLoad = true;
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
    _loadingTimer?.cancel();
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
    final colorTheme = Theme.of(context).colorScheme;
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
                _buildContent(),
                Positioned.fill(
                  child: PremiumPageTransitionOverlay(
                    isLoading: _isPageTransitionLoading || _isExitingPage,
                    color: colorTheme.onSurface,
                  ),
                ),
                _buildAnimatedSidebar(isDesktop),
                Positioned(
                  right: isDesktop ? 30 : 25,
                  bottom: isDesktop ? 40 : 110,
                  child: _buildBackToTopButton(isDesktop),
                ),
                _buildFloatingAppBar(isDesktop),
                _buildAnimatedBottomBar(isDesktop),
              ],
            ),
            bottomNavigationBar: null,
          );
        },
      ),
    );
  }

  Widget _buildContent() {
    if (_isInitialLoading) {
      return PremiumLoadingWrapper(
        onComplete: () {
          setState(() {
            _isInitialLoading = false;
          });
        },
        child: generateBody(),
      );
    }
    return generateBody();
  }

  Widget _buildFloatingAppBar(bool isDesktop) {
    if (!isUseAppBar) return const SizedBox.shrink();

    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bool isHiding = _isInitialLoading || _isPageTransitionLoading;

    double topPosition = 20;
    if (isHiding) {
      topPosition = -120;
    } else if (!isAppBarVisible) {
      topPosition = -100;
    }

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 650),
      curve: Curves.easeOutBack,
      top: topPosition,
      left: isDesktop ? 20 : 15,
      right: isDesktop ? (generateSideBar() != null ? 100 : 20) : 15,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 400),
        opacity: isHiding ? 0.0 : 1.0,
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
      ),
    );
  }

  Widget _buildAnimatedSidebar(bool isDesktop) {
    final sidebar = generateSideBar();
    if (sidebar == null || !isDesktop) return const SizedBox.shrink();

    final bool isHiding = _isInitialLoading || _isPageTransitionLoading;

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 650),
      curve: Curves.easeOutBack,
      right: isHiding ? -120 : 0,
      top: 0,
      bottom: 0,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 450),
        opacity: isHiding ? 0.0 : 1.0,
        child: sidebar,
      ),
    );
  }

  Widget _buildAnimatedBottomBar(bool isDesktop) {
    final bottomBar = generateBottomBar();
    if (bottomBar == null || isDesktop) return const SizedBox.shrink();

    final bool isHiding = _isInitialLoading || _isPageTransitionLoading;

    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: AnimatedSlide(
        offset: isHiding ? const Offset(0, 1.5) : const Offset(0, 0),
        duration: const Duration(milliseconds: 650),
        curve: Curves.easeOutBack,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 400),
          opacity: isHiding ? 0.0 : 1.0,
          child: SafeArea(
            top: false,
            child: bottomBar,
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

  void customNavigateTo(BuildContext context, String url, {Object? arguments}) {
    setState(() {
      _isExitingPage = true;
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted) return;
      Navigator.pushNamed(
        context,
        url,
        arguments: arguments,
      ).then((_) {
        if (mounted) {
          setState(() {
            _isExitingPage = false;
          });
        }
      });
    });
  }

  Widget _provideBlocProvider({required Widget child}) {
    final providers = getListBloc(context);
    return providers.isEmpty
        ? child
        : MultiBlocProvider(providers: providers, child: child);
  }
}