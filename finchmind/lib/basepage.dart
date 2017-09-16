import 'package:flutter/material.dart';


abstract class BasePage extends StatefulWidget {
    void onAddFABClick();

    String pageName;
    IconData icon;

    BasePage(this.pageName, this.icon);
}