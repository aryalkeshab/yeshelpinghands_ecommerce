import 'package:yeshelpinghand/core/presentation/resources/colors.dart';
import 'package:yeshelpinghand/core/presentation/widgets/base_widget.dart';
import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  AboutUsScreen();

  @override
  Widget build(BuildContext context) {
    return HookBaseWidget(builder: (context, config, theme) {
      return Scaffold(
          appBar: AppBar(
            title: const Text('About Us'),
          ),
          body: Builder(builder: (context) {
            return Padding(padding: const EdgeInsets.all(16.0), child: MyTextWidget());
          }));
    });
  }
}

class MyTextWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: 12.0),
        Text(
          'Why Choose Us',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: primaryColor),
        ),
        SizedBox(height: 8.0),
        Text(
          'We do not buy from the open market & traders.',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          textAlign: TextAlign.justify,
          'Bringing you the pure and authentic collections of natural and classic cashmere product, made with love from differently-abled people of Nepal!',
          style: TextStyle(fontSize: 16.0),
        ),
        SizedBox(height: 16.0),
        Text(
          textAlign: TextAlign.justify,
          'Pokhara is lovely, a beautiful place, and a visit to Yes Helping Hands (YHH) Handicrafts should be a part of a visit. YHH for over 8 years has supported, trained and employed deaf, blind and disabled people. Money raised also goes to Deaf and Blind schools, and the relevant associations in Nepal.',
          style: TextStyle(fontSize: 16.0),
        ),
      ],
    );
  }
}
