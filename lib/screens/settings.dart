import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsLayout extends StatelessWidget {
  SettingsLayout();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SettingsList(
	  lightBackgroundColor: Theme.of(context).bottomAppBarColor,
	  darkBackgroundColor: Theme.of(context).bottomAppBarColor,
      sections: [
        SettingsSection(
          title: 'General',
          tiles: [
            SettingsTile(
              title: 'Theme',
              subtitle: 'Dark',
              leading: Icon(Icons.palette),
              onPressed: (BuildContext context) {},
            ),
            SettingsTile(
              title: 'Language',
              subtitle: 'English',
              leading: Icon(Icons.language),
              onPressed: (BuildContext context) {},
            )
          ],
        ),
        SettingsSection(
          title: 'Notifications',
          tiles: [
            SettingsTile.switchTile(
              title: 'Enable Notifications',
              enabled: false,
              leading: Icon(Icons.notifications_active),
              switchValue: false,
              onToggle: (value) {},
            ),
          ],
        ),
        SettingsSection(
          title: 'Security',
          tiles: [
            SettingsTile.switchTile(
              title: 'Lock app in background',
              leading: Icon(Icons.phonelink_lock),
              switchValue: false,
              onToggle: (bool value) {},
            ),
            SettingsTile.switchTile(
                title: 'Use fingerprint',
                subtitle: 'Allow application to access stored fingerprint IDs.',
                leading: Icon(Icons.fingerprint),
                onToggle: (bool value) {},
                switchValue: false),
          ],
        ),
        SettingsSection(
          title: 'Account',
          tiles: [
            SettingsTile(
                title: 'Delete Account', leading: Icon(Icons.exit_to_app)),
          ],
        ),
        SettingsSection(
          title: 'Help',
          tiles: [
            SettingsTile(title: 'Invite Friends', leading: Icon(Icons.phone)),
            SettingsTile(title: 'Help Center', leading: Icon(Icons.email)),
            SettingsTile(
                title: 'About', leading: Icon(Icons.collections_bookmark)),
          ],
        ),
      ],
    ));
  }
}
