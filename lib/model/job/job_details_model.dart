import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_app/config/string/string_info.dart';
import 'package:student_app/config/string/string_price.dart';
import 'package:student_app/model/other/address.dart';

import '../../config/string/string_job.dart';
import '../users/user_detail.dart';

class JobDetailModel {
  String? idJobDetails;
  String? idJob;
  String? nameStore;
  String? quantily;
  String? jobDescription;
  String? require;
  String? right;
  String? idContact;
  Address? address;
  DocumentReference? doc;
  Contact? contact;

  JobDetailModel(
      {this.idJob,
      this.idJobDetails,
      this.nameStore,
      this.quantily,
      this.jobDescription,
      this.require,
      this.right,
      this.idContact,
      this.address});

  factory JobDetailModel.fromSnapshot(DocumentSnapshot snapshot) {
    JobDetailModel jobDetailsModel =
        JobDetailModel.fromJson(snapshot.data() as Map<String, dynamic>);
    jobDetailsModel.doc = snapshot.reference;
    return jobDetailsModel;
  }

  factory JobDetailModel.fromJson(Map<String, dynamic> responseData) {
    return JobDetailModel(
      idJob: responseData[Job.idJob].toString(),
      idJobDetails: responseData[Job.idJobDetails].toString(),
      nameStore: responseData[Job.nameStore],
      quantily: responseData[Job.quantily].toString(),
      jobDescription: responseData[Job.jobDescription],
      require: responseData[Job.require],
      right: responseData[Job.right].toString(),
      idContact: responseData[Job.contact].toString(),
      address: responseData[Job.address] is String
          ? Address.getString(responseData[Job.address])
          : (responseData[Job.address]) == null
              ? Address.getString(StringAddress.other)
              : Address.fromJson(responseData[Job.address]),
    );
  }
  Map<String, dynamic> toDynamic() {
    Map<String, dynamic> toData = {
      Job.address: address == null ? null : address!.toDynamic(),
      Job.idJob: idJob,
      Job.idJobDetails: idJobDetails,
      Job.nameStore: nameStore,
      Job.quantily: quantily,
      Job.jobDescription: jobDescription,
      Job.require: require,
      Job.right: right,
      Job.contact: idContact,
    };
    return toData;
  }
}
