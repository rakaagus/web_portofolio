import 'dart:ui';

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

  @override
  void initState() {
    super.initState();
    baseScrollController = ScrollController();
    baseScrollController.addListener(_baseScrollListener);
  }

  void _baseScrollListener() {
    if (baseScrollController.offset <= 0) {
      if (!isAppBarVisible) setState(() => isAppBarVisible = true);
      return;
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
                Positioned.fill(
                  child: isDesktop
                      ? Row(
                    children: [
                      Expanded(child: _buildContent()),
                      if (generateSideBar() != null)
                        generateSideBar()!, // Sidebar Kanan
                    ],
                  )
                      : _buildContent(),
                ),
                if (isUseAppBar) _buildFloatingAppBar(isDesktop),
              ],
            ),
            bottomNavigationBar: !isDesktop ? generateBottomBar() : null,
          );
        },
      ),
    );
  }

  Widget _buildContent() => generateBody();

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
              padding: const EdgeInsets.symmetric(horizontal: 10), // Padding dikecilkan agar tombol tidak terlalu menjorok
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
                        Icons.arrow_back_ios_new_rounded, // Icon ala macOS/iOS
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

  Widget _provideBlocProvider({required Widget child}) {
    final providers =  getListBloc(context);
    return providers.isEmpty
        ? child
        : MultiBlocProvider(providers: providers, child: child);
  }
}