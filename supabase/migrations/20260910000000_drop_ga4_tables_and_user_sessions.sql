-- AUTH-IDENTITY-SPLIT / AUTH-USER-SESSIONS-DROP
-- Drops three unused tables in one migration:
--
--   analytics_projects — 16 rows across 2 users, newest updated_at 2026-01-11.
--     No code reader anywhere (landing repo, analyticsbot-indeed-mcp, observability-toolkit).
--
--   provider_oauth_tokens — 3 rows, 1 user, newest token_expires_at 2026-01-11,
--     last_sync_at null on every row (no sync ever completed).
--     Read by ga4-list-properties, ga4-select-property, ga4-token-refresh edge functions,
--     which compare a raw JWT sub (uuid) to user_id — unreachable from Auth0 sessions.
--     All three functions deleted alongside this migration.
--
--   user_sessions — 0 rows. No writer, no FK references into it. Supabase Auth owns
--     session state (supabase.auth.admin.signOut); user_activity carries the audit trail.
--
-- Pre-conditions verified 2026-09-10 (PostgREST count=exact, prd):
--   analytics_projects: 16 rows — export before applying this migration.
--   provider_oauth_tokens: 3 rows — export before applying this migration.
--   user_sessions: 0 rows — no export needed.
--
-- Cascade removes: RLS policies, indexes, triggers, and FK constraints on each table.
-- user_sessions had RLS enabled (two SELECT policies), four btree indexes, and an
-- update_user_sessions_updated_at trigger — DROP TABLE … CASCADE removes all of them.

drop table if exists public.user_sessions cascade;
drop table if exists public.analytics_projects cascade;
drop table if exists public.provider_oauth_tokens cascade;
