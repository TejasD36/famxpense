# FamXpense Future Scope

Last updated: 2026-08-22

Status labels:

- `ongoing`: started or partially implemented, needs more work before production confidence.
- `planned`: accepted scope, not yet implemented.
- `blocked`: waiting on tooling, policy, backup, or design decision.
- `done`: implemented and verified.

## Financial Safety

| Status | Item | Notes |
| --- | --- | --- |
| ongoing | Settlement resolution hardening | Firestore terminal transition and resolution metadata are implemented. Still add two-client emulator tests for confirm-vs-cancel and confirm-vs-reject. |
| ongoing | Canonical settlement refunds | New code uses `settlement-refund-{settlementId}` and recognizes legacy IDs. Still add rollout audit tooling for existing production data. |
| ongoing | Recipient account persistence | Confirmation requires and stores `toAccountId`. Legacy confirmed settlements without `toAccountId` must remain unassigned in reporting. |
| ongoing | Whole-rupee invariant | Client/domain validation and new Firestore writes are updated. Still audit historical fractional records without mutating production data. |
| ongoing | Firestore invariants | Expenses are immutable and settlement transitions are restricted. Still add authenticated emulator coverage and deeper mutation-delta verification. |

## Calculation and Reporting Accuracy

| Status | Item | Notes |
| --- | --- | --- |
| planned | Central local calendar utilities | Use local day/month comparisons across Home, Activity, Statistics, Income, account history and CSV export. |
| planned | Settlement reporting period | Confirmed settlements should report under `resolvedAt`; legacy confirmed records may fall back to `createdAt`. |
| planned | Account timeline correction | Hide or replace historical start/end balances currently derived from today's balance. |
| planned | Activity and Statistics reconciliation | Ensure summary cards reconcile exactly with visible transaction lists. |
| planned | Manual correction classification | Keep manual balance corrections as audit entries, not deposits or income. |
| planned | Transfer visibility | Include transfers consistently in Activity, Statistics, account detail and CSV. |

## Sync Reliability and Cost

| Status | Item | Notes |
| --- | --- | --- |
| done | Joined/rerun sync coordinator | Concurrent sync callers await the active sync and schedule one collapsed rerun pass if data changes mid-sync. |
| planned | Incremental sync cursors | Add per-user, per-collection cursors and paginated initial hydration. |
| planned | Server merge timestamps | Add server-side timestamps for deterministic incremental ordering. |
| planned | Mutation journal compaction | Define local compaction after source records are synced and remote archive policy after backups exist. |

## Savings Behavior

| Status | Item | Notes |
| --- | --- | --- |
| planned | Savings activation baseline | Enabling savings should set the current balance as opening baseline and current-month saved amount to zero. |
| planned | Month rollover | Finalize previous snapshot and carry closing balance forward. |
| planned | Explicit savings corrections | Existing snapshots should remain frozen unless a user performs an intentional correction. |

## Operations and UX

| Status | Item | Notes |
| --- | --- | --- |
| planned | Reconciliation screen | Show pending operations, last successful sync and balance/debt mismatches. |
| planned | Expanded Activity filters | Include income, transfers, manual entries and settlement refunds. |
| blocked | Scheduled Firestore exports | Enable before automated cleanup or retention changes. |
| planned | App Check and crash monitoring | Avoid logging financial descriptions or amounts. |
| planned | User-directory privacy | Restrict searchable fields and notification creation surface. |
| planned | Partial-settlement simplification | Remove direct partial-settlement amount editing; rely on natural debt netting. |

## Test Backlog

| Status | Item |
| --- | --- |
| planned | Two-client tests for confirm-vs-cancel, confirm-vs-reject and repeated refund. |
| planned | Concurrent income and concurrent savings transfer tests. |
| planned | Timezone tests around midnight, month-end and year-end in Asia/Kolkata. |
| ongoing | Whole-rupee split tests proving shares total the expense and payer receives the remainder. |
| planned | Reconciliation tests proving every account mutation has exactly one source/audit record. |
| planned | Authenticated Firestore emulator tests under JDK 21. |

## Rollout Notes

- Deploy Firestore rules before releasing clients that depend on stricter invariants.
- Test dev builds with two separate browser profiles before production rollout.
- Export or back up production data before cleanup or repair work.
- Do not auto-round or auto-repair existing production documents; use read-only audits first, then explicit repair tooling.
