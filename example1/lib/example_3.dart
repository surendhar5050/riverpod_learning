import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum City { newYork, tokoyo, tamilnadu, serbia }

typedef WeatherEmoji = String;

Future<WeatherEmoji> getWeather(City city) {
  return Future.delayed(
    Duration(seconds: 1),
    () =>
        {
          City.newYork: "Rainy",
          City.tokoyo: "Winter",
          City.tamilnadu: "Spring",
          City.serbia: "Sunny",
        }[city]!,
  );
}

final currentCityProvider = StateProvider<City?>((ref) {
  return null;
});

final weatherProvider = FutureProvider((ref) {
  var city = ref.watch(currentCityProvider);

  if (city != null) {
    return getWeather(city);
  } else {
    return "Start to Fetch the weather";
  }
});

final class WeatherExample extends ConsumerWidget {
  const WeatherExample({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weathereprovider = ref.watch(weatherProvider);
    return Scaffold(
      appBar: AppBar(title: Text("Weather App")),
      body: Column(
        children: [
          weathereprovider.when(
            data: (data) => Text(data.toString()),
            error: (error, stackTrace) => Text(error.toString()),
            loading: () => LinearProgressIndicator(),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: City.values.length,

              itemBuilder: (context, index) {
                var cities = City.values[index];
                final selected = ref.watch(currentCityProvider) == cities;

                return ListTile(
                  onTap: () {
                    ref.read(currentCityProvider.notifier).state = cities;
                  },
                  title: Text(cities.name),
                  trailing: selected ? Icon(Icons.done) : null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
