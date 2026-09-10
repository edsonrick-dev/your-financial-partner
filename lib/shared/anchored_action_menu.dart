import 'package:flutter/material.dart';

/// A reusable anchored overlay menu that appears relative to a target widget.
///
/// `AnchoredActionMenu` is designed for contextual actions that should appear
/// visually attached to a specific UI element, such as an `+` button, rather
/// than opening a traditional bottom sheet or dialog.
///
/// ## How it works
///
/// The widget uses Flutter's composited transform system:
///
/// ```text
/// CompositedTransformTarget
///          │
///       LayerLink
///          │
///          ▼
/// CompositedTransformFollower
///          │
///          ▼
///      Action Menu
/// ```
///
/// The widget itself does not determine what actions are displayed. The
/// caller provides those actions through [child].
///
/// ## Basic usage
///
/// First, create a [LayerLink]:
///
/// ```dart
/// final LayerLink addButtonLink = LayerLink();
/// ```
///
/// Attach the same link to the button that should anchor the menu:
///
/// ```dart
/// CompositedTransformTarget(
///   link: addButtonLink,
///   child: IconButton(
///     onPressed: controller.toggleMenu,
///     icon: const Icon(Icons.add),
///   ),
/// ),
/// ```
///
/// Then place the [AnchoredActionMenu] in the same page-level [Stack]:
///
/// ```dart
/// Stack(
///   fit: StackFit.expand,
///   children: [
///     PageContent(),
///
///     Obx(
///       () => AnchoredActionMenu(
///         isOpen: controller.isMenuOpen.value,
///         link: addButtonLink,
///         onDismiss: controller.closeMenu,
///         child: MyActionMenu(),
///       ),
///     ),
///   ],
/// )
/// ```
///
/// ## Positioning
///
/// The menu is positioned using [CompositedTransformFollower].
///
/// This implementation uses:
///
/// ```dart
/// targetAnchor: Alignment.bottomRight,
/// followerAnchor: Alignment.topRight,
/// offset: const Offset(0, 8),
/// ```
///
/// This means:
///
/// ```text
///             Target Button
///                  ┌───┐
///                  │ + │
///                  └───┘
///                     │
///                     │ 8 px
///                     ▼
///              ┌─────────────┐
///              │ Action 1    │
///              ├─────────────┤
///              │ Action 2    │
///              ├─────────────┤
///              │ Action 3    │
///              └─────────────┘
/// ```
///
/// The bottom-right corner of the target is aligned with the top-right
/// corner of the menu.
///
/// Because the menu is attached through [LayerLink], it follows the target
/// if the target moves as part of the layout.
///
/// ## Full-screen dismissal
///
/// When the menu is open, the widget places a full-screen transparent
/// [GestureDetector] behind the menu:
///
/// ```dart
/// Positioned.fill(
///   child: GestureDetector(
///     behavior: HitTestBehavior.opaque,
///     onTap: onDismiss,
///     ...
///   ),
/// )
/// ```
///
/// This serves two purposes:
///
/// 1. Tapping outside the menu closes it.
/// 2. The underlying page does not receive the same tap.
///
/// This is important because simply detecting an outside tap with something
/// such as `TapRegion` does not necessarily prevent the widget underneath
/// from receiving that tap.
///
/// ## Scrim
///
/// The dismissal layer also provides a dark scrim:
///
/// ```dart
/// Colors.black.withValues(alpha: 0.4)
/// ```
///
/// Therefore, when the menu opens:
///
/// ```text
/// ┌─────────────────────────────────────┐
/// │                                     │
/// │             Page content            │
/// │                 ↓                   │
/// │             darkened                │
/// │                                     │
/// │                         ┌─────────┐ │
/// │                         │ Action  │ │
/// │                         │ Action  │ │
/// │                         └─────────┘ │
/// │                                     │
/// └─────────────────────────────────────┘
/// ```
///
/// The action menu itself is painted above the scrim, so its buttons remain
/// interactive.
///
/// ## `isOpen`
///
/// [isOpen] controls whether the overlay exists.
///
/// When `isOpen` is `false`, the widget returns:
///
/// ```dart
/// const SizedBox.shrink()
/// ```
///
/// This means the overlay does not participate in the layout or hit testing
/// while it is closed.
///
/// ## `onDismiss`
///
/// [onDismiss] is called when the user taps anywhere outside the action menu.
///
/// Typically this should update the same state used by [isOpen]:
///
/// ```dart
/// void closeMenu() {
///   isMenuOpen.value = false;
/// }
/// ```
///
/// ## `child`
///
/// [child] represents the actual action menu.
///
/// `AnchoredActionMenu` intentionally does not know what actions exist. This
/// keeps the component reusable.
///
/// For example:
///
/// ```dart
/// AnchoredActionMenu(
///   isOpen: controller.isMenuOpen.value,
///   link: addButtonLink,
///   onDismiss: controller.closeMenu,
///   child: AccountTypeActionMenu(
///     accountTypes: accountTypes,
///     onSelected: onAccountTypeSelected,
///   ),
/// )
/// ```
///
/// The same component can therefore be used for:
///
/// - Account creation menus
/// - Contextual action menus
/// - Add menus
/// - Quick actions
/// - Filter/action popovers
/// - Other UI that should remain anchored to a target
///
/// ## Important layout requirement
///
/// `AnchoredActionMenu` needs to receive full-page constraints for its
/// dismissal barrier to cover the entire screen.
///
/// The recommended structure is:
///
/// ```dart
/// Stack(
///   fit: StackFit.expand,
///   children: [
///     PageContent(),
///
///     Positioned.fill(
///       child: AnchoredActionMenu(
///         ...
///       ),
///     ),
///   ],
/// )
/// ```
///
/// Alternatively, the parent [Stack] can provide the full available size.
///
/// Do not rely on an internal transparent [Scaffold] to make the overlay
/// full-screen. The parent layout should provide the correct constraints.
///
/// ## Why `LayerLink` is required
///
/// A [LayerLink] connects the target widget and the follower widget.
///
/// The target:
///
/// ```dart
/// CompositedTransformTarget(
///   link: addButtonLink,
///   child: ...
/// )
/// ```
///
/// and the follower:
///
/// ```dart
/// CompositedTransformFollower(
///   link: addButtonLink,
///   child: ...
/// )
/// ```
///
/// must use the same [LayerLink].
///
/// Without the same link, Flutter has no relationship between the button and
/// the anchored menu.
///
/// ## When to use this component
///
/// Use `AnchoredActionMenu` when:
///
/// - The action menu should visually originate from a specific button.
/// - The menu should remain attached to that button.
/// - The rest of the page should remain visible behind a scrim.
/// - Tapping outside should dismiss the menu.
/// - The actions should remain interactive while the page underneath is
///   blocked.
///
/// ## When NOT to use this component
///
/// Do not use this component when the action should simply open a modal
/// bottom sheet.
///
/// For example, if tapping `+` directly opens:
///
/// ```dart
/// Get.bottomSheet(
///   const CreateIncomePlanSheet(),
///   ...
/// );
/// ```
///
/// there is no need for an [AnchoredActionMenu] or [LayerLink].
///
/// ## Current Ascend usage
///
/// In Ascend's Net Worth details page, the `+` button uses this component
/// because there are multiple account types to choose from:
///
/// ```text
/// +
/// │
/// ▼
/// AnchoredActionMenu
/// │
/// ├── Cash Wallet
/// ├── Savings Account
/// ├── Checking Account
/// └── ...
/// ```
///
/// After selecting an account type, the menu closes and the corresponding
/// `AddAccountSheet` is opened.
///
/// Cash Flow does not need this component when the selected tab already
/// determines the action:
///
/// ```text
/// Income +  → CreateIncomePlanSheet
///
/// Budget +  → SelectBudgetTypeSheet
/// ```
///
/// In that case, the `+` button should directly execute its `onAdd` callback.
class AnchoredActionMenu extends StatelessWidget {
  final bool isOpen;
  final LayerLink link;
  final VoidCallback onDismiss;
  final Widget child;

  const AnchoredActionMenu({
    super.key,
    required this.isOpen,
    required this.link,
    required this.onDismiss,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    // final colorScheme = context.colors;
    if (!isOpen) {
      return const SizedBox.shrink();
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        // Scaffold(backgroundColor: Colors.transparent),
        Positioned.fill(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onDismiss,
            child: Container(color: Colors.black.withValues(alpha: 0.4)),
          ),
        ),
        CompositedTransformFollower(
          link: link,
          targetAnchor: Alignment.bottomRight,
          followerAnchor: Alignment.topRight,
          offset: const Offset(0, 8),
          child: child,
        ),
      ],
    );
  }
}
