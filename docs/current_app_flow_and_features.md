# FamXpense Current App Flow and Features

Last updated: 2026-08-22

## App Flow

1. Splash checks the persisted Hive/Firebase session.
2. Unauthenticated users go to login, register or forgot-password screens.
3. Authenticated users enter the main shell with bottom navigation.
4. Main tabs cover Home, Activity, Partners, Settlements, Statistics and Profile-related account access.
5. The center-docked add-expense action opens the standalone add-expense flow.
6. Add-partner and account-detail flows open outside the tab stack.
7. Cross-screen refresh is driven by `RefreshNotifier`, so Home and Activity reload after expense and sync changes.

## Included Features

## Authentication

- Email/password login, registration and forgot password.
- Firebase Auth backed by Hive session persistence.
- User profile data stored in Firestore and mirrored locally.

## Expenses

- Personal and shared expenses.
- Equal and manual split modes.
- Whole-rupee validation for new expense amounts and participant shares.
- Equal split assigns the full rupee remainder to the payer.
- Category, note, date, account and optional location metadata.
- Expenses are immutable in Firestore after creation.

## Accounts

- Multiple user-owned accounts.
- Account metadata editing, archive state and savings-account marker.
- Manual balance changes and deposits through account entries.
- Idempotent account balance mutation journal for offline retries.
- Whole-rupee validation for new balance mutations.

## Partners

- Search users by nickname, with legacy fallback when `nicknameLowercase` is absent.
- Send, accept and reject partnership requests.
- Connected and request tabs support pull-to-refresh.
- Add Partner action is in the Partners app bar to avoid FAB conflicts.

## Debt and Settlements

- Shared expenses update pairwise debt ledgers.
- Settlement requests reserve money from the payer account when an account is selected.
- Settlement confirmation, rejection and cancellation resolve through a Firestore transaction.
- Terminal settlement state stores `resolvedAt`, `resolutionType`, `fromAccountId` and `toAccountId`.
- Settlement refunds use canonical mutation ID `settlement-refund-{settlementId}` and recognize legacy refund IDs.
- Recipient confirmation requires a valid recipient-owned account, including savings accounts.

## Income and Transfers

- Income can be added to a user-owned account.
- Transfers move money between accounts owned by the same user.
- Whole-rupee validation applies to new income and transfer amounts.
- Savings snapshots are recomputed when savings accounts receive income or transfers.

## Savings

- Accounts can be marked as savings accounts with a monthly savings goal.
- Monthly snapshots track opening balance, closing balance, saved amount and achievement percent.
- Current-month snapshots update after account, income, transfer, expense and settlement mutations.

## Activity, Search and Statistics

- Activity combines expenses, confirmed settlements and income.
- Search supports visible activity entries.
- Statistics aggregate monthly expense, income, deposit and settlement data.

## Offline and Sync

- Hive stores local state for offline access.
- Firestore is the remote source for sync.
- Sync uses idempotent mutation records for account and debt changes.
- Participant collections use `participantIds` with `arrayContains` queries.
- Notifications for other users are skipped during upload if they would violate Firestore owner rules.

## Firestore Protection

- Expenses are immutable after create.
- Account, income, transfer, savings and settlement writes require whole-rupee financial fields for new client writes.
- Settlement updates freeze identity, participants, amount and account fields, allowing only `pending` to terminal transitions.
- Account balance mutation and account entry documents are immutable.
