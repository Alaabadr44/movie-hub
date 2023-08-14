import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_bloc_observer.dart';
import 'app_life_cycle_manager.dart';
import 'config/routes/routes.dart';
import 'config/theme/app_themes.dart';
import 'core/blocs/app-network-manger-cubit/app_network_manger_bloc.dart';
import 'core/widgets/app_network_manger_widget.dart';
import 'features/movies/domain/repository/movie_repository.dart';
import 'features/movies/presentation/home/pages/screen/movies_home_view.dart';
import 'injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  Bloc.observer = AppBlocObserver();

  runApp(const MyApp());

  await sl<MovieRepository>().getGenres();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppNetworkMangerCubit>(
          create: (_) => sl()..listenOnStatusChange(),
        ),
      ],
      // create: (context) => sl()..add(const GetRemoteArticles()),

      child: AppLifeCycleManager(
        child: ScreenUtilInit(
          useInheritedMediaQuery: true,
          designSize: const Size(187.5, 450),
          builder: (context, child) => const AppWidget(),
        ),
      ),
    );
  }
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme(),
      onGenerateRoute: AppRoutes.onGenerateRoutes,
      home: const AppNetworkMangerWidget(child: MoviesHomeView()),
    );
  }
}
