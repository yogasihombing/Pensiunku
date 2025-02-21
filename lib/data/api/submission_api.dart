
import 'package:dio/dio.dart';
import 'package:pensiunku/data/api/base_api.dart';


class SubmissionApi extends BaseApi {
  bool bypassPengajuan = false; // TODO: Set to true to bypass pengajuan
  Dio dio = Dio();

  Future<Response> uploadWajah(String token, String selfieFile) async {
    String url = 'https://api.pensiunku.id/new.php/uploadWajah';

    FormData formData = FormData();

    formData.files.add(
      MapEntry(
        'foto_selfie',
        await MultipartFile.fromFile(selfieFile, filename: 'selfie.jpg'),
      ),
    );

    formData.fields.add(MapEntry('nama_foto_selfie', 'selfie.jpg'));

    return await dio.post(
      url,
      data: formData,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }
}


// import 'dart:developer';

// import 'package:dio/dio.dart';
// import 'package:intl/intl.dart';
// import 'package:pensiunku/data/api/base_api.dart';
// import 'package:pensiunku/data/api/simulation_api.dart';
// import 'package:pensiunku/model/bank_model.dart';
// import 'package:pensiunku/model/employment_info_form_model.dart';
// import 'package:pensiunku/model/simulation_form_model.dart';
// import 'package:pensiunku/model/submission_model.dart';
// import 'package:pensiunku/util/api_util.dart';

// class SubmissionApi extends BaseApi {
//   bool bypassPengajuan = false; // TODO: Set to true to bypass pengajuan

//   Future<Response> getAll(String token) {
//     return httpGet(
//       '/pengajuan',
//       options: ApiUtil.getTokenOptions(token),
//     );
//   }

//   Future<Response> createPegawaiAktif(
//     String token,
//     PegawaiAktifFormModel formModel,
//     BankModel bankModel,
//   ) {
//     var data = SimulationApi().preparePegawaiAktifForm(formModel);
//     data['nama_bank'] = bankModel.logo;
//     if (bypassPengajuan) {
//       data['bypass_pengajuan'] = true;
//     }
//     log(data.toString());
//     return httpPost(
//       '/pengajuan',
//       data: data,
//       options: ApiUtil.getTokenOptions(token),
//     );
//   }

//   Future<Response> createPensiun(
//     String token,
//     PensiunFormModel formModel,
//     BankModel bankModel,
//   ) {
//     var data = SimulationApi().preparePensiunForm(formModel);
//     data['nama_bank'] = bankModel.logo;
//     if (bypassPengajuan) {
//       data['bypass_pengajuan'] = true;
//     }
//     log(data.toString());
//     return httpPost(
//       '/pengajuan',
//       data: data,
//       options: ApiUtil.getTokenOptions(token),
//     );
//   }

//   Future<Response> createPraPensiun(
//     String token,
//     PraPensiunFormModel formModel,
//     BankModel bankModel,
//   ) {
//     var data = SimulationApi().preparePraPensiunForm(formModel);
//     data['nama_bank'] = bankModel.logo;
//     if (bypassPengajuan) {
//       data['bypass_pengajuan'] = true;
//     }
//     log(data.toString());
//     return httpPost(
//       '/pengajuan',
//       data: data,
//       options: ApiUtil.getTokenOptions(token),
//     );
//   }

//   Future<Response> createPlatinum(
//     String token,
//     PlatinumFormModel formModel,
//     BankModel bankModel,
//   ) {
//     var data = SimulationApi().preparePlatinumForm(formModel);
//     data['nama_bank'] = bankModel.logo;
//     if (bypassPengajuan) {
//       data['bypass_pengajuan'] = true;
//     }
//     log(data.toString());
//     return httpPost(
//       '/pengajuan',
//       data: data,
//       options: ApiUtil.getTokenOptions(token),
//     );
//   }

//   Future<Response> uploadKtp(
//     String token,
//     SubmissionModel submissionModel,
//     String ktpFile,
//   ) async {
//     final dataMap = {
//       "id": submissionModel.id,
//       "foto_ktp": await MultipartFile.fromFile(ktpFile, filename: "ktp.jpg"),
//       'nama_ktp': submissionModel.nameKtp,
//       'nik_ktp': submissionModel.nikKtp,
//       'alamat_ktp': submissionModel.addressKtp,
//       'pekerjaan_ktp': submissionModel.jobKtp,
//       'tanggal_lahir_ktp': submissionModel.birthDateKtp != null
//           ? DateFormat('yyyy-MM-dd').format(submissionModel.birthDateKtp!)
//           : null,
//     };
//     log(dataMap.toString());
//     FormData data = FormData.fromMap(dataMap);
//     return httpPost(
//       '/pengajuan/update',
//       data: data,
//       options: ApiUtil.getTokenOptions(token),
//     );
//   }

//   Future<Response> uploadSelfie(
//     String token,
//     SubmissionModel submissionModel,
//     String selfieFile,
//   ) async {
//     FormData data = FormData.fromMap({
//       "id": submissionModel.id,
//       "foto_selfie":
//           await MultipartFile.fromFile(selfieFile, filename: "selfie.jpg"),
//     });
//     log(data.toString());
//     return httpPost(
//       '/pengajuan/update',
//       data: data,
//       options: ApiUtil.getTokenOptions(token),
//     );
//   }

//   Future<Response> uploadEmploymentInfo(
//     String token,
//     SubmissionModel submissionModel,
//     EmploymentInfoFormModel employmentInfoFormModel,
//   ) async {
//     var dataMap = {
//       "id": submissionModel.id,
//       "instansi": employmentInfoFormModel.institution?.text,
//       "nama_instansi":
//           employmentInfoFormModel.institutionName?.isNotEmpty == true
//               ? employmentInfoFormModel.institutionName
//               : "",
//       "nip": employmentInfoFormModel.nip?.isNotEmpty == true
//           ? employmentInfoFormModel.nip
//           : "",
//       "golongan": employmentInfoFormModel.group?.text,
//       "estimasi_gaji": employmentInfoFormModel.salary ?? 0,
//       "instansi_pensiun": employmentInfoFormModel.retirementInstitution?.text,
//       "tmt_pensiun": employmentInfoFormModel.tmtRetirement != null
//           ? DateFormat('yyyy-MM-dd')
//               .format(employmentInfoFormModel.tmtRetirement!)
//           : null,
//     };
//     FormData data = FormData.fromMap(dataMap);
//     log(dataMap.toString());
//     return httpPost(
//       '/pengajuan/update',
//       data: data,
//       options: ApiUtil.getTokenOptions(token),
//     );
//   }

//   Future<Response> submitSubmission(
//     String token,
//     SubmissionModel submissionModel,
//   ) async {
//     var dataMap = {
//       "id": submissionModel.id,
//     };
//     FormData data = FormData.fromMap(dataMap);
//     log(dataMap.toString());
//     return httpPost(
//       '/pengajuan/submit',
//       data: data,
//       options: ApiUtil.getTokenOptions(token),
//     );
//   }

//   Future<Response> getSubmissionCheck(String token) {
//     return httpGet(
//       '/pengajuan/chek',
//       options: ApiUtil.getTokenOptions(token),
//     );
//   }
// }
