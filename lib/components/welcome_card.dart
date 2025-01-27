import 'package:flutter/material.dart';

class WelcomeCard extends StatelessWidget {
  const WelcomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 35.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Welcome back, ",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              Text(
                "Bavly!",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(24),
            width: double.infinity,
            height: 116,
            decoration: BoxDecoration(
              color: Color(0xff91b9f6),
              borderRadius: BorderRadius.circular(25),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/images/card_background.png"),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Manage your",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      "time well",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "Add you daily tasks to make your day better!",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Image.asset("assets/images/tasks.png")
              ],
            ),
          ),
        ],
      ),
    );
  }
}
