// ignore_for_file: non_constant_identifier_names
import 'package:lib_x/lib_x.dart';

double DefaultIconSize = 30;
Color DefaultIconColor = black;

class DefaultIcon extends StatelessWidget {
  final IconData icon;
  final double? size;
  final Color? color;
  const DefaultIcon({Key? key, required this.icon, this.size, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: size ?? DefaultIconSize,
      color: color ?? DefaultIconColor,
    );
  }
}

Widget homeIcon({double? size, Color? color}) => DefaultIcon(
      icon: Icons.home_filled,
      color: color,
      size: size,
    );

Widget drawerIcon({double? size, Color? color}) => DefaultIcon(
      icon: Icons.menu_rounded,
      color: color,
      size: size,
    );

Widget clockIcon({double? size, Color? color}) => DefaultIcon(
      icon: Icons.schedule,
      color: color,
      size: size,
    );

Widget usersIcon({double? size, Color? color}) => DefaultIcon(
      icon: Icons.recent_actors,
      color: color,
      size: size,
    );

Widget personIcon({double? size, Color? color}) => DefaultIcon(
      icon: Icons.person,
      color: color,
      size: size,
    );

Widget settingsIcon({double? size, Color? color}) => DefaultIcon(
      icon: Icons.settings,
      color: color,
      size: size,
    );

Widget searchIcon({double? size, Color? color}) => DefaultIcon(
      icon: Icons.search,
      color: color,
      size: size,
    );

Widget plusIcon({double? size, Color? color}) => DefaultIcon(
      icon: Icons.add_rounded,
      color: color,
      size: size,
    );

Widget plusSolidIcon({double? size, Color? color}) => DefaultIcon(
      icon: Icons.add_circle,
      color: color,
      size: size,
    );

Widget minusIcon({double? size, Color? color}) => DefaultIcon(
      icon: Icons.remove,
      color: color,
      size: size,
    );

Widget minusSolidIcon({double? size, Color? color}) => DefaultIcon(
      icon: Icons.remove_circle,
      color: color,
      size: size,
    );

Widget closeIcon({double? size, Color? color}) => DefaultIcon(
      icon: Icons.close_rounded,
      color: color,
      size: size,
    );

Widget checkIcon({double? size, Color? color}) => DefaultIcon(
      icon: Icons.done,
      color: color,
      size: size,
    );

Widget editIcon({double? size, Color? color}) => DefaultIcon(
      icon: Icons.edit,
      color: color,
      size: size,
    );

Widget deleteIcon({double? size, Color? color}) => DefaultIcon(
      icon: Icons.delete_rounded,
      color: color,
      size: size,
    );

Widget uploadIcon({double? size, Color? color}) => DefaultIcon(
      icon: Icons.file_upload_rounded,
      color: color,
      size: size,
    );

Widget checkBoxOffIcon({double? size, Color? color}) => DefaultIcon(
      icon: Icons.check_box_outline_blank,
      color: color,
      size: size,
    );

Widget checkBoxOnIcon({double? size, Color? color}) => DefaultIcon(
      icon: Icons.check_box_outlined,
      color: color,
      size: size,
    );

Widget switchOnIcon({double? size, Color? color}) => DefaultIcon(
      icon: Icons.toggle_on,
      color: color,
      size: size,
    );

Widget switchOffIcon({double? size, Color? color}) => DefaultIcon(
      icon: Icons.toggle_off,
      color: color,
      size: size,
    );

Widget starOffIcon({double? size, Color? color}) => DefaultIcon(
      icon: Icons.star_border,
      color: color,
      size: size,
    );

Widget starOnIcon({double? size, Color? color}) => DefaultIcon(
      icon: Icons.star,
      color: color,
      size: size,
    );

Widget bellOffIcon({double? size, Color? color}) => DefaultIcon(
      icon: Icons.notifications_off_rounded,
      color: color,
      size: size,
    );

Widget bellOnIcon({double? size, Color? color}) => DefaultIcon(
      icon: Icons.notifications,
      color: color,
      size: size,
    );

Widget hashIcon({double? size, Color? color}) => DefaultIcon(
      icon: Icons.tag_rounded,
      color: color,
      size: size,
    );

Widget shareIcon({double? size, Color? color}) => DefaultIcon(
      icon: Icons.share_rounded,
      color: color,
      size: size,
    );

Widget linkIcon({double? size, Color? color}) => DefaultIcon(
      icon: Icons.link,
      color: color,
      size: size,
    );

Widget atIcon({double? size, Color? color}) => DefaultIcon(
      icon: Icons.alternate_email_rounded,
      color: color,
      size: size,
    );

Widget blockIcon({double? size, Color? color}) => DefaultIcon(
      icon: Icons.block_outlined,
      color: color,
      size: size,
    );

Widget flagIcon({double? size, Color? color}) => DefaultIcon(
      icon: Icons.flag,
      color: color,
      size: size,
    );

Widget sendSolidIcon({double? size, Color? color}) => DefaultIcon(
      icon: FontAwesomeIcons.solidPaperPlane,
      color: color,
      size: size,
    );

Widget sendOutLinedIcon({double? size, Color? color}) => DefaultIcon(
      icon: FontAwesomeIcons.paperPlane,
      color: color,
      size: size,
    );
