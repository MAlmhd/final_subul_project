import 'dart:typed_data';
import 'package:final_subul_project/core/utils/service_locator.dart';
import 'package:final_subul_project/features/get_shipments_in_the_way/domain/use_case/update_parcel_info_use_case/update_parcel_info_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:final_subul_project/core/theming/app_colors.dart'; // ملف الألوان الذي أعطيتني إياه
import 'package:final_subul_project/features/get_shipments_in_the_way/presentation/manager/update_parcel_info_cubit/update_parcel_info_cubit.dart';
// إذا تستخدم Service Locator:
// import 'package:final_subul_project/core/utils/service_locator.dart';

class UpdateParcelInfoScreen extends StatefulWidget {
  const UpdateParcelInfoScreen({
    super.key,
    required this.parcelId,
  });

  final int parcelId;
  

  @override
  State<UpdateParcelInfoScreen> createState() => _UpdateParcelInfoScreenState();
}

class _UpdateParcelInfoScreenState extends State<UpdateParcelInfoScreen> {
  final _formKey = GlobalKey<FormState>();

  // الحقول
  late final TextEditingController _openedNotesCtrl;
  late final TextEditingController _damagedNotesCtrl;
  late final TextEditingController _notesCtrl;
  late final TextEditingController _newActualWeightCtrl;
   String? _status;

  bool _isOpened = false;
  bool _isDamaged = false;

  XFile? _pickedImage;
  Uint8List? _imageBytes;

  final _statusOptions = const <String>[
   // 'pickup',
   // 'scheduled',
    'deliverable',
   // 'stored',
  ];

  @override
  void initState() {
    super.initState();
    _openedNotesCtrl = TextEditingController();
    _damagedNotesCtrl = TextEditingController();
    _notesCtrl = TextEditingController();
    _newActualWeightCtrl = TextEditingController();
   
  }

  @override
  void dispose() {
    _openedNotesCtrl.dispose();
    _damagedNotesCtrl.dispose();
    _notesCtrl.dispose();
    _newActualWeightCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final bytes = await image.readAsBytes();
      setState(() {
        _pickedImage = image;
        _imageBytes = bytes;
      });
    }
  }

  // بطاقة إدخال جميلة قابلة لإعادة الاستخدام
  Widget _card({
    required Widget child,
    EdgeInsetsGeometry padding = const EdgeInsets.all(16),
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            blurRadius: 18,
            spreadRadius: 0,
            offset: Offset(0, 8),
            color: Color(0x11000000),
          ),
        ],
        border: Border.all(color: AppColors.lightGray2),
      ),
      padding: padding,
      child: child,
    );
  }

  // عنصر حقل نصي
  Widget _textField({
    required String label,
    required TextEditingController controller,
    String? hint,
    int maxLines = 1,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.deepPurple,
            )),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: AppColors.white2,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.lightGray),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.lightGray),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.goldenYellow, width: 1.5),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          ),
        ),
      ],
    );
  }

  // عنصر سويتش لطيف
  Widget _switchTile({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return _card(
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: AppColors.gunmetal,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.goldenYellow,
            activeTrackColor: AppColors.brightBlue.withValues(alpha: 0.3),
          ),
        ],
      ),
    );
  }

  // زر عام
  Widget _primaryButton({
    required String label,
    required VoidCallback onTap,
    Color color = AppColors.deepPurple,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: InkWell(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(.25),
                blurRadius: 12,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward, color: AppColors.white, size: 18),
            ],
          ),
        ),
      ),
    );
  }

  // شبكة Responsive بسيطة (1 عمود < 900px، غير ذلك 2)
  int _columnsForWidth(double w) => w < 900 ? 1 : 2;

  @override
  Widget build(BuildContext context) {
    

    return BlocProvider(
      create: (_) => UpdateParcelInfoCubit(sl.get<UpdateParcelInfoUseCase>()),
      child: Scaffold(
        backgroundColor: AppColors.white2,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.white,
          title: Row(
            children: [
              const Icon(Icons.local_shipping, color: AppColors.goldenYellow),
              const SizedBox(width: 8),
              const Text(
                'تحديث معلومات الطرد',
                style: TextStyle(color: AppColors.gunmetal),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.brightBlue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  'Parcel #${widget.parcelId}',
                  style: const TextStyle(
                    color: AppColors.brightBlue,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: BlocConsumer<UpdateParcelInfoCubit, UpdateParcelInfoState>(
          listener: (context, state) {
            if (state is UpdateParcelInfoFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message), backgroundColor: AppColors.vibrantOrange),
              );
            }
            if (state is UpdateParcelInfoSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم التحديث بنجاح!'), backgroundColor: AppColors.green),
              );
              Navigator.pop(context, {'refresh': true});
            }
          },
          builder: (context, state) {
            final loading = state is UpdateParcelInfoLoading;

            return Stack(
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    final cols = _columnsForWidth(constraints.maxWidth);
                    final gap = 16.0;

                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // شريط علوي لطيف
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [AppColors.deepPurple, AppColors.richPurple],
                                ),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                children: const [
                                  Icon(Icons.info_outline, color: AppColors.white),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      'من فضلك أدخل البيانات بدقة، ويمكنك إرفاق صورة الميزان.',
                                      style: TextStyle(color: AppColors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),

                            // الشبكة
                            Wrap(
                              spacing: gap,
                              runSpacing: gap,
                              children: [
                                SizedBox(
                                  width: (constraints.maxWidth - (gap * (cols - 1))) / cols,
                                  child: _switchTile(
                                    title: 'تم فتح الطرد؟',
                                    value: _isOpened,
                                    onChanged: (v) => setState(() => _isOpened = v),
                                  ),
                                ),
                                SizedBox(
                                  width: (constraints.maxWidth - (gap * (cols - 1))) / cols,
                                  child: _switchTile(
                                    title: 'الطرد متضرّر؟',
                                    value: _isDamaged,
                                    onChanged: (v) => setState(() => _isDamaged = v),
                                  ),
                                ),

                                SizedBox(
                                  width: (constraints.maxWidth - (gap * (cols - 1))) / cols,
                                  child: _card(
                                    child: _textField(
                                      label: 'ملاحظات الفتح',
                                      controller: _openedNotesCtrl,
                                      hint: 'اكتب ملاحظاتك عند فتح الطرد (إن وُجدت)',
                                      maxLines: 3,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: (constraints.maxWidth - (gap * (cols - 1))) / cols,
                                  child: _card(
                                    child: _textField(
                                      label: 'ملاحظات الضرر',
                                      controller: _damagedNotesCtrl,
                                      hint: 'صف الضرر إن وُجد',
                                      maxLines: 3,
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  width: (constraints.maxWidth - (gap * (cols - 1))) / cols,
                                  child: _card(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text('الحالة (Status)',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.deepPurple,
                                            )),
                                        const SizedBox(height: 8),
                                        DropdownButtonFormField<String>(
                                          value: _statusOptions.contains(_status) ? _status : null,
                                          items: _statusOptions
                                              .map((e) => DropdownMenuItem(
                                                    value: e,
                                                    child: Text(e),
                                                  ))
                                              .toList(),
                                          onChanged: (v) => setState(() => _status = v ?? _statusOptions.first),
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: AppColors.white2,
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(12),
                                              borderSide: const BorderSide(color: AppColors.lightGray),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(12),
                                              borderSide: const BorderSide(color: AppColors.lightGray),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(12),
                                              borderSide: const BorderSide(color: AppColors.goldenYellow, width: 1.5),
                                            ),
                                            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: (constraints.maxWidth - (gap * (cols - 1))) / cols,
                                  child: _card(
                                    child: _textField(
                                      label: 'الوزن الفعلي الجديد (جرام/كغ)',
                                      controller: _newActualWeightCtrl,
                                      hint: 'مثال: 900',
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
                                      validator: (val) {
                                        if (val == null || val.trim().isEmpty) return 'الوزن مطلوب';
                                        final n = num.tryParse(val);
                                        if (n == null || n <= 0) return 'أدخل رقمًا صحيحًا أكبر من 0';
                                        return null;
                                      },
                                    ),
                                  ),
                                ),

                                // الملاحظات العامة تأخذ عرض عمودين عند الاتساع
                                SizedBox(
                                  width: cols == 1
                                      ? double.infinity
                                      : (constraints.maxWidth - (gap * (cols - 1))) / cols * 2 + gap,
                                  child: _card(
                                    child: _textField(
                                      label: 'ملاحظات عامة',
                                      controller: _notesCtrl,
                                      hint: 'اكتب أي ملاحظات إضافية هنا',
                                      maxLines: 4,
                                    ),
                                  ),
                                ),

                                // صورة الميزان + زر اختيار
                                SizedBox(
                                  width: cols == 1
                                      ? double.infinity
                                      : (constraints.maxWidth - (gap * (cols - 1))) / cols * 2 + gap,
                                  child: _card(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text('صورة الميزان (XFile)',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.deepPurple,
                                            )),
                                        const SizedBox(height: 12),
                                        Row(
                                          children: [
                                            _primaryButton(
                                              label: 'اختيار صورة',
                                              color: AppColors.goldenYellow,
                                              onTap: _pickImage,
                                            ),
                                            const SizedBox(width: 12),
                                            if (_pickedImage != null)
                                              Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                                decoration: BoxDecoration(
                                                  color: AppColors.white2,
                                                  borderRadius: BorderRadius.circular(999),
                                                  border: Border.all(color: AppColors.lightGray),
                                                ),
                                                child: Text(
                                                  _pickedImage!.name,
                                                  style: const TextStyle(color: AppColors.grayDark),
                                                ),
                                              ),
                                          ],
                                        ),
                                        const SizedBox(height: 14),
                                        // العرض عبر Image.memory (حسب طلبك)
                                        if (_imageBytes != null)
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(12),
                                            child: Image.memory(
                                              _imageBytes!,
                                              height: 200,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        if (_imageBytes == null)
                                          Container(
                                            height: 160,
                                            width: double.infinity,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: AppColors.white2,
                                              borderRadius: BorderRadius.circular(12),
                                              border: Border.all(color: AppColors.lightGray),
                                            ),
                                            child: const Text(
                                              'لم يتم اختيار صورة بعد',
                                              style: TextStyle(color: AppColors.mediumGray),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 24),

                            // أزرار الإجراء
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                _primaryButton(
                                  label: 'حفظ التحديث',
                                  onTap: () {
                                    if (!_formKey.currentState!.validate()) return;
                                    if (_pickedImage == null) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('الرجاء اختيار صورة الميزان'),
                                          backgroundColor: AppColors.vibrantOrange,
                                        ),
                                      );
                                      return;
                                    }

                                    final weight = num.parse(_newActualWeightCtrl.text.trim());

                                    context.read<UpdateParcelInfoCubit>().updateParcelInfo(
                                          parcelId: widget.parcelId,
                                          isOpend: _isOpened,
                                          openedNotes: _openedNotesCtrl.text.trim(),
                                          isDamaged: _isDamaged,
                                          damagedNotes: _damagedNotesCtrl.text.trim(),
                                          newActualWeight: weight,
                                          notes: _notesCtrl.text.trim(),
                                          scaledPhoto: _pickedImage!, // XFile كما طلبت
                                          status: _status ?? "",
                                        );
                                  },
                                ),
                                const SizedBox(width: 12),
                                _primaryButton(
                                  label: 'إلغاء',
                                  color: AppColors.grayDark,
                                  onTap: () => Navigator.pop(context),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                if (loading)
                  Container(
                    color: Colors.black.withValues(alpha: 0.1),
                    child: const Center(
                      child: CircularProgressIndicator(color: AppColors.goldenYellow),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
