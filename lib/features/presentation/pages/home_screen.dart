import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/app_route_observer.dart';
import 'package:nevis/constants/size_utils.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/features/presentation/bloc/cart_screen/cart_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/favorite_products_screen/favorite_products_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/home_screen/home_screen_bloc.dart';
import 'package:nevis/features/presentation/bloc/route_observer/route_observer_bloc.dart';
import 'package:nevis/features/presentation/bloc/search_screen/search_screen_bloc.dart';
import 'package:nevis/features/presentation/widgets/bottom_navigation_bar_tile.dart';
import 'package:nevis/features/presentation/widgets/main_screen/internet_no_internet_connection_widget.dart';
import 'package:nevis/features/presentation/widgets/search_screen/search_screen.dart';
import 'package:nevis/locator_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => sl<FavoriteProductsScreenBloc>()
              ..add(LoadFavoriteProductsEvent())),
        BlocProvider(create: (context) => CartScreenBloc(getCartProducts: sl())
            // ..update(),
            ),
        BlocProvider(
          create: (context) => HomeScreenBloc(context: context),
        ),
        BlocProvider(
          create: (context) => sl<SearchScreenBloc>(),
        ),
        BlocProvider(
          create: (context) => RouteObserverBloc(),
        ),
      ],
      child: BlocBuilder<RouteObserverBloc, RouteObserverState>(
        builder: (context, state) {
          final RouteObserverBloc observerBloc =
              context.read<RouteObserverBloc>();
          return BlocBuilder<HomeScreenBloc, HomeScreenState>(
            builder: (context, homeState) {
              final HomeScreenBloc bloc = context.read<HomeScreenBloc>();
              final int selectedIndex = bloc.selectedPageIndex;

              return BlocBuilder<SearchScreenBloc, SearchScreenState>(
                builder: (searchContext, searchState) {
                  //final SearchScreenBloc searchBloc =
                  //    context.read<SearchScreenBloc>();

                  return WillPopScope(
                    onWillPop: () async {
                      if (selectedIndex == 0) {
                        SystemChannels.platform
                            .invokeMethod('SystemNavigator.pop');
                      } else {
                        final isFirstRouteInCurrentTab = !await bloc
                            .navigatorKeys[selectedIndex].currentState!
                            .maybePop();
                        if (isFirstRouteInCurrentTab) {
                          bloc.onChangePage(0);
                          return false;
                        }
                      }
                      return false;
                    },
                    child: Scaffold(
                      backgroundColor: UiConstants.backgroundColor,
                      appBar: AppBar(
                          toolbarHeight: 0,
                          backgroundColor: UiConstants.whiteColor,
                          surfaceTintColor: Colors.transparent),
                      body: SafeArea(
                        child: homeState is InternetUnavailable
                            ? InternetNoInternetConnectionWidget()
                            : Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Column(
                                    children: [
                                      Expanded(
                                        child: PageStorage(
                                          bucket: bucket,
                                          child: IndexedStack(
                                            index: selectedIndex,
                                            children:
                                                bloc.screens.map((screen) {
                                              final int screenIndex =
                                                  bloc.screens.indexOf(screen);
                                              return Navigator(
                                                key: bloc
                                                    .navigatorKeys[screenIndex],
                                                observers: [
                                                  AppRouteObserver(observerBloc)
                                                ],
                                                onGenerateRoute: (settings) {
                                                  return MaterialPageRoute(
                                                      builder: (context) =>
                                                          screen);
                                                },
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (searchState.isExpanded)
                                    Positioned(
                                      top: 50.h,
                                      child: SearchScreen(
                                        homeContext: context,
                                        onRedirect: () async => FocusScope.of(
                                                bloc
                                                    .navigatorKeys[
                                                        bloc.selectedPageIndex]
                                                    .currentContext!)
                                            .requestFocus(
                                          FocusNode(),
                                        ),
                                      ),
                                    ),
                                  Positioned(
                                    child: Container(
                                      padding: getMarginOrPadding(
                                          left: 20, right: 20),
                                      height: 70.h,
                                      decoration: BoxDecoration(
                                        color: UiConstants.whiteColor,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: List.generate(
                                          bloc.screens.length,
                                          (index) => BottomNavigationBarTile(
                                              icon: bloc.iconsPaths[index],
                                              title: bloc.iconsNames[index],
                                              countChatMessage:
                                                  index == 2 ? 99 : null,
                                              onTap: () {
                                                bloc
                                                    .navigatorKeys[
                                                        selectedIndex]
                                                    .currentState!
                                                    .popUntil((route) =>
                                                        route.isFirst);
                                                bloc.onChangePage(index);
                                              },
                                              isActive: selectedIndex == index),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
