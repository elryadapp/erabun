
class ApiEndPoints {
  static const baseUrl = 'https://earabun.sa/api/';

  //===========auth end points================================
  static const login = 'login';
  static const register = 'register';
  static const resetPassword = 'password/reset';
  static const sendResetPasswordEmail = 'password/email';
  static const logout = 'logout';
  static const verfiyMobile = 'examinationCenter/verfiyMobile';
  static const resendVerficationCode='examinationCenter/verfiyMobile/mobile/resendVerficationCode';
  static const resendNextVerficationCode='examinationCenter/verfiyMobile/mobile/resendNextVerficationCode';
  //===========appointment end points================================
static const appointments='appointments';
static const canceledAppointment='canceledAppointments';
  //===========reports end points================================
  static const reports='reports';
  static const examinationReport='examinationReport';
  //================cancel examination end points===================
  static const centerCancelExamination='centerCancelExamination';
static const cancelAppointment='cancelExamination';
//===================profile end points=========================
static const deleteMyAccount='delete_my_account';
static const  updateMobile='examinationCenter/updateMobile';
  static const reviews='reviews';
  static const profile='profile';
  static const editStatus='editStatus';
  static const updateInfo='updateInfo';
  static const dayes='dayes';
  static const cities='cities';
  static const termes='termsConditions';
  static const privacyPolicy='privacyPolicy';
  static const settings='settings';
  static const updateTimeTable='updateTimeTable';
  static const getTimeTable='getTimeTable';
static const appLink='get/link';

  //==================examination reports end points==========================
  static const scanQrCode='scanQrCode';
    static const confirmAttendance ='examination/confirmAttendance';
      static const uploadCarBodyImage='examinationReport/uploadCarBodyImage';
    static const getInsideCarReport='examinationReport/getInsideCarReport';
      static const storeInsideCarReport='examinationReport/storeInsideCarReport';
    static const getOutsideCarReport='examinationReport/getOutsideCarReport';
      static const storeOutsideCarReport='examinationReport/storeOutsideCarReport';
    static const getMechnicalCarReport='examinationReport/getMechnicalCarReport';
    static const storeMechnicalCarReport='examinationReport/storeMechnicalCarReport';
    static const finishReport='examinationReport/finishReport';


static const examinationReportPdf='examinationReportPdf';

  static const checkUserAvaliabality='find/user';



}
