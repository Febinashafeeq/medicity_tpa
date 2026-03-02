// ── TPA Model ─────────────────────────────────────────────────────────────────
class TpaModel {
  final String id;
  final String name;
  final String code;
  final String contactPerson;
  final String phone;
  final String city;
  final bool isActive;
  final int companyCount;

  const TpaModel({
    required this.id,
    required this.name,
    required this.code,
    required this.contactPerson,
    required this.phone,
    required this.city,
    required this.isActive,
    required this.companyCount,
  });

  factory TpaModel.fromMap(String id, Map<String, dynamic> map) {
    return TpaModel(
      id:            map['id']            ?? id,
      name:          map['name']          ?? '',
      code:          map['code']          ?? '',
      contactPerson: map['contactPerson'] ?? '',
      phone:         map['phone']         ?? '',
      city:          map['city']          ?? '',
      isActive:      map['isActive']      ?? true,
      companyCount:  map['companyCount']  ?? 0,
    );
  }

  Map<String, dynamic> toMap() => {
    'id':            id,
    'name':          name,
    'code':          code,
    'contactPerson': contactPerson,
    'phone':         phone,
    'city':          city,
    'isActive':      isActive,
    'companyCount':  companyCount,
  };
}

// ── Insurance Company Model ────────────────────────────────────────────────────
class InsuranceCompanyModel {
  final String id;
  final String tpaId;
  final String name;
  final String policyType;
  final String empanelmentNo;
  final String contactPerson;
  final String phone;
  final bool isActive;
  final int patientCount;

  const InsuranceCompanyModel({
    required this.id,
    required this.tpaId,
    required this.name,
    required this.policyType,
    required this.empanelmentNo,
    required this.contactPerson,
    required this.phone,
    required this.isActive,
    required this.patientCount,
  });

  factory InsuranceCompanyModel.fromMap(
      String id,
      Map<String, dynamic> map,
      ) {
    return InsuranceCompanyModel(
      id:             map['id']             ?? id,
      tpaId:          map['tpaId']          ?? '',
      name:           map['name']           ?? '',
      policyType:     map['policyType']     ?? '',
      empanelmentNo:  map['empanelmentNo']  ?? '',
      contactPerson:  map['contactPerson']  ?? '',
      phone:          map['phone']          ?? '',
      isActive:       map['isActive']       ?? true,
      patientCount:   map['patientCount']   ?? 0,
    );
  }

  Map<String, dynamic> toMap() => {
    'id':            id,
    'tpaId':         tpaId,
    'name':          name,
    'policyType':    policyType,
    'empanelmentNo': empanelmentNo,
    'contactPerson': contactPerson,
    'phone':         phone,
    'isActive':      isActive,
    'patientCount':  patientCount,
  };
}
// ── Patient Model ─────────────────────────────────────────────────────────────
class PatientModel {
  final String id;
  final String companyId;
  final String companyName;  // ← add
  final String tpaId;        // ← add
  final String tpaName;      // ← add
  final String name;
  final int age;
  final String gender;
  final String policyNo;
  final String cardNo;
  final String phone;
  final String address;
  final String visitType;

  const PatientModel({
    required this.id,
    required this.companyId,
    required this.companyName,
    required this.tpaId,
    required this.tpaName,
    required this.name,
    required this.age,
    required this.gender,
    required this.policyNo,
    required this.cardNo,
    required this.phone,
    required this.address,
    required this.visitType
  });

  factory PatientModel.fromMap(String id, Map<String, dynamic> map) {
    return PatientModel(
      id:          id,
      companyId:   map['companyId']   ?? '',
      companyName: map['companyName'] ?? '',
      tpaId:       map['tpaId']       ?? '',
      tpaName:     map['tpaName']     ?? '',
      name:        map['name']        ?? '',
      age:         map['age']         ?? 0,
      gender:      map['gender']      ?? '',
      policyNo:    map['policyNo']    ?? '',
      cardNo:      map['cardNo']      ?? '',
      phone:       map['phone']       ?? '',
      address:     map['address']     ?? '',
      visitType:   map['visitType']   ?? '',
    );
  }

  Map<String, dynamic> toMap() => {
    'id':          id,
    'companyId':   companyId,
    'companyName': companyName,
    'tpaId':       tpaId,
    'tpaName':     tpaName,
    'name':        name,
    'age':         age,
    'gender':      gender,
    'policyNo':    policyNo,
    'cardNo':      cardNo,
    'phone':       phone,
    'address':     address,
    'visitType':   visitType
  };
}

// ── Sample Collection Model ───────────────────────────────────────────────────
class SampleCollectionModel {
  final String id;
  final String patientId;
  final String companyId;
  final DateTime date;
  final String tests;
  final String sampleStatus;
  final double amount;
  final bool paymentReceived;
  final String invoiceNo;
  final String paymentMode;

  const SampleCollectionModel({
    required this.id,
    required this.patientId,
    required this.companyId,
    required this.date,
    required this.tests,
    required this.sampleStatus,
    required this.amount,
    required this.paymentReceived,
    required this.invoiceNo,
    required this.paymentMode,
  });

  SampleCollectionModel copyWith({
    bool? paymentReceived,
    String? invoiceNo,
    String? paymentMode,
    double? amount,
  }) {
    return SampleCollectionModel(
      id: id,
      patientId: patientId,
      companyId: companyId,
      date: date,
      tests: tests,
      sampleStatus: sampleStatus,
      amount: amount ?? this.amount,
      paymentReceived: paymentReceived ?? this.paymentReceived,
      invoiceNo: invoiceNo ?? this.invoiceNo,
      paymentMode: paymentMode ?? this.paymentMode,
    );
  }
}

// ── Dummy Data ────────────────────────────────────────────────────────────────
final List<TpaModel>              allTpas       = [];
final List<InsuranceCompanyModel> allCompanies  = [];
final List<PatientModel>          allPatients   = [];
List<SampleCollectionModel>       allCollections = [];