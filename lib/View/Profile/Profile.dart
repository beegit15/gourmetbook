import 'package:flutter/material.dart';
import 'package:gourmetbook/Providers/authProvider.dart';
import 'package:gourmetbook/generation/assets.gen.dart';
import 'package:gourmetbook/helpers/const.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<Auth>(context, listen: true);
    return SafeArea(
      child: Scaffold(
          body: Container(
        color: Colors.white54,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: ColorName.lightGrey,
                  maxRadius: 65,
                  child: Assets.svg.icProfile.svg(
                    // height: 18,
                    fit: BoxFit.fitWidth,
                    color: ColorName.black,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  authProvider.userModel!.displayName!,
                  style: const TextStyle(
                      fontWeight: FontWeight.w900, fontSize: 26),
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  authProvider.userModel!.userType.name,
                  style: const TextStyle(fontSize: 20),
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              child: Expanded(
                  child: Column(
                children: [
                  Card(
                    margin:
                        const EdgeInsets.only(left: 35, right: 35, bottom: 10),
                    color: Colors.white70,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    child: const ListTile(
                      leading: Icon(
                        Icons.privacy_tip_sharp,
                        color: Colors.black54,
                      ),
                      title: Text(
                        'Privacy',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Card(
                    color: Colors.white70,
                    margin:
                        const EdgeInsets.only(left: 35, right: 35, bottom: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    child: const ListTile(
                      leading: Icon(
                        Icons.history,
                        color: Colors.black54,
                      ),
                      title: Text(
                        'Purchase History',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Card(
                    color: Colors.white70,
                    margin:
                        const EdgeInsets.only(left: 35, right: 35, bottom: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    child: const ListTile(
                      leading: Icon(Icons.help_outline, color: Colors.black54),
                      title: Text(
                        'Help & Support',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Card(
                    color: Colors.white70,
                    margin:
                        const EdgeInsets.only(left: 35, right: 35, bottom: 10),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    child: InkWell(
                      onTap: () {
                        authProvider.signOut();
                      },
                      child: ListTile(
                        leading: Icon(
                          Icons.logout,
                          color: Colors.black54,
                        ),
                        title: Text(
                          'Logout',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios_outlined),
                      ),
                    ),
                  )
                ],
              )),
            )
          ],
        ),
      )),
    );
  }
}
