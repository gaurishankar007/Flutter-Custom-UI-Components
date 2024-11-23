
# Flutter Cheat Sheet 📚

A handy reference for building Flutter apps efficiently.

---

## Widgets

### **Master Layouts**
Gives you a basic app layout to start with:
- ✅ **Scaffold**: Provides a default app structure.
- ✅ **SafeArea**: Ensures content is displayed within safe, visible areas.
- ✅ **AppBar**: Displays a header with title and actions.  
  **FloatingActionButton**: Adds a floating button for primary actions.
- ✅ **NavigationBar** & **BottomNavigationBar**: For navigation between major sections.
- ✅ **TabBarView** with **TabBar** and **DefaultTabController**: For tabbed navigation.
- ✅ **PageView**: Swiping between pages.
- ✅ **Navigation Drawer**: A side navigation menu.

### **Layouts**
Utilize these for flexible and responsive layouts:
- ✅ **SizedBox**
- ✅ **Column**
- ✅ **Row**
- ✅ **Wrap**
- ✅ **Stack**
- ✅ **Center**
- ✅ **Padding**
- ✅ **SingleChildScrollView**
- ✅ **ListView**
- ✅ **GridView**
- ✅ **Spacer**
- ✅ **Expanded**
- ✅ **Flexible**
- ✅ **FittedBox**
- ✅ **RotatedBox**
- ✅ **Align**
- ✅ **Positioned**

### **Visual Layouts**
Enhance visual appeal and structure:
- ✅ **Container**
- ✅ **ListTile**
- ✅ **GridTile**
- ✅ **GridTileBar**
- ✅ **Divider**
- ✅ **VerticalDivider**
- ✅ **Card**
- ✅ **Text**
- ✅ **Image**
- ✅ **Icon**
- ✅ **CircularProgressIndicator**
- ✅ **LinearProgressIndicator**
- ✅ **Badge**, **DataTable**
- ✅ **CircleAvatar**
- ✅ **BackdropFilter**
- ✅ **ClipRRect**

### **User Inputs**
Handle user interactions with these widgets:
- ✅ **ElevatedButton**
- ✅ **FilledButton**
- ✅ **OutlinedButton**
- ✅ **TextButton**
- ✅ **IconButton**
- ✅ **GestureDetector**
- ✅ **InkWell**
- ✅ **TextField**
- ✅ **TextFormField**
- ✅ **Form**
- ✅ **DropDownMenu**
- ✅ **DropDownButton**
- ✅ **PopUpMenuButton**
- ✅ **RadioButton**
- ✅ **Checkbox**
- ✅ **Switch**
- ✅ **Slider**
- ✅ **Chip**
- ✅ **ChoiceChip**
- ✅ **ToggleButton**
- ✅ **Visibility**
- ✅ **ExpansionTile**
- ✅ **Dismissible**

---

## Show
Use these methods to display various elements and dialogs:
- ✅ **showBottomSheet**
- ✅ **showModalBottomSheet**
- ✅ **showDatePicker**
- ✅ **showDateRangePicker**
- ✅ **showTimePicker**
- ✅ **showDialog**
- ✅ **showCupertinoDialog**
- ✅ **showCupertinoModalPopup**
- ✅ **showLicensePage**
- ✅ **showSearch**
- ✅ **showSnackBar** (use **ScaffoldMessenger**)
- ✅ **showMaterialBanner**

---

## Builders
Efficiently manage asynchronous data and layouts:
- ✅ **FutureBuilder**
- ✅ **StreamBuilder**
- ✅ **Builder**
- ✅ **LayoutBuilder** (use `MediaQuery.of(context).size`) for dynamic layouts.
- ✅ **OrientationBuilder** (use `MediaQuery.of(context).orientation`) for responsive designs.
- ✅ **ValueListenableBuilder** with **ValueNotifier** for state changes.

---

## State Management
Understand different state management techniques:
- ✅ **Stateless** vs **Stateful Widgets**: Decide between static or dynamic UIs.
- ✅ **setState**: Refresh the UI when state changes.
- ✅ **Popular State Management Solutions**:  
  - Provider  
  - Bloc
  - Riverpod
  - Mobx
  - Stacked

---

## Navigators
Efficient navigation between screens:
- ✅ **Navigator.pop**: Return to the previous screen.
- ✅ **Navigator.pushReplacement**: Replace the current screen.
- ✅ **Navigator.push**: Navigate to a new screen using **MaterialPageRoute**.

---

## Dart Basics
Essential concepts for Flutter development:
- ✅ **Data Types**: Strings, Ints, Doubles, Bools, Lists, Maps.
- ✅ **Functions**: Defining and using functions with arguments and conditions.
- ✅ **Classes**: Creating and using classes to structure your code.
- ✅ **Pass Data**: Methods to pass data between screens.
- ✅ **Null Safety**: Using `?`, `??`, and `!` to handle null values.

---

## Other Tips
Boost your productivity with these tips:
- ✅ **Auto const**: Use Visual Studio Code to automatically add `const` where possible.
- ✅ **Extensions and Shortcuts**: Utilize VS Code shortcuts like `Ctrl+B`, `Ctrl+J`, `Alt+Shift+F`, and more.
- ✅ **Start a New Project**: Use `flutter create` with proper organization.
- ✅ **Packages and Assets**: Manage dependencies with `pubspec.yaml` and organize assets like images and fonts.
- ✅ **Key Concepts**: Remember the hierarchical widget structure and naming conventions.
- ✅ **Change App Name**: Modify the app name in configuration files.
- ✅ **Debugging**: Understand and fix errors using the debug console and error messages.
- ✅ **Next Steps**: Integrate Firebase for authentication and database, and save data locally using **shared_preferences**.
