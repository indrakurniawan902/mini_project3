// ignore_for_file: use_build_context_synchronously

part of 'pages.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    context.read<ProfileCubit>().getUserById();
    super.initState();
  }

  // Fungsi untuk menampilkan AlertDialog Log out
  Future<void> _showLogoutDialog() async {
    await Dialogs.materialDialog(
      msg: 'Are you sure you want to log out?',
      title: 'Log Out',
      color: Colors.white,
      context: context,
      actions: [
        IconsButton(
          onPressed: () {
            Navigator.pop(context);
          },
          text: 'Cancel',
          iconData: Icons.cancel,
          textStyle: const TextStyle(color: Colors.grey),
          iconColor: Colors.grey,
        ),
        IconsButton(
          onPressed: () async {
            // Tambahkan logika untuk melakukan logout di sini
            // Misalnya, panggil fungsi untuk menghapus sesi login, dll.
            // Kemudian tutup dialog
            // Remove data for the 'token' key.
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            await prefs.remove('token');
            Hive.box('favorites').clear();
            context.goNamed(AppRoutes.nrLogin);
          },
          text: 'Log Out',
          iconData: Icons.exit_to_app,
          color: Colors.red,
          textStyle: const TextStyle(color: Colors.white),
          iconColor: Colors.white,
        ),
      ],
    );
  }

  // Fungsi untuk menampilkan AlertDialog maintenance
  Future<void> _showMaintenanceDialog() async {
    await Dialogs.materialDialog(
        msg: 'Feature not available, maintenance handle',
        title: 'Sorry!',
        color: Colors.white,
        context: context,
        actions: [
          IconsButton(
            onPressed: () {
              Navigator.pop(context);
            },
            text: 'Close',
            iconData: Icons.cancel,
            // color: Colors.red,
            textStyle: const TextStyle(color: Colors.red),
            iconColor: Colors.red,
          ),
        ]);
  }

  // build main
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is UserLoadedState) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(20.0),
              child: AppBar(),
            ),
            body: Container(
              // padding: const EdgeInsets.symmetric(horizontal: 8),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Profile',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                  ),
                  Text(
                    'Hi ${state.users.username!}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.normal),
                  ),
                  Text(
                    state.users.email!,
                    style: const TextStyle(fontSize: 13),
                  ),
                  Container(
                    height: 139,
                    // color: HexColor('#F8F8F8'),
                    margin: const EdgeInsets.only(top: 10),
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(248, 248, 248, 1),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.0),
                          topRight: Radius.circular(40.0)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ListTile(
                          leading: const CircleAvatar(
                            backgroundColor: Color.fromRGBO(160, 229, 72, 0.4),
                            child: Icon(
                              Icons.shopping_bag_outlined,
                            ),
                          ),
                          title: const Text(
                            'My purchase',
                            style: TextStyle(fontSize: 17),
                          ),
                          onTap: _showMaintenanceDialog,
                        ),
                        ListTile(
                          leading: const CircleAvatar(
                              backgroundColor:
                                  Color.fromRGBO(154, 193, 240, 0.4),
                              child: Icon(Icons.person_outline_rounded)),
                          title: const Text(
                            'Personal details and address',
                            style: TextStyle(fontSize: 17),
                          ),
                          onTap: _showMaintenanceDialog,
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.inbox_outlined),
                          title: const Text(
                            'Inbox',
                            style: TextStyle(fontSize: 18),
                          ),
                          onTap: _showMaintenanceDialog,
                        ),
                        ListTile(
                          leading: const Icon(Icons.settings_outlined),
                          title: const Text(
                            'Settings',
                            style: TextStyle(fontSize: 18),
                          ),
                          onTap: _showMaintenanceDialog,
                        ),
                        ListTile(
                          leading: const Icon(Icons.help_outline),
                          title: const Text(
                            'Help',
                            style: TextStyle(fontSize: 18),
                          ),
                          onTap: _showMaintenanceDialog,
                        ),
                        ListTile(
                            leading: const Icon(Icons.info_outline),
                            title: const Text(
                              'Information',
                              style: TextStyle(fontSize: 18),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const InformationPage()),
                              );
                            }),
                        ListTile(
                          leading: const Icon(Icons.logout, color: Colors.red),
                          title: const Text(
                            'Log out',
                            style: TextStyle(fontSize: 18, color: Colors.red),
                          ),
                          onTap: _showLogoutDialog,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        } else if (state is UserErrorState) {
          return Text(state.error);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
