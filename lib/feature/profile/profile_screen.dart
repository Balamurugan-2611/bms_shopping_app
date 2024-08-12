import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:bms_shopping_app/feature/auth/model/user_app.dart';
import 'package:bms_shopping_app/feature/profile/bloc/profile_bloc.dart';
import 'package:bms_shopping_app/resources/app_data.dart';
import 'package:bms_shopping_app/resources/resources.dart';
import 'package:bms_shopping_app/route/route_constants.dart';
import 'package:bms_shopping_app/widget/appbar.dart';
import 'package:bms_shopping_app/widget/loader_widget.dart';  // Fixed typo in import

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  double height;

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(GetCurrentUser());
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is LogoutFinished) {
          Navigator.pushReplacementNamed(context, RouteConstant.loginRoute);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: CommonAppBar(title: 'Profile'),
          body: _buildProfileContent(state),
        );
      },
    );
  }

  Widget _buildProfileContent(ProfileState state) {
    UserData? userData;
    if (state is GetCurrentUserFinish) {
      userData = state.userData;
    }
    return ListView(
      shrinkWrap: true,
      children: [
        Container(
          height: height * 0.3,
          color: Colors.blue,
          child: userData == null
              ? LoaderWidget()  // Fixed typo in widget name
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      userData.fullName,
                      style: headingTextWhite,
                    ),
                    Text(
                      userData.email,
                      style: whiteText,
                    ),
                  ],
                ),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemBuilder: (context, index) {
            var setting = AppSettings.values[index];
            return _buildFeatureRow(setting);
          },
          separatorBuilder: (BuildContext context, int index) => Divider(),
          itemCount: AppSettings.values.length,
        ),
      ],
    );
  }

  Widget _buildFeatureRow(AppSettings settings) {
    return InkWell(
      onTap: () {
        _handleSettingsAction(settings);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              settings.name,
              style: textMedium,
            ),
            IconButton(
              icon: Icon(Ionicons.ios_arrow_forward),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  void _handleSettingsAction(AppSettings settings) {
    if (settings == AppSettings.LOGOUT) {
      context.read<ProfileBloc>().add(LogoutEvent());
    }
  }
}
