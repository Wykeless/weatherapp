import 'package:clima/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:clima/services/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with TickerProviderStateMixin {
  bool isLoading = true;
  late AnimationController animatedController;

  @override
  void initState() {
    super.initState();
    initAnimationController();
    getLocationData();
  }

  void initAnimationController() {
    animatedController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1200,
      ),
    );
  }

  void getLocationData() async {
    var weatherData = await WeatherModel().getLocationWeather();
    animatedController.dispose();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LocationScreen(
          weatherData: weatherData,
        ),
      ),
    );

    Navigator.pushReplacementNamed(
      context,
      '/locationScreen',
      arguments: weatherData,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2c292c),
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 150.0,
          controller: animatedController,
        ),
      ),
    );
  }
}
