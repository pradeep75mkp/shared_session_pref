# SharedSessionPref plugin
<?code-excerpt path-base="example/lib"?>

[![pub package](https://img.shields.io/badge/shared_session_pref-0.0.1-blue.svg
)]

Wraps platform-specific persistent storage for simple data
 
Data will be  persist to sessionStorage asynchronously,
 

Supported data types are `int`, `double`, `bool`, `String` and `List<String>`.

|              | Web  | 
|-------------|------| 
| **Support** |  Any | 

## Usage

## Examples
Here are small examples that show you how to use the API.

### SharedSessionPref

#### Write data
<?code-excerpt "readme_excerpts.dart (Write)"?>
```dart
// Obtain shared preferences.
final SharedSessionPref prefs = await SharedSessionPref.getInstance();

// Save an integer value to 'counter' key.
await prefs.setInt('counter', 10);
// Save an boolean value to 'repeat' key.
await prefs.setBool('repeat', true);
// Save an double value to 'decimal' key.
await prefs.setDouble('decimal', 1.5);
// Save an String value to 'action' key.
await prefs.setString('action', 'Start');
// Save an list of strings to 'items' key.
await prefs.setStringList('items', <String>['Earth', 'Moon', 'Sun']);
```

#### Read data
<?code-excerpt "readme_excerpts.dart (Read)"?>
```dart
// Try reading data from the 'counter' key. If it doesn't exist, returns null.
final int? counter = prefs.getInt('counter');
// Try reading data from the 'repeat' key. If it doesn't exist, returns null.
final bool? repeat = prefs.getBool('repeat');
// Try reading data from the 'decimal' key. If it doesn't exist, returns null.
final double? decimal = prefs.getDouble('decimal');
// Try reading data from the 'action' key. If it doesn't exist, returns null.
final String? action = prefs.getString('action');
// Try reading data from the 'items' key. If it doesn't exist, returns null.
final List<String>? items = prefs.getStringList('items');
```

#### Remove an entry
<?code-excerpt "readme_excerpts.dart (Clear)"?>
```dart
// Remove data for the 'counter' key.
await prefs.remove('counter');
```
 
 
### Storage location by platform

| Platform | SharedSessionPref |
| :--- | :--- |
| Web | SessionStorage |
 