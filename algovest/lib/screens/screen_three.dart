import 'package:flutter/material.dart';

class ScreenThree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Enable Notifications'),
            trailing: Switch(
              value: false, // This should be linked to a state management solution
              onChanged: (bool value) {
                // Placeholder function to toggle notifications
              },
            ),
          ),
          ListTile(
            title: Text('Dark Mode'),
            trailing: Switch(
              value: false, // This should be linked to a state management solution
              onChanged: (bool value) {
                // Placeholder function to toggle dark mode
              },
            ),
          ),
          ListTile(
            title: Text('Volume Control'),
            subtitle: Slider(
              value: 50, // This should be linked to a state management solution
              min: 0,
              max: 100,
              divisions: 10,
              onChanged: (double value) {
                // Placeholder function to adjust volume
              },
            ),
          ),
          ListTile(
            title: Text('Language'),
            subtitle: Text('English'),
            onTap: () {
              // Placeholder function for language selection
            },
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            title: Text('About'),
            onTap: () {
              // Placeholder function for displaying about information
            },
          ),
        ],
      ),
    );
  }
}
