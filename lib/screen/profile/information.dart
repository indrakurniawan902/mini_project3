part of 'pages.dart';

class InformationPage extends StatelessWidget {
  const InformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Information'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const Text(
            'This is place one stop solution for you need!.\nWELCOME TO INDIECOMMERCE!',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
