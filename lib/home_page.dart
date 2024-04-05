import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'counter_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Locale _currentLocale = const Locale('en');

  @override
  Widget build(BuildContext context) {
    return Consumer<CounterModel>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(
            widget.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: PopupMenuButton<Locale>(
                onSelected: (Locale locale) {
                  setState(() {
                    _currentLocale = locale;
                  });
                },
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem(
                      value: const Locale('en'),
                      child: Text('English'),
                    ),
                    PopupMenuItem(
                      value: const Locale('my'),
                      child: Text('Malay'),
                    ),
                  ];
                },
              ),
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Localizations.override(
              context: context,
              locale: _currentLocale,
              child: Builder(builder: (context) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        AppLocalizations.of(context)!.welcome,
                        style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 50),
                      Text(
                        AppLocalizations.of(context)!.buttonCount,
                        style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black38),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          value.count.toString(),
                          style: const TextStyle(fontSize: 100, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final counter = context.read<CounterModel>();
            counter.increment();
          },
          tooltip: 'Add',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
