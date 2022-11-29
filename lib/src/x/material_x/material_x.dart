import 'package:lib_x/lib_x.dart';

class MaterialX extends StatelessWidget {
  final MaterialApp materialApp;
  final RouteMap routeMap;

  const MaterialX({
    super.key,
    required this.materialApp,
    required this.routeMap,
  });

  Widget _materialBuilder(ThemeMode? mode) {
    return OverlaySupport.global(
      child: MaterialApp.router(
        title: materialApp.title,
        color: materialApp.color,
        theme: materialApp.theme,
        darkTheme: materialApp.darkTheme,
        highContrastTheme: materialApp.highContrastTheme,
        highContrastDarkTheme: materialApp.highContrastDarkTheme,
        themeMode: mode, // the reactive property
        locale: materialApp.locale,
        localeListResolutionCallback: materialApp.localeListResolutionCallback,
        localeResolutionCallback: materialApp.localeResolutionCallback,
        localizationsDelegates: materialApp.localizationsDelegates,
        supportedLocales: materialApp.supportedLocales,
        debugShowMaterialGrid: materialApp.debugShowMaterialGrid,
        showPerformanceOverlay: materialApp.showPerformanceOverlay,
        checkerboardRasterCacheImages:
            materialApp.checkerboardRasterCacheImages,
        checkerboardOffscreenLayers: materialApp.checkerboardOffscreenLayers,
        showSemanticsDebugger: materialApp.showSemanticsDebugger,
        debugShowCheckedModeBanner: materialApp.debugShowCheckedModeBanner,
        shortcuts: materialApp.shortcuts,
        actions: materialApp.actions,
        restorationScopeId: materialApp.restorationScopeId,
        scrollBehavior: materialApp.scrollBehavior,
        useInheritedMediaQuery: materialApp.useInheritedMediaQuery,
        routeInformationParser: X.routeParser,
        routerDelegate: X.routerDelegate,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    X.config(
      window: WidgetsBinding.instance.window,
      app: materialApp,
      routeMap: routeMap,
    );

    return materialApp.theme != null && materialApp.darkTheme != null
        ? ReactiveBuilder<ThemeMode>(
            controller: X.themeMode,
            builder: _materialBuilder,
          )
        : _materialBuilder(materialApp.themeMode);
  }
}
