# PostHog Self-driving setup report

## Summary

PostHog Self-driving is configured for this Flutter personal-finance app. Session Replay and Error Tracking were already enabled, Support was enabled, and health, error-tracking, and support signal sources were switched on.

The focused scout troop and two Replay Vision monitors are active. Findings should begin appearing in the [Self-driving inbox](https://us.posthog.com/project/611955/inbox) within about 30 minutes after compatible data arrives.

## AI data processing

Approved.

## GitHub

The PostHog GitHub App was already connected before this setup. GitHub Issues was not selected as a Self-driving source in this run.

## Products enabled

| Product | Result | Notes |
| --- | --- | --- |
| Session Replay | Already enabled; inert until Flutter SDK replay is configured | This is a mobile app. The repository includes `posthog_flutter`, but no `Posthog.setup` call was found. |
| Error Tracking | Already enabled; inert until Flutter SDK exception capture is configured | The server setting is on; mobile capture still requires configured SDK initialization. |
| Support (Conversations) | Enabled | Tickets will begin arriving only after an inbound email, inbox, or Slack channel is connected in PostHog. |

## Signal sources

| Signal source | Action | Details |
| --- | --- | --- |
| `health_checks` / `health_issue` | Enabled | Source config `01a0a885-2180-791f-be58-440ce3742e2a`. |
| `error_tracking` / `issue_created` | Enabled | Source config `01a0a885-21c7-7263-8ae7-986dfc39dc24`. |
| `error_tracking` / `issue_reopened` | Enabled | Source config `01a0a885-22a2-7ea1-8fe3-d410377a556e`. |
| `error_tracking` / `issue_spiking` | Enabled | Source config `01a0a885-223b-7c26-af5b-dc3b1a14b07f`. |
| `conversations` / `ticket` | Enabled | Source config `01a0a885-2238-71ac-a18f-301a892cea5e`. |
| `signals_scout` / `cross_source_issue` | Skipped | On by default; no opt-out row was present. |
| Session replay responder | Skipped deliberately | Replay observations reach the inbox through the two Replay Vision scanners below; there is no separate source row. |
| LLM analytics, logs, evaluation, and alert-state rows | Skipped | No corresponding v1 responder was appropriate for this app. |

## Connected tools

No external connected-tool sources were selected. The first-picker options included GitHub Issues, Linear, Jira, Sentry, and Zendesk; the user selected **None of these**. No connected-tool responder was added.

## Scout troop

**Enabled (3 of 27)**

| Scout | Why it is enabled |
| --- | --- |
| `signals-scout-general` | Covers cross-product patterns and surfaces without a dedicated enabled specialist. |
| `signals-scout-product-analytics` | This app’s primary watchable surface is its product journey behavior. |
| `signals-scout-health-checks` | Prioritizes PostHog setup-health findings. |

**Disabled (24 of 27)**

| Scouts | Reason |
| --- | --- |
| `signals-scout-ai-observability`, `signals-scout-apm`, `signals-scout-csp-violations`, `signals-scout-customer-analytics`, `signals-scout-data-pipelines`, `signals-scout-data-warehouse`, `signals-scout-experiments`, `signals-scout-feature-flags`, `signals-scout-insight-alerts`, `signals-scout-logs`, `signals-scout-mcp-tool-calls`, `signals-scout-revenue-analytics`, `signals-scout-skills-store`, `signals-scout-surveys`, `signals-scout-tasks`, `signals-scout-web-analytics`, `signals-scout-web-vitals` | The repo/context did not show active use of these surfaces. Enable the applicable scout later if that surface becomes active. |
| `signals-scout-anomaly-detection`, `signals-scout-observability-gaps` | Kept off to preserve a focused, low-noise troop while the general and product-analytics scouts cover the available app surface. |
| `signals-scout-conversations` | Support was just enabled, but no inbound support channel is connected yet. |
| `signals-scout-error-tracking` | Covered by the native Error Tracking sources. |
| `signals-scout-session-replay` | Covered by Replay Vision scanners. |
| `signals-scout-replay-vision` | There were no pre-existing Replay Vision observations to aggregate. |
| `signals-scout-inbox-validation` | No prior Self-driving fixes exist to validate on this fresh setup. |

**Run budget:** 100 maximum runs/day, 0 used today, 100 remaining. The server banner states: “Scouts are in early access. Each project gets up to 100 scout runs a day. Contact team-self-driving@posthog.com if you need more.”

## Custom scouts

No custom scouts were created. Two candidates were proposed based on the app’s MVP launch audit and route map—financial workflow completion and onboarding/assessment handoff—but the proposal was cancelled, so neither was created.

The financial CRUD flows and onboarding handoff are high-value surfaces, but the repository contains no concrete tracking call sites beyond the analytics service wrapper. A custom data-driven scout would therefore be premature until those journeys emit durable telemetry. If a custom scout later becomes noisy, set its config’s `emit` value to `false` in PostHog to make it dry-run only.

## Replay Vision scanners

A scanner is an LLM that watches individual session recordings on a schedule and pushes qualifying visible defects to the inbox. These are the only items in this setup that use Replay Vision quota. Findings enter at half weight and require independent corroboration before promotion into a Self-driving report.

| Brief | Status | Scanner | Scope | Sampling | Estimated monthly spend |
| --- | --- | --- | --- | --- | --- |
| Breakage monitor | Created | Money management breakage | Sessions whose recorded URL contains `/transaction`, the main transaction-completion flow. It watches visibly failed transaction, account, cashflow-plan, bill, payment, and onboarding actions. | 50% | 0 observations / 0 credits currently |
| Frustration monitor | Created | Money management frustration | Sessions with the `$rageclick` interaction signal only; it watches repeated attempts across the money-management and onboarding flows. | 100% | 0 observations / 0 credits currently |

The current Replay Vision budget is 2,500 credits, with 0 used and 2,500 remaining for the period ending 2026-10-16. There were no session recordings or existing scanners when configured, so both monitors are armed and begin processing only after matching recordings arrive.

## Follow-ups

- [ ] Configure `Posthog.setup` for the Flutter app using the real configured public token and host, then verify Session Replay and exception capture on a device. The server-side product toggles are enabled but do not initialize the mobile SDK.
- [ ] Confirm how this Flutter app supplies replay route/screen metadata. The breakage monitor uses the `/transaction` route as a narrow completion-flow scope; verify that matching mobile recordings include this value, or update the scanner to use the SDK’s verified screen metadata.
- [ ] Verify whether mobile interaction data produces `$rageclick` events. The frustration monitor remains harmless until matching recordings exist.
- [ ] Connect an inbound Support channel (email, inbox, or Slack) in PostHog so the enabled Conversations responder can receive tickets.
- [ ] Add stable, non-PII journey telemetry for onboarding completion and the transaction/account/bill flows before reconsidering the proposed custom scouts.

## What happens next

The scout coordinator picks up fresh configurations within roughly 30 minutes. Scout runs draw from the daily budget; reports are clustered in the [Self-driving inbox](https://us.posthog.com/project/611955/inbox), where immediately actionable findings can become coding tasks.

## Repository files

| File | Change |
| --- | --- |
| `posthog-self-driving-report.md` | Created this setup report. |

No application source files were modified.
