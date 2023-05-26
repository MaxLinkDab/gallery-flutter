import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gallery/const.dart';

class ErrorList extends StatefulWidget {
  final ScrollController controller;

  const ErrorList({super.key, required this.controller});

  @override
  State<ErrorList> createState() => _ErrorListState();
}

class _ErrorListState extends State<ErrorList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SizedBox(
        height: MediaQuery.of(context).size.height - 200,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/svg/error.svg'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Oh shucks!', style: ThemeApp.textViewName),
              ),
              Text(
                'Slow or no internet connection.\nPlease check your internet settings',
                style: ThemeApp.textViewDescription,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
