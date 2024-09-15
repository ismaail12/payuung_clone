import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:payuung/bloc/auth/auth_bloc.dart';
import 'package:payuung/model/user.dart';
import 'package:payuung/service/user_services.dart';
import 'package:payuung/widgets/custom_button.dart';
import 'package:payuung/widgets/custom_datepicker.dart';
import 'package:payuung/widgets/custom_dropdown.dart';
import 'package:payuung/widgets/custom_formfield.dart';
import 'package:payuung/widgets/custom_outlined_btn.dart';
import 'package:payuung/widgets/step_indicator.dart';
import 'package:payuung/widgets/stepline.dart';

class PersonalInfoScreen extends StatefulWidget {
  final int? userId;

  const PersonalInfoScreen({super.key, this.userId});

  @override
  // ignore: library_private_types_in_public_api
  _PersonalInfoScreenState createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  int _currentStep = 0;

  final userService = UserService();
  // Controllers for Personal Data Form
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  String? _selectedGender;
  String? _selectedEducation;
  String? _selectedMarriageStatus;

  // Controllers for Address Form
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _addressKTPController = TextEditingController();
  String? _selectedProvince;

  // Controllers for Company Form
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _companyAddressController =
      TextEditingController();
  String? _selectedPosition;
  String? _selectedIncomeSource;
  String? _selectedAnnualIncome;
  final TextEditingController _bankBranchController = TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();
  final TextEditingController _accountOwnerController = TextEditingController();

  final personalDataFormKey = GlobalKey<FormState>();
  final addressFormKey = GlobalKey<FormState>();
  final companyFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.userId != null) {
      getCurrentDataUser();
    }
    super.initState();
  }

  void getCurrentDataUser() async {
    User? user;

    if (widget.userId != null) {
      user = await userService.getUserById(widget.userId!);
    }

    DateTime? birthDate = user?.birthDate;
    String? birthDateFormated;
    if (birthDate != null) {
      birthDateFormated = DateFormat('dd MMMM yyyy').format(birthDate);
    }

    //personal data
    _nameController.text = user?.fullName ?? "";
    _birthDateController.text = birthDateFormated ?? "";
    _emailController.text = user?.email ?? "";
    _phoneController.text = user?.phoneNumber ?? "";

    setState(() {
      _selectedGender = user?.gender ?? "";
      _selectedEducation = user?.education ?? "";
      _selectedMarriageStatus = user?.maritalStatus ?? "";
    });
  }

  List<Widget> _buildSteps() {
    return [
      _buildStep(step: 1),
      _buildStep(step: 2),
      _buildStep(step: 3),
    ];
  }

  Widget _buildStep({required int step}) {
    bool isActive = step <= _currentStep + 1;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _currentStep = step - 1;
                });
              },
              child: StepIndicator(isActive: isActive, step: step),
            ),
            if (step < 3)
              StepLine(
                isActive: step <= _currentStep,
                color: Theme.of(context).primaryColor,
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildStepContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_currentStep > 0)
            CustomOutlinedButton(
              text: 'Kembali',
              onPressed: () => setState(() => _currentStep--),
              isPrimary: false,
            ),
          if (_currentStep < 2)
            CustomButton(
              text: 'Selanjutnya',
              isPrimary: _currentStep == 0,
              onPressed: () async {
                if (_currentStep == 0) {
                  if (personalDataFormKey.currentState!.validate()) {
                    final user = User(
                        fullName: _nameController.text,
                        birthDate: DateFormat("dd MMMM yyyy")
                            .parse(_birthDateController.text),
                        gender: _selectedGender,
                        email: _emailController.text,
                        phoneNumber: _phoneController.text,
                        education: _selectedEducation,
                        maritalStatus: _selectedMarriageStatus);

                    if (widget.userId != null) {
                      context
                          .read<AuthBloc>()
                          .add(UpdateUser(user, widget.userId!));
                                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('User Berhasil diupdate'),
                      ));
                    } else {
                      context.read<AuthBloc>().add(CreateUser(user));

                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('User Berhasil ditambahkan'),
                      ));
                    }

                    setState(() {
                      _currentStep++;
                    });
                  }
                }

                if (_currentStep == 1) {
                  if (addressFormKey.currentState!.validate()) {
 
                    setState(() {
                      _currentStep++;
                    });
                  }
                }
              },
            ),
          if (_currentStep == 2)
            CustomButton(
              text: 'Submit',
              isPrimary: false,
              onPressed: () {
                // if (personalDataFormKey.currentState!.validate()) {
                //   // Handle form submission
                // }
              },
            ),
        ],
      ),
    );
  }

  Widget _buildPersonalDataForm() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomFormField(
            label: 'Nama Lengkap',
            errorMessage: 'Kolom ini wajib diisi',
            controller: _nameController,
            isRequired: true,
          ),
          CustomDatePicker(
            label: 'Tanggal Lahir',
            errorMessage: 'Kolom ini wajib diisi',
            controller: _birthDateController,
            isRequired: true,
          ),
          CustomDropdown(
            label: 'Jenis Kelamin',
            errorMessage: 'Kolom ini wajib diisi',
            items: const ['Laki-laki', 'Perempuan'],
            value: _selectedGender,
            onChanged: (value) {
              setState(() {
                _selectedGender = value;
              });
            },
            isRequired: true,
          ),
          CustomFormField(
            label: 'Email',
            errorMessage: 'Email tidak valid',
            controller: _emailController,
            isRequired: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Kolom ini wajib diisi';
              } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return 'Email tidak valid';
              }
              return null;
            },
            textInputType: TextInputType.emailAddress,
          ),
          CustomFormField(
            label: 'Nomor Telepon',
            errorMessage: 'Kolom ini wajib diisi',
            controller: _phoneController,
            isRequired: true,
            textInputType: TextInputType.phone,
          ),
          CustomDropdown(
            label: 'Pendidikan',
            errorMessage: 'Kolom ini wajib diisi',
            items: const [
              'SD',
              'SMP',
              'SMA',
              'D1',
              'D2',
              'D3',
              'S1',
              'S2',
              'S3'
            ],
            value: _selectedEducation,
            onChanged: (value) {
              setState(() {
                _selectedEducation = value;
              });
            },
          ),
          CustomDropdown(
            label: 'Status Pernikahan',
            errorMessage: 'Kolom ini wajib diisi',
            items: const ['Belum Kawin', 'Kawin', 'Janda', 'Duda'],
            value: _selectedMarriageStatus,
            onChanged: (value) {
              setState(() {
                _selectedMarriageStatus = value;
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informasi Pribadi'),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // Dismiss keyboard
        },
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Form(
            key: _currentStep == 0 ? personalDataFormKey : _currentStep == 1 ? addressFormKey : companyFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildSteps(),
                ),
                if (_currentStep == 0) _buildPersonalDataForm(),
                if (_currentStep == 1) _buildAddressForm(),
                if (_currentStep == 2) _buildCompanyForm(),
                _buildStepContent(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAddressForm() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomFormField(
            label: 'nik',
            errorMessage: 'Kolom ini wajib diisi',
            controller: _nikController,
            isRequired: true,
          ),
          CustomFormField(
            label: 'alamat sesuai ktp',
            errorMessage: 'Kolom ini wajib diisi',
            controller: _addressKTPController,
            isRequired: true,
          ),
          CustomDropdown(
            label: 'Provinsi',
            errorMessage: 'Kolom ini wajib diisi',
            items: const ['Jawa Barat', 'DKI Jakarta', 'Jawa Tengah'],
            value: _selectedProvince,
            onChanged: (value) {
              setState(() {
                _selectedProvince = value;
              });
            },
            isRequired: true,
          ),
        ],
      ),
    );
  }

  Widget _buildCompanyForm() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomFormField(
            label: 'Nama usaha / perusahaan',
            errorMessage: 'Kolom ini wajib diisi',
            controller: _companyNameController,
          ),
          CustomFormField(
            label: 'alamat usaha / perusahaan',
            errorMessage: 'Kolom ini wajib diisi',
            controller: _companyAddressController,
          ),
          CustomDropdown(
            label: 'Jabatan',
            errorMessage: 'Kolom ini wajib diisi',
            items: const [
              'Non-Staf',
              'Staf',
              'Supervisor',
              'Manajer',
              'Direktur',
              'Lainnya'
            ],
            value: _selectedPosition,
            onChanged: (value) {
              setState(() {
                _selectedPosition = value;
              });
            },
          ),
          CustomDropdown(
            label: 'Sumber Pendapatan',
            errorMessage: 'Kolom ini wajib diisi',
            items: const [
              'Keuntungan Bisnis',
              'Gaji',
              'Bunga Tabungan',
              'Warisan',
              'Dana dari orang tua atau anak',
              'Undian',
              'Keuntungan Investasi',
              'Lainnya'
            ],
            value: _selectedIncomeSource,
            onChanged: (value) {
              setState(() {
                _selectedIncomeSource = value;
              });
            },
          ),
          CustomDropdown(
            label: 'Pendapatan Kotor Pertahun',
            errorMessage: 'Kolom ini wajib diisi',
            items: const [
              '< 10 Juta',
              '10 - 50 Juta',
              '50 - 100 Juta',
              '100 - 500 Juta',
              '500 - 1 Milyar',
              ' > 1 Milyar'
            ],
            value: _selectedAnnualIncome,
            onChanged: (value) {
              setState(() {
                _selectedAnnualIncome = value;
              });
            },
          ),
          CustomFormField(
            label: 'Cabang Bank',
            errorMessage: 'Kolom ini wajib diisi',
            controller: _bankBranchController,
          ),
          CustomFormField(
            label: 'No rekening',
            errorMessage: 'Kolom ini wajib diisi',
            controller: _accountNumberController,
          ),
          CustomFormField(
            label: 'nama pemiliki rekening',
            errorMessage: 'Kolom ini wajib diisi',
            controller: _accountOwnerController,
          ),
        ],
      ),
    );
  }
}



