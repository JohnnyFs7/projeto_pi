import 'package:flutter/material.dart';
import 'package:projeto_pi/core/app_colors.dart';
import 'package:projeto_pi/screens/auth/auth_screen.dart';
import '../../widgets/input_field.dart';
import 'entrepreneur_setup_data.dart';

  class EntrepreneurSetupScreen  extends StatefulWidget{
    const EntrepreneurSetupScreen({super.key});

    @override
    State<EntrepreneurSetupScreen> createState() =>
        _EntrepreneurSetupScreenState();
  }

  class _EntrepreneurSetupScreenState extends State<EntrepreneurSetupScreen> {

    final _businessNameController = TextEditingController();
    final _cnpjController = TextEditingController();
    final _descriptionController = TextEditingController();
    final _addressController = TextEditingController();
    final _depositValueController = TextEditingController();

    String _selectedCategory = 'Beleza';
    bool _chargeDeposit = false;

    List<OfferedService> _services = [
      OfferedService(),
    ];

    @override
    void dispose() {
      _businessNameController.dispose();
      _cnpjController.dispose();
      _descriptionController.dispose();
      _addressController.dispose();
      _depositValueController.dispose();

      super.dispose();
    }

    void _addService() {
      setState(() {
        _services.add(OfferedService());
      });
    }

    void _removeService(int index) {
      if (_services.length > 1) {
        setState(() {
          _services.removeAt(index);
        });
      }
    }

    void _handleSave() {
      Navigator.pushReplacementNamed(context, '/entrepreneur-dashboard');
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _InputSection(
                      label: 'Nome do negócio',
                      placeholder: 'Ex: Studio Joana Cabelos',
                      controller: _businessNameController,
                    ),
                    const SizedBox(height: 16),
                    _InputSection(
                      label: 'CNPJ',
                      placeholder: '00.000.000/0001-00',
                      controller: _cnpjController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    _InputSection(
                      label: 'Descrição dos serviços',
                      placeholder: 'Descreva o que você oferece...',
                      controller: _depositValueController,
                      minLines: 3,
                    ),
                    const SizedBox(height: 16),

                    _buildCategorySelect(),
                    const SizedBox(height: 16),

                    if (_chargeDeposit)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _InputSection(
                            label: 'Valor da taxa (R\$)',
                            placeholder: 'Ex: 30',
                            controller: _depositValueController,
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),

                    _buildServicesSection(),
                    const SizedBox(height: 24),

                    _PrimaryButton(
                      label: 'Salvar perfil',
                      onPressed: _handleSave,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget _buildHeader() {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.only(
          top: MediaQuery
              .of(context)
              .padding
              .top + 16,
          bottom: 16,
          left: 16,
          right: 16,
        ),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.dark, AppColors.primary],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Configure seu perfil',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Empreendedor',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white54,
              ),
            ),
          ],
        ),
      );
    }

    Widget _buildCategorySelect() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Categoria principal',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              border: Border.all(color: AppColors.border, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: DropdownButton<String>(
              isExpanded: true,
              value: _selectedCategory,
              underline: const SizedBox(),
              items: kEntrepreneurCategories
                  .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                  .toList(),
              onChanged: (val) =>
                  setState(() => _selectedCategory = val ?? 'Beleza'),
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textPrimary,
              ),
              iconDisabledColor: AppColors.textMuted,
              iconEnabledColor: AppColors.primary,
            ),
          ),
        ],
      );
    }

    Widget _buildChargeDepositToggle() {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cobrar taxa de reserva?',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Sinal de agendamento',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
            Switch(
              value: _chargeDeposit,
              onChanged: (val) => setState(() => _chargeDeposit = val),
              activeColor: AppColors.primary,
            ),
          ],
        ),
      );
    }

    Widget _buildServicesSection() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Serviços oferecidos',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              GestureDetector(
                onTap: _addService,
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    '+ Adicionar',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _services.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (_, i) =>
                _ServiceCard(
                  service: _services[i],
                  onNameChanged: (v) => setState(() => _services[i].name = v),
                  onPriceChanged: (v) => setState(() => _services[i].price = v),
                  onDurationChanged: (v) =>
                      setState(() => _services[i].duration = v),
                  onRemove: _services.length > 1
                      ? () => _removeService(i)
                      : null,
                ),
          ),
        ],
      );
    }
  }
      class _InputSection extends StatelessWidget {
        final String label;
        final String placeholder;
        final TextEditingController controller;
        final TextInputType keyboardType;
        final int minLines;

        const _InputSection({
          required this.label,
          required this.placeholder,
          required this.controller,
          this.keyboardType = TextInputType.text,
          this.minLines = 1,
      });

        @override
        Widget build(BuildContext context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: controller,
                keyboardType: keyboardType,
                minLines: minLines,
                maxLines: minLines == 1 ? 1 : null,
                decoration: InputDecoration(
                  hintText: placeholder,
                  hintStyle:
                    const TextStyle(color: AppColors.textHint, fontSize: 14),
                  filled: true,
                  fillColor: AppColors.surface,
                  contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                      const BorderSide(color: AppColors.border, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: AppColors.primary, width: 1.5),
                    ),
                  ),
                  style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
                ),
              ],
            );
          }
        }

        class _ServiceCard extends StatelessWidget {
          final OfferedService service;
          final void Function(String) onNameChanged;
          final void Function(String) onPriceChanged;
          final void Function(String) onDurationChanged;
          final VoidCallback? onRemove;

          const _ServiceCard({
            required this.service,
            required this.onNameChanged,
            required this.onPriceChanged,
            required this.onDurationChanged,
            this.onRemove,
        });

          @override
          Widget build(BuildContext context) {
            return Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow:[
                      BoxShadow(
                       color: Colors.black.withOpacity(0.06),
                       blurRadius: 8,
                       offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      TextField(
                        onChanged: onNameChanged,
                        decoration: InputDecoration(
                          hintText: 'Nome do serviço',
                          hintStyle: const TextStyle(
                              color: AppColors.textHint, fontSize: 13),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: AppColors.border, width: 1),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                            ),
                            style: const TextStyle(fontSize: 13),
                          ),

                          const SizedBox(height: 10),

                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  onChanged: onPriceChanged,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: 'Preço (R\$)',
                                    hintStyle: const TextStyle(
                                        color: AppColors.textHint, fontSize: 13),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                          color: AppColors.border, width: 1),
                                      ),
                                      contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 10),
                                      ),
                                      style: const TextStyle(fontSize: 13),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                  child: TextField(
                                    onChanged: onDurationChanged,
                                    decoration: InputDecoration(
                                      hintText: 'Duração',
                                      hintStyle: const TextStyle(
                                          color: AppColors.textHint, fontSize: 13),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                            color: AppColors.border, width: 1),
                                      ),
                                      contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 10),
                                    ),
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    if (onRemove != null)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: onRemove,
                          child: Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: AppColors.error,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.error.withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Icon(Icons.close, size: 14, color: Colors.white),
                          ),
                        ),
                      ),
                ],
            );
          }
        }

        class _PrimaryButton extends StatelessWidget {
          final String label;
          final VoidCallback onPressed;

          const _PrimaryButton({
            required this.label,
            required this.onPressed,
        });

        @override
        Widget build(BuildContext context) {
          return SizedBox(
            height: 52,
            child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 4,
                  shadowColor: AppColors.primary.withOpacity(0.35),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(30),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                child: Text(label),
              ),
            );
          }
        }
