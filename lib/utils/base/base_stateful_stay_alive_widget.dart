import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseStatefulWidgetStayAlive<T extends StatefulWidget> extends State<T> with AutomaticKeepAliveClientMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  String screenName = "UnnamedScreen";
  bool isUseAppBar = true;
  bool hasBackButton = false;
  bool resizeToAvoidBottomInset = true;
  final double desktopBreakPoint = 900;

  @override
  bool get wantKeepAlive => true;

  @required
  Widget generateBody();

  @required
  List<BlocProvider> getListBloc(BuildContext context);

  Widget? generateBottomBar() => null;
  Widget? generateSideBar() => null;
  String getTitleLabel() => "";

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _provideBlocProvider(
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isDesktop = constraints.maxWidth >= desktopBreakPoint;

          return Scaffold(
            key: scaffoldKey,
            resizeToAvoidBottomInset: resizeToAvoidBottomInset,
            appBar: (isUseAppBar && !isDesktop) ? _generateAppBar() : null,
            body: isDesktop
                ? Row(
              children: [
                Expanded(child: _buildContent()),
                if (generateSideBar() != null) _buildGlassSidebar(),
              ],
            )
                : _buildContent(),
            bottomNavigationBar: !isDesktop ? generateBottomBar() : null,
          );
        },
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(child: generateBody()),
    );
  }

  Widget _buildGlassSidebar() {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          width: 280,
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.white.withOpacity(0.4)
                : Colors.black.withOpacity(0.4),
            border: Border(
              left: BorderSide(color: Colors.white.withOpacity(0.2), width: 0.5),
            ),
          ),
          child: generateSideBar(),
        ),
      ),
    );
  }

  PreferredSizeWidget _generateAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(getTitleLabel(), style: const TextStyle(fontWeight: FontWeight.bold)),
      centerTitle: true,
      leading: hasBackButton ? const BackButton() : null,
    );
  }

  Widget _provideBlocProvider({required Widget child}) {
    final providers = getListBloc(context);
    return providers.isEmpty
        ? child
        : MultiBlocProvider(providers: providers, child: child);
  }
}