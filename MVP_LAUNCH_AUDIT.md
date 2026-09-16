# Public MVP Launch Audit

## Launch Scope

Public MVP prioritizes the money-management core:

- Onboarding and assessment
- Home and quick actions
- Transactions
- Net worth accounts
- Cashflow plans and bills
- Financial stability profile

Secondary planner modules should stay hidden until they have real user flows and persistence.

## Visible Journey Inventory

| Journey | Status | Notes |
| --- | --- | --- |
| Onboarding -> assessment -> main shell | Needs polish | Route duplication fixed. Continue checking every onboarding branch lands on a valid next step. |
| Home -> quick actions -> add transaction | Launch-ready candidate | Verify earn, spend, transfer, give, receive, and bill payment flows on fresh data. |
| Transactions list -> edit/delete | Needs CRUD verification | Debt repayment now opens for editing. Confirm balance rebuilds after every edit/delete. |
| Financial Planner -> Net Worth | Needs CRUD verification | Account create/edit/update balance/delete are exposed. Verify account types with incomplete detail/edit views are not reachable or are handled safely. |
| Financial Planner -> Cashflow | Needs CRUD verification | Income/budget plan create/delete exists. Decide whether edit is required or delete/recreate is acceptable copy. |
| Financial Planner -> Insurance/Savings | Hidden for MVP | Removed from the planner tab picker until launch-ready. |
| Bills | Needs CRUD | Create/read/delete/pay exists. Bill edit remains a launch decision: implement edit or clearly remove edit expectations. |
| Profile -> financial stability details | Needs polish | Verify empty states and completion requirements across net worth, cashflow, and assessment. |
| Learn With Ascend | Hidden when empty | Empty "coming soon" section is hidden for MVP. |
| Settings/paywall | Needs polish | Verify no dead controls, placeholder content, or debug-only copy. |

## CRUD Checklist

### Transactions

- [ ] Create earn, spend, transfer, give, receive, bill payment, and debt repayment.
- [ ] Edit each transaction type and confirm old/new account balances are rebuilt.
- [ ] Delete each transaction type and confirm related participants, obligations, bill occurrences, and account balances remain correct.
- [ ] Remove or gate debug prints in transaction save/category selection flows.

### Accounts And Net Worth

- [ ] Create each exposed account type.
- [ ] Edit details for each exposed account type.
- [ ] Update balance for payment accounts.
- [ ] Delete accounts with no linked transactions.
- [ ] Confirm accounts with linked transactions fail gracefully with user-visible copy.
- [ ] Hide or complete unsupported account detail actions for loans/installments.

### Cashflow Plans

- [ ] Create income plans.
- [ ] Create expense/budget plans.
- [ ] Delete saved plans.
- [ ] Confirm delete/recreate is acceptable for MVP, or add edit plan flows.
- [ ] Verify current-month budget progress updates after transaction changes.

### Bills

- [ ] Create bills with valid category, amount, frequency, and due date.
- [ ] Pay a bill from its detail/list flow.
- [ ] Delete a bill payment and confirm the bill becomes unpaid again.
- [ ] Delete a bill and confirm future occurrences are removed.
- [ ] Add bill editing or remove edit expectations from the UI.

### People And Debts

- [ ] Create people through split, give, and receive flows.
- [ ] Verify people balances after shared expenses and debt tracking.
- [ ] Verify settlement/repayment flows are clear enough for MVP.
- [ ] Confirm no orphaned people or obligations appear after transaction deletion.

### Categories

- [ ] Create custom categories from transaction selection.
- [ ] Decide whether category edit/delete is required for MVP.
- [ ] Hide category-management entry points if edit/delete is not supported.

## Launch Polish Checklist

- [ ] `dart analyze` is clean.
- [ ] Every visible list has loading, empty, and error states.
- [ ] Every destructive action has confirmation.
- [ ] No route duplicates or misspelled route paths.
- [ ] No debug-only drawer/actions are reachable.
- [ ] No "coming soon", under-construction, or empty placeholder screens are reachable.
- [ ] Primary flows work on a fresh install with seed/default data.

## Automated Test Targets

- [ ] DAO/controller test: transaction edit/delete rebuilds affected account balances.
- [ ] DAO/controller test: bill payment deletion reopens the bill occurrence.
- [ ] DAO/controller test: account deletion succeeds without linked records and fails gracefully with linked records.
- [ ] DAO/controller test: cashflow plan delete/recreate updates budget summaries.
- [ ] Widget/navigation smoke test: main shell loads and add-transaction sheet opens.
