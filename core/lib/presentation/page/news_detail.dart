import 'package:core/models/news.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../style/colors.dart';

class NewsDetail extends StatefulWidget {
  final News news;

  const NewsDetail(this.news, {super.key});

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16,),
              Text(
                widget.news.title!,
                style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: kRichBlack),
              ),
              const SizedBox(height: 24,),
              Image.network(widget.news.imageUrl!, width: double.infinity, height: 220, fit: BoxFit.cover,),
              const SizedBox(height: 16,),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                widget.news.content!,
                style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: kRichBlack),
                textAlign: TextAlign.justify,
              ),),
              const SizedBox(height: 16,),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  widget.news.author!,
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: kRichBlack),
                ),
              ),),
              const SizedBox(height: 16,),
            ],
          ),
        ),
      ),
    );
  }
}