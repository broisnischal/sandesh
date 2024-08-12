// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:vms/api/vibration.dart';
// import 'package:vms/app/view/app.dart';
// import 'package:vms/common/widgets/shake_animation.dart';
// import 'package:vms/common/widgets/swipable.dart';
// import 'package:vms/common/widgets/tap_animation_widget.dart';

// import 'package:vms/core/constants/color_constants.dart';
// import 'package:vms/core/constants/text_style_const.dart';

// OverlayEntry? mainToast;

// enum ToastType { DEFAULT, SUCCESS, ERROR, WARNING, INFO }

// void clearToast() {
//   mainToast?.remove();
//   mainToast = null;
// }

// // clear the toast
// // if (isToastActive) clearToast();

// final isToastActive = mainToast != null;

// void showToast(
//   BuildContext context, {
//   required String message,
//   String title = '',
//   void Function()? onTap,
//   Duration duration = const Duration(seconds: 5),
//   ToastType type = ToastType.DEFAULT,
// }) {
//   // Remove the current toast if it exists
//   mainToast?.remove();
//   mainToast = null;

//   // mainAppRouter.addListener(() {
//   //   if (mainToast != null && mainToast!.mounted) {
//   //     mainToast!.remove();
//   //     mainToast = null;
//   //   }
//   // });

//   // Timer? timer;

//   // if (onTap == null) {
//   //   timer = Timer(duration, () {
//   //     if (_currentToast != null && _currentToast!.mounted) {
//   //       _currentToast!.remove();
//   //       _currentToast = null;
//   //     }

//   //     if (timer != null) {
//   //       timer?.cancel();
//   //       timer = null;
//   //     }
//   //   });
//   // }

//   switch (type) {
//     case ToastType.SUCCESS:
//       HapticApi().provideHapticFeedback(HapticFeedbackType.success);
//       break;
//     case ToastType.ERROR:
//       HapticApi().provideHapticFeedback(HapticFeedbackType.error);
//       break;
//     case ToastType.WARNING:
//       HapticApi().provideHapticFeedback(HapticFeedbackType.warning);
//       break;
//     case ToastType.INFO:
//       HapticApi().provideHapticFeedback(HapticFeedbackType.selection);
//       break;
//     case ToastType.DEFAULT:
//       HapticApi().provideHapticFeedback(HapticFeedbackType.medium);
//       break;
//   }

//   final overlay = Overlay.of(context);

//   late OverlayEntry overlayEntry;

//   overlayEntry = OverlayEntry(
//     builder: (context) => ToastWidget(
//       // timer: timer,
//       overlayEntry: overlayEntry,
//       message: message,
//       onTap: () {
//         // Remove the toast after the duration

//         if (onTap != null) {
//           onTap();
//           // if (timer != null) {
//           //   timer?.cancel();
//           //   timer = null;
//           // }
//           // if (timer != null) {
//           //   final currentDuration = timer!.isActive ? timer!.tick : duration;
//           //   final newDuration =
//           //       (currentDuration as Duration) + const Duration(seconds: 3);
//           //   timer!.cancel(); // Cancel current timer
//           //   timer = Timer(newDuration, () {
//           //     if (_currentToast != null && _currentToast!.mounted) {
//           //       _currentToast!.remove();
//           //       _currentToast = null;
//           //     }
//           //   });
//           // }
//           if (mainToast != null && mainToast!.mounted) {
//             mainToast!.remove();
//             mainToast = null;
//           }
//         }
//       },
//       title: title,
//       type: type,
//     ),
//   );

//   overlay.insert(overlayEntry);
//   mainToast = overlayEntry;

//   if (onTap == null) {
//     Future.delayed(duration, () {
//       if (overlayEntry.mounted) {
//         overlayEntry.remove();
//         mainToast = null;
//       }
//     });
//   }
// }

// class ToastWidget extends StatefulWidget {
//   const ToastWidget({
//     super.key,
//     required this.overlayEntry,
//     required this.message,
//     required this.type,
//     required this.title,
//     required this.onTap,
//     // required this.timer,
//   });
//   final OverlayEntry overlayEntry;
//   final String message;
//   final String title;
//   final ToastType type;
//   final VoidCallback onTap;
//   // final Timer? timer;

//   @override
//   _ToastWidgetState createState() => _ToastWidgetState();
// }

// class _ToastWidgetState extends State<ToastWidget> {
//   // late AnimationController _controller;
//   // late Animation<Offset> _offsetAnimation;
//   // late Animation<double> _opacityAnimation;

//   @override
//   void initState() {
//     super.initState();
//     // _controller = AnimationController(
//     //   duration: const Duration(milliseconds: 50),
//     //   reverseDuration: const Duration(milliseconds: 50),
//     //   vsync: this,
//     // );
//     // _offsetAnimation =
//     //     Tween<Offset>(begin: const Offset(-1, 0), end: const Offset(0, 0))
//     //         .animate(_controller);

//     // _opacityAnimation =
//     //     Tween<double>(begin: 0.0, end: 0.1).animate(_controller);

//     // _controller.forward();
//   }

//   @override
//   void dispose() {
//     // _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       top: MediaQuery.of(context).size.height * 0.06,
//       left: MediaQuery.of(context).size.width * 0.05,
//       right: MediaQuery.of(context).size.width * 0.05,
//       child: Center(
//         child: TapAnimationWidget(
//           onTap: () {
//             widget.onTap();
//             // _controller.reverse(); // Reverse animation on tap
//           },
//           child: GestureDetector(
//             onHorizontalDragEnd: (details) {
//               // if (details.primaryVelocity! < 0) {
//               //   log('left');
//               //   // _offsetAnimation =
//               //   //     Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
//               //   //         .animate(_controller);
//               //   // _controller.forward().then((_) {

//               //   _offsetAnimation = Tween<Offset>(
//               //     begin: const Offset(0, 1),
//               //     end: const Offset(-1, 0),
//               //   ).animate(_controller);
//               //   // _controller.reset();
//               //   _controller.reverse().then((_) {
//               //     widget.overlayEntry.remove();
//               //     mainToast = null;
//               //   });
//               // } else if (details.primaryVelocity! > 0) {
//               //   log('right');

//               //   _offsetAnimation = Tween<Offset>(
//               //     begin: const Offset(1, 0),
//               //     end: const Offset(1, 0),
//               //   ).animate(_controller);
//               //   // _controller.reset();
//               //   _controller.forward().then((_) {
//               //     widget.overlayEntry.remove();
//               //     mainToast = null;
//               //   });
//               // }
//               // if (details.primaryVelocity! < 0) {
//               //   _offsetAnimation = Tween<Offset>(
//               //           begin: const Offset(-1, 0), end: const Offset(0, 0))
//               //       .animate(_controller);
//               //   _controller.forward().then((_) {
//               //     widget.overlayEntry.remove();
//               //     _currentToast = null;
//               //   });
//               // } else if (details.primaryVelocity! > 0) {
//               //   _offsetAnimation = Tween<Offset>(
//               //           begin: const Offset(1, 0), end: const Offset(0, 0))
//               //       .animate(_controller);
//               //   _controller.forward().then((_) {
//               //     widget.overlayEntry.remove();
//               //     _currentToast = null;
//               //   });
//               // }
//             },
//             onVerticalDragEnd: (_) {
//               print('Vertical drag detected');
//               // _controller.reverse().then((_) {
//               //   widget.overlayEntry.remove();
//               //   _currentToast = null;
//               // });
//             },
//             onTap: () {
//               print('Tap detected');
//               // print('timer is ${widget.timer.tick}');
//               widget.onTap();
//               // widget.timer.cancel();
//               // _controller.reverse().then((_) {
//               //   widget.overlayEntry.remove();
//               //   _currentToast = null;
//               // });
//             },
//             child: Material(
//               color: Colors.transparent,
//               type: MaterialType.transparency,
//               // shape: RoundedRectangleBorder(
//               // borderRadius: BorderRadius.circular(12.r),
//               // ),
//               elevation: 100,
//               // clipBehavior: Clip.hardEdge,
//               child: SwipeableWidget(
//                 child: _buildToastContent(
//                   widget.message,
//                   widget.type,
//                 ),
//                 onSwipeLeft: () {
//                   print('left');
//                   widget.overlayEntry.remove();
//                   mainToast = null;
//                 },
//                 onSwipeRight: () {
//                   widget.overlayEntry.remove();
//                   mainToast = null;
//                 },
//                 // threshold: 4,
//               ),
//               // child: FadeTransition(
//               //   opacity: _opacityAnimation,
//               //   child: SlideTransition(
//               //     position: _offsetAnimation,
//               //     child: _buildToastContent(widget.message, widget.type),
//               //   ),
//               // ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildToastContent(String message, ToastType type) {
//     Color backgroundColor;
//     IconData iconvalue;
//     switch (type) {
//       case ToastType.SUCCESS:
//         backgroundColor = Colors.green.shade400.withOpacity(.9);
//         iconvalue = Icons.check_circle; // checkcircle

//         break;
//       case ToastType.ERROR:
//         iconvalue = Icons.error_outline;
//         backgroundColor = Colors.red.withOpacity(.9);
//         break;
//       case ToastType.WARNING:
//         backgroundColor = ColorConst.orangeColor6.withAlpha(1000);
//         iconvalue = Icons.warning_amber_rounded;

//         break;
//       case ToastType.INFO:
//         backgroundColor = Colors.blue.withAlpha(1000);
//         iconvalue = Icons.info_outline;

//         break;
//       case ToastType.DEFAULT:
//         backgroundColor = Colors.grey.shade900.withOpacity(.95);
//         iconvalue = Icons.notifications_on_outlined;

//         break;
//     }

//     return type == ToastType.ERROR
//         ? ShakeAnimationWidget(
//             duration: const Duration(milliseconds: 50),
//             child: buildToastWidget(
//               context,
//               message,
//               widget.title,
//               type,
//               iconvalue,
//               backgroundColor,
//             ),
//           )
//         : buildToastWidget(
//             context,
//             message,
//             widget.title,
//             type,
//             iconvalue,
//             backgroundColor,
//           );
//   }
// }

// Widget buildToastWidget(
//   BuildContext context,
//   String message,
//   String title,
//   ToastType type,
//   IconData iconvalue,
//   Color backgroundColor,
// ) {
//   return Container(
//     // alignment: Alignment.center,
//     margin: EdgeInsets.only(
//       right: 8.w,
//     ),
//     width: 1.sw,
//     padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
//     decoration: BoxDecoration(
//       color: backgroundColor,
//       borderRadius: BorderRadius.circular(12.r),
//       border: Border.all(
//         color: backgroundColor,
//       ),
//     ),
//     child: Row(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           padding: EdgeInsets.all(4.sp),
//           decoration: BoxDecoration(
//             color: backgroundColor,
//             borderRadius: BorderRadius.circular(8.r),
//           ),
//           child: Icon(
//             iconvalue,
//             color: Colors.white,
//             size: 20.sp,
//           ),
//         ),
//         5.horizontalSpace,
//         Flexible(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               if (title.isNotEmpty) ...[
//                 Text(
//                   title,
//                   softWrap: true,
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyleClass.normalTextStyle(
//                     color: Colors.white,
//                     size: 13.sp,
//                     width: FontWeight.w600,
//                   ),
//                 ),
//                 3.verticalSpace,
//               ],
//               Text(
//                 message,
//                 softWrap: true,
//                 maxLines: 3,
//                 overflow: TextOverflow.ellipsis,
//                 style: TextStyleClass.normalTextStyle(
//                   color: Colors.white,
//                   size: title.isNotEmpty ? 12.sp : 13.sp,
//                   width: FontWeight.w400,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }
