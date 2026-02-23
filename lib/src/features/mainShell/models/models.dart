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
}

// ── Patient Model ─────────────────────────────────────────────────────────────
class PatientModel {
  final String id;
  final String companyId;
  final String name;
  final int age;
  final String gender;
  final String policyNo;
  final String cardNo;
  final String phone;
  final String address;

  const PatientModel({
    required this.id,
    required this.companyId,
    required this.name,
    required this.age,
    required this.gender,
    required this.policyNo,
    required this.cardNo,
    required this.phone,
    required this.address,
  });
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
final List<TpaModel> allTpas = [
  const TpaModel(id: '1', name: 'Medi Assist TPA', code: 'MA001', contactPerson: 'Rajesh Kumar', phone: '9876543210', city: 'Bangalore', isActive: true, companyCount: 3),
  const TpaModel(id: '2', name: 'Health India TPA', code: 'HI002', contactPerson: 'Priya Sharma', phone: '9123456789', city: 'Mumbai', isActive: true, companyCount: 2),
  const TpaModel(id: '3', name: 'Vidal Health TPA', code: 'VH003', contactPerson: 'Arjun Nair', phone: '9988776655', city: 'Chennai', isActive: true, companyCount: 4),
  const TpaModel(id: '4', name: 'Family Health Plan', code: 'FH004', contactPerson: 'Meena Pillai', phone: '9445566778', city: 'Kozhikode', isActive: false, companyCount: 2),
];

final List<InsuranceCompanyModel> allCompanies = [
  const InsuranceCompanyModel(id: 'c1', tpaId: '1', name: 'Star Health Insurance', policyType: 'Group', empanelmentNo: 'EMP001', contactPerson: 'Suresh M', phone: '9001112222', isActive: true, patientCount: 24),
  const InsuranceCompanyModel(id: 'c2', tpaId: '1', name: 'HDFC ERGO Health', policyType: 'Corporate', empanelmentNo: 'EMP002', contactPerson: 'Kavitha R', phone: '9003334444', isActive: true, patientCount: 18),
  const InsuranceCompanyModel(id: 'c3', tpaId: '1', name: 'New India Assurance', policyType: 'Individual', empanelmentNo: 'EMP003', contactPerson: 'Vinod K', phone: '9005556666', isActive: false, patientCount: 9),
  const InsuranceCompanyModel(id: 'c4', tpaId: '2', name: 'United India Insurance', policyType: 'Group', empanelmentNo: 'EMP004', contactPerson: 'Anitha S', phone: '9007778888', isActive: true, patientCount: 31),
  const InsuranceCompanyModel(id: 'c5', tpaId: '2', name: 'Oriental Insurance', policyType: 'Corporate', empanelmentNo: 'EMP005', contactPerson: 'Deepak P', phone: '9009990000', isActive: true, patientCount: 12),
  const InsuranceCompanyModel(id: 'c6', tpaId: '3', name: 'Bajaj Allianz Health', policyType: 'Individual', empanelmentNo: 'EMP006', contactPerson: 'Rema T', phone: '9111222333', isActive: true, patientCount: 20),
  const InsuranceCompanyModel(id: 'c7', tpaId: '3', name: 'Niva Bupa Health', policyType: 'Group', empanelmentNo: 'EMP007', contactPerson: 'Hari L', phone: '9444555666', isActive: true, patientCount: 15),
  const InsuranceCompanyModel(id: 'c8', tpaId: '4', name: 'Care Health Insurance', policyType: 'Corporate', empanelmentNo: 'EMP008', contactPerson: 'Sona M', phone: '9777888999', isActive: true, patientCount: 8),
];

final List<PatientModel> allPatients = [
  const PatientModel(id: 'p1', companyId: 'c1', name: 'Arun Menon', age: 42, gender: 'Male', policyNo: 'POL001', cardNo: 'CRD001', phone: '9876500001', address: 'Kozhikode, Kerala'),
  const PatientModel(id: 'p2', companyId: 'c1', name: 'Divya Nair', age: 35, gender: 'Female', policyNo: 'POL002', cardNo: 'CRD002', phone: '9876500002', address: 'Malappuram, Kerala'),
  const PatientModel(id: 'p3', companyId: 'c2', name: 'Sreeraj KP', age: 58, gender: 'Male', policyNo: 'POL003', cardNo: 'CRD003', phone: '9876500003', address: 'Thrissur, Kerala'),
  const PatientModel(id: 'p4', companyId: 'c4', name: 'Lakshmi PS', age: 29, gender: 'Female', policyNo: 'POL004', cardNo: 'CRD004', phone: '9876500004', address: 'Kannur, Kerala'),
];

List<SampleCollectionModel> allCollections = [
  SampleCollectionModel(id: 'sc1', patientId: 'p1', companyId: 'c1', date: DateTime.now(), tests: 'CBC, LFT, RFT', sampleStatus: 'Collected', amount: 1500, paymentReceived: true, invoiceNo: 'INV-2025-001', paymentMode: 'Cash'),
  SampleCollectionModel(id: 'sc2', patientId: 'p2', companyId: 'c1', date: DateTime.now(), tests: 'Blood Sugar, HbA1c', sampleStatus: 'Processing', amount: 850, paymentReceived: false, invoiceNo: '', paymentMode: ''),
  SampleCollectionModel(id: 'sc3', patientId: 'p3', companyId: 'c2', date: DateTime.now(), tests: 'Thyroid Profile, Lipid Panel', sampleStatus: 'Reported', amount: 2200, paymentReceived: true, invoiceNo: 'INV-2025-002', paymentMode: 'NEFT'),
  SampleCollectionModel(id: 'sc4', patientId: 'p4', companyId: 'c4', date: DateTime.now().subtract(const Duration(days: 1)), tests: 'Urine Analysis', sampleStatus: 'Collected', amount: 400, paymentReceived: false, invoiceNo: '', paymentMode: ''),
];