// ignore_for_file: non_constant_identifier_names
import 'package:lib_x/lib_x.dart';

double _DefaultIconSize = 30;
Color _DefaultIconColor = black;

class _DefaultIcon extends StatelessWidget {
  final IconData icon;
  final double? size;
  final Color? color;
  const _DefaultIcon({Key? key, required this.icon, this.size, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: size ?? _DefaultIconSize,
      color: color ?? _DefaultIconColor,
    );
  }
}

// A collection of basic icons functions with size & color options

// material home icon
Widget homeIcon({double? size, Color? color}) => _DefaultIcon(
      icon: Icons.home_filled,
      color: color,
      size: size,
    );

// material drawer icon
Widget drawerIcon({double? size, Color? color}) => _DefaultIcon(
      icon: Icons.menu_rounded,
      color: color,
      size: size,
    );

// clock icon
Widget clockIcon({double? size, Color? color}) => _DefaultIcon(
      icon: Icons.schedule,
      color: color,
      size: size,
    );

// stacked users cards
Widget usersIcon({double? size, Color? color}) => _DefaultIcon(
      icon: Icons.recent_actors,
      color: color,
      size: size,
    );

// a person icon
Widget personIcon({double? size, Color? color}) => _DefaultIcon(
      icon: Icons.person,
      color: color,
      size: size,
    );

// gear icon
Widget settingsIcon({double? size, Color? color}) => _DefaultIcon(
      icon: Icons.settings,
      color: color,
      size: size,
    );

// search icon
Widget searchIcon({double? size, Color? color}) => _DefaultIcon(
      icon: Icons.search,
      color: color,
      size: size,
    );

// plus icon
Widget plusIcon({double? size, Color? color}) => _DefaultIcon(
      icon: Icons.add_rounded,
      color: color,
      size: size,
    );

// plus solid icon
Widget plusSolidIcon({double? size, Color? color}) => _DefaultIcon(
      icon: Icons.add_circle,
      color: color,
      size: size,
    );

// minus icon
Widget minusIcon({double? size, Color? color}) => _DefaultIcon(
      icon: Icons.remove,
      color: color,
      size: size,
    );

// minus solid icon
Widget minusSolidIcon({double? size, Color? color}) => _DefaultIcon(
      icon: Icons.remove_circle,
      color: color,
      size: size,
    );

// x icon
Widget closeIcon({double? size, Color? color}) => _DefaultIcon(
      icon: Icons.close_rounded,
      color: color,
      size: size,
    );

// check icon
Widget checkIcon({double? size, Color? color}) => _DefaultIcon(
      icon: Icons.done,
      color: color,
      size: size,
    );

// pen icon
Widget editIcon({double? size, Color? color}) => _DefaultIcon(
      icon: Icons.edit,
      color: color,
      size: size,
    );

// recycle bin icon
Widget deleteIcon({double? size, Color? color}) => _DefaultIcon(
      icon: Icons.delete_rounded,
      color: color,
      size: size,
    );

// upload icon
Widget uploadIcon({double? size, Color? color}) => _DefaultIcon(
      icon: Icons.file_upload_rounded,
      color: color,
      size: size,
    );

// unckecked checkbox icon
Widget checkBoxOffIcon({double? size, Color? color}) => _DefaultIcon(
      icon: Icons.check_box_outline_blank,
      color: color,
      size: size,
    );

// checked checkbox icon
Widget checkBoxOnIcon({double? size, Color? color}) => _DefaultIcon(
      icon: Icons.check_box_outlined,
      color: color,
      size: size,
    );

// switch on icon
Widget switchOnIcon({double? size, Color? color}) => _DefaultIcon(
      icon: Icons.toggle_on,
      color: color,
      size: size,
    );

// switch off icon
Widget switchOffIcon({double? size, Color? color}) => _DefaultIcon(
      icon: Icons.toggle_off,
      color: color,
      size: size,
    );

// outline star icon
Widget starOffIcon({double? size, Color? color}) => _DefaultIcon(
      icon: Icons.star_border,
      color: color,
      size: size,
    );

// solid star icon
Widget starOnIcon({double? size, Color? color}) => _DefaultIcon(
      icon: Icons.star,
      color: color,
      size: size,
    );

// bell off icon
Widget bellOffIcon({double? size, Color? color}) => _DefaultIcon(
      icon: Icons.notifications_off_rounded,
      color: color,
      size: size,
    );

// bell solid icon
Widget bellOnIcon({double? size, Color? color}) => _DefaultIcon(
      icon: Icons.notifications,
      color: color,
      size: size,
    );

// hash sign icon
Widget hashIcon({double? size, Color? color}) => _DefaultIcon(
      icon: Icons.tag_rounded,
      color: color,
      size: size,
    );

// share icon
Widget shareIcon({double? size, Color? color}) => _DefaultIcon(
      icon: Icons.share_rounded,
      color: color,
      size: size,
    );

// link icon
Widget linkIcon({double? size, Color? color}) => _DefaultIcon(
      icon: Icons.link,
      color: color,
      size: size,
    );

// @ sign icon
Widget atIcon({double? size, Color? color}) => _DefaultIcon(
      icon: Icons.alternate_email_rounded,
      color: color,
      size: size,
    );

// block icon
Widget blockIcon({double? size, Color? color}) => _DefaultIcon(
      icon: Icons.block_outlined,
      color: color,
      size: size,
    );

// flag icon
Widget flagIcon({double? size, Color? color}) => _DefaultIcon(
      icon: Icons.flag,
      color: color,
      size: size,
    );

// solid paper plan icon
Widget sendSolidIcon({double? size, Color? color}) => _DefaultIcon(
      icon: FontAwesomeIcons.solidPaperPlane,
      color: color,
      size: size,
    );

// outline paper plan icon
Widget sendOutLinedIcon({double? size, Color? color}) => _DefaultIcon(
      icon: FontAwesomeIcons.paperPlane,
      color: color,
      size: size,
    );
