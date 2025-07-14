import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/event_provider.dart';
import 'providers/cart_provider.dart';
import 'screens/event_list_screen.dart';

void main() {
  runApp(const TicketManorApp());
}

class TicketManorApp extends StatelessWidget {
  const TicketManorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EventProvider()..fetchEvents()), // Fetch events on app start
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp(
        title: 'TicketManor',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const EventListScreen(),
      ),
    );
  }
}
