import 'package:get/get.dart';
import '../iletisim/iletisim_controller.dart';
import '../Callendar/CalendarController.dart';
import '../Profil/profil_controller.dart';

class BottomNavigationController extends GetxController {
  var selectedIndex = 0.obs;

  void onItemTapped(int index) {
    selectedIndex.value = index;
    switch (index) {
      case 1:
        final calendarController = Get.find<CalendarController>();
        //calendarController.refreshData();
        break;
      case 2:
        final iletisimController = Get.find<IletisimController>();
        iletisimController.refreshAnimalList();
        break;
      case 3:
        final profilController = Get.find<ProfilController>();
       // profilController.refreshProfileData();
        break;
      default:
      // Ana sayfa veya diğer sayfalar için gerekli işlemleri burada yapabilirsiniz.
        break;
    }
  }
}
