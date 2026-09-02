  import 'package:flutter/material.dart';
  import 'package:intl/intl.dart' as intl;
  import '../../core/app_colors.dart';
  import 'entrepreneur_dashboard_data.dart';

 class EntrepreneurDashboard extends StatefulWidget {
   const EntrepreneurDashboard({super.key});

   @override
   State<EntrepreneurDashboard> createState() => _EntrepreneurDashboardState();
 }

 class _EntrepreneurDashboardState extends State<EntrepreneurDashboard> {
   String _chartPeriod = '7';
   String _activeNav = 'dashboard';

   List<ChartDataPoint> get _chartData =>
       _chartPeriod == '7' ? kChartData7 : kChartData30;

   void _go(String route) => Navigator.pushNamed(context, route);

   @override
   Widget build(BuildContext context) {
     final today = DateTime.now();
     final dateStr = intl.DateFormat('EEEE, d\'de\' MMMM', 'pt_BR')
          .format(today)
          .replaceFirst(today.weekday == 7 ? 'Sunday' : '', 'domingo')
          .replaceFirst(today.weekday == 1 ? 'Monday' : '', 'segunda');

     return Scaffold(
       backgroundColor: AppColors.background,
       body: Column(
         children: [
           Expanded(
               child: SingleChildScrollView(
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.stretch,
                   children: [

                     _buildHeader(dateStr),

                     _buildChartSection(),


                     _buildUpcomingBookings(),
                     const SizedBox(height: 24),
                   ],
                 ),
               ),
            ),

           _buildBottomNav(),
         ],
       ),
     );
   }

   Widget _buildHeader(String dateStr) {
     return Container(
       width: double.infinity,
       padding: EdgeInsets.only(
         top: MediaQuery.of(context).padding.top + 20,
         bottom: 20,
         left: 16,
         right: 16,
       ),
       decoration: const BoxDecoration(
         gradient: LinearGradient(
           begin:  Alignment.topLeft,
           end: Alignment.bottomRight,
           colors: [AppColors.dark, AppColors.primary],
         ),
       ),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text(
                     dateStr,
                     style: TextStyle(
                       fontSize: 12,
                       color: Colors.white.withOpacity(0.6),
                     ),
                   ),
                   const SizedBox(height: 2),
                   const Text(
                     'Olá, Joana! ',
                     style: TextStyle(
                       fontSize: 20,
                       fontWeight: FontWeight.w800,
                       color: Colors.white,
                     ),
                   ),
                 ],
               ),
               Row(
                 children: [
                   Stack(
                     clipBehavior: Clip.none,
                     children: [
                       IconButton(
                           onPressed: () {},
                           icon: const Icon(Icons.notifications_outlined,
                              size: 20, color: Colors.white),
                           padding: EdgeInsets.zero,
                           constraints: const BoxConstraints(),
                          ),
                          Positioned(
                            top: -4,
                            right: -4,
                            child: Container(
                              width: 18,
                              height: 18,
                              decoration: const BoxDecoration(
                                color: AppColors.error,
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                '5',
                                style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                       ],
                     ),

                     const SizedBox(width: 16),

                     IconButton(
                         onPressed: () {},
                         icon: const Icon(Icons.settings_outlined,
                           size: 20, color: Colors.white),
                         padding: EdgeInsets.zero,
                         constraints: const BoxConstraints(),
                        ),
                      ],
                     ),
                   ],
                 ),
                 const SizedBox(height: 16),

                 GridView.count(
                     crossAxisCount: 2,
                     crossAxisSpacing: 12,
                     mainAxisExtent: 100,
                     shrinkWrap: true,
                     physics: const NeverScrollableScrollPhysics(),
                     childAspectRatio: 1.1,
                     children: [
                       _KpiCard(
                         icon: Icons.calendar_today_outlined,
                         label: 'Agendamentos hoje',
                         value: '8',
                       ),
                       _KpiCard(
                         icon: Icons.attach_money,
                         label: 'Faturamento do mês',
                         value: 'R\$ 4.820',
                       ),
                       _KpiCard(
                         icon: Icons.star,
                         label: 'Avaliação média',
                         value: '4.9 ★',
                       ),
                       _KpiCard(
                         icon: Icons.people_outline,
                         label: 'Clientes novos',
                         value: '12',
                       ),
                     ],
                   ),
                 ],
               ),
             );
           }

           Widget _buildKpiCards() => const SizedBox.shrink();

           Widget _buildChartSection() {
             return Container(
               margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
               padding: const EdgeInsets.all(16),
               decoration: BoxDecoration(
                 color: AppColors.surface,
                 borderRadius: BorderRadius.circular(20),
                 boxShadow: [
                   BoxShadow(
                     color: Colors.black.withOpacity(0.06),
                     blurRadius: 12,
                     offset: const Offset(0, 2),
                   ),
                 ],
               ),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Row(
                     children: [
                       const Icon(Icons.trending_up,
                           size: 16, color: AppColors.primary),
                       const SizedBox(width: 8),
                       const Text(
                         'Faturamento',
                         style: TextStyle(
                           fontSize: 14,
                           fontWeight: FontWeight.w700,
                           color:AppColors.textPrimary,
                         ),
                       ),
                     ],
                   ),

                   Container(
                     decoration: BoxDecoration(
                      border: Border.all(color: AppColors.border, width: 1),
                      borderRadius: BorderRadius.circular(12),
                     ),
                      child: Row(
                        children: [
                          '7D',
                          '30D',
                          '3M',
                     ]
                            .asMap()
                            .entries
                            .map((e) {
                              final isActive = (e.value == '7D' && _chartPeriod == '7') ||
                                               (e.value == '30D' && _chartPeriod == '30') ||
                                               (e.value == '3M' && _chartPeriod == '90');
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _chartPeriod = e.value == '7D'
                                      ? '7'
                                      : e.value == '30D'
                                          ? '30'
                                          : '90';
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: isActive
                                        ? AppColors.primary
                                        : Colors.transparent,
                                    border: e.key == 0
                                        ? null
                                        : Border(
                                            left: BorderSide(
                                              color: AppColors.border,
                                              width: 1,
                                            ),
                                          ),
                                    ),
                                    child: Text(
                                      e.value,
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: isActive
                                            ? Colors.white
                                            : AppColors.textMuted,
                                    ),
                                  ),
                                ),
                              );
                            })
                            .toList(),
                      ),
                     ),
                   ],
                 ),
                 const SizedBox(height: 16),

                 SizedBox(
                  height: 150,
                  child: _BarChart(data: _chartData),
               ),
             ],
           ),
         );
       }

       Widget _buildUpcomingBookings() {
             return Container(
               margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
               decoration: BoxDecoration(
                 color: AppColors.surface,
                 borderRadius: BorderRadius.circular(20),
                 boxShadow: [
                   BoxShadow(
                     color: Colors.black.withOpacity(0.06),
                     blurRadius: 12,
                     offset: const Offset(0, 2),
                   ),
                 ],
                 overflow: Clip.antiAlias,
               ),
               child: Column(
                 children: [
                   Padding(
                       padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           const Text(
                             'Próximos agendamentos',
                             style: TextStyle(
                               fontSize: 14,
                               fontWeight: FontWeight.w700,
                               color: AppColors.textPrimary,
                             ),
                           ),
                           GestureDetector(
                             onTap: () => _go('/entrepreneur-calendar'),
                             child: const Text(
                               'Ver agenda',
                               style: TextStyle(
                                 fontSize: 13,
                                 fontWeight: FontWeight.w600,
                                 color: AppColors.primary,
                               ),
                             ),
                           ),
                         ],
                       ),
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: kUpcomingBookings.length,
                        separatorBuilder: (_, __) => Divider(
                          height: 1,
                          color: AppColors.border,
                          indent: 16,
                          endIndent: 16,
                        ),
                        itemBuilder: (_, i) => _BookingItem(
                          booking: kUpcomingBookings[i],
                          onChat: () => _go('/chat'),
                        ),
                      ),
                    ],
                  ),
                );
              }

              Widget _buildBottomNav() {
                final navItems = [
                  (id: 'dashboard', icon: Icons.dashboard_outlined, label: 'Dashboard', route: ''),
                  (id: 'agenda', icon: Icons.calendar_today_outlined, label: 'Agenda', route: '/entrepreneur-calendar'),
                  (id: 'services', icon: Icons.settings_outlined, label: 'Serviços', route: ''),
                  (id: 'chat', icon: Icons.chat_bubble_outline, label: 'Chat', route: '/chat'),
                  (id: 'profile', icon: Icons.percent_outlined, label: 'Perfil', route: ''),
                ];

                return Container(
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    border: Border(top: BorderSide(color: AppColors.border, width: 1)),
                  ),
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).padding.bottom,
                  ),
                  child: Row(
                    children: navItems.map((item) {
                      final active = item.id == _activeNav;
                      return Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() => _activeNav = item.id);
                              if (item.route.isNotEmpty) _go(item.route);
                            },
                            behavior: HitTestBehavior.opaque,
                            child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      item.icon,
                                      size: 20,
                                      color: active ? AppColors.primary : AppColors.textMuted,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      item.label,
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: active ? FontWeight.w700 : FontWeight.w400,
                                        color: active ? AppColors.primary : AppColors.textMuted,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  }
                }

   class _KpiCard extends StatelessWidget {
    final IconData icon;
    final String label;
    final String value;

    const _KpiCard({
      required this.icon,
      required this.label,
      required this.value,
   });

   @override
   Widget build(BuildContext context) {
     return Container(
       padding: const EdgeInsets.all(12),
       decoration: BoxDecoration(
         color: Colors.white.withOpacity(0.15),
         borderRadius: BorderRadius.circular(20),
       ),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           Icon(icon, size: 16, color: Colors.white.withOpacity(0.7)),
           Text(
             value,
             style: const TextStyle(
               fontSize: 18,
               fontWeight: FontWeight.w800,
               color: Colors.white,
             ),
           ),
           Text(
             label,
             style: TextStyle(
               fontSize: 10,
               color: Colors.white.withOpacity(0.6),
             ),
           ),
         ],
       ),
     );
   }
 }

 class _BarChart extends StatelessWidget {
   final List<ChartDataPoint> data;

   const _BarChart({required this.data});

   @override
   Widget build(BuildContext context) {
     if (data.isEmpty) return const SizedBox();

     final maxValue = data.map((d) => d.value). reduce((a, b) => a > b ? a : b);

     return Column(
       children: [
         Expanded(
             child: Row(
               crossAxisAlignment: CrossAxisAlignment.end,
               mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: data.map((point) {
                 final barHeight = (point.value / maxValue) * 100;
                 return Column(
                   mainAxisAlignment: MainAxisAlignment.end,
                   children: [
                     Container(
                        width: 24,
                        height: barHeight,
                        decoration: BoxDecoration(
                          color:  AppColors.primary,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(6),
                            topRight: Radius.circular(6),
                          ),
                        ),
                     ),
                     const SizedBox(height: 8),
                     Text(
                       point.day,
                       style: const TextStyle(
                         fontSize: 11,
                         color: AppColors.textMuted,
                       ),
                     ),
                   ],
                 );
               }).toList(),
              ),
            ),
          ],
        );
      }
    }

    class _BookingItem extends StatelessWidget {
      final UpcomingBooking booking;
      final VoidCallback onChat;

      const _BookingItem({required this.booking, required this.onChat});

      @override
      Widget build(BuildContext context) {
        final isPending = booking.status == 'pending';

        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    booking.avatarUrl,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 40,
                      height: 40,
                      color: AppColors.primaryBg,
                      child: const Icon(Icons.person, size: 20),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking.clientName,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${booking.service} · ${booking.time}',
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),

                if (isPending)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0FDF4),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.check,
                              size: 14, color: AppColors.success),
                          ),
                        ),
                        const SizedBox(width: 6),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFEF2F2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.close,
                                size: 14, color: AppColors.error,
                            ),
                          ),
                        ],
                      )
                    else
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                        color: const Color(0xFFF0FDF4),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'Confirmado',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: AppColors.success,
                        ),
                      ),
                    ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: onChat,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: AppColors.primaryBg,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.chat_bubble_outline,
                          size: 14, color: AppColors.primary),
                    ),
                  ),
                ],
              ),
            );
          }
        }