-- CR33: Auth0 log stream receiver table
-- Stores logs received from Auth0's HTTP log stream for audit/debugging

CREATE TABLE IF NOT EXISTS public.auth0_logs (
  id BIGSERIAL PRIMARY KEY,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
  log_id TEXT NOT NULL UNIQUE, -- Auth0's unique log entry ID
  event_type TEXT NOT NULL, -- e.g., "s" (success), "f" (failed login), "fp" (failed password reset)
  event_name TEXT, -- Human-readable name
  client_id TEXT,
  client_name TEXT,
  user_id TEXT,
  user_name TEXT,
  email TEXT,
  ip_address INET,
  user_agent TEXT,
  scope TEXT,
  description TEXT,
  details JSONB -- Full Auth0 log entry for debugging/compliance
);

-- Inline `INDEX ...` clauses inside CREATE TABLE are MySQL syntax; Postgres rejects
-- them (SQLSTATE 42601), which broke the CR30 replay guard from 2026-08-17 until
-- 2026-09-11 and left every later migration unproven. Production already has the
-- table, so these are IF NOT EXISTS to stay idempotent against whatever created it.
CREATE INDEX IF NOT EXISTS idx_auth0_logs_created_at ON public.auth0_logs (created_at DESC);
CREATE INDEX IF NOT EXISTS idx_auth0_logs_event_type ON public.auth0_logs (event_type);
CREATE INDEX IF NOT EXISTS idx_auth0_logs_user_id ON public.auth0_logs (user_id);
CREATE INDEX IF NOT EXISTS idx_auth0_logs_client_id ON public.auth0_logs (client_id);

-- Enable RLS (logs are internal audit data)
ALTER TABLE public.auth0_logs ENABLE ROW LEVEL SECURITY;

-- Service role can insert (the log stream receiver) and read (for queries)
CREATE POLICY auth0_logs_service_insert ON public.auth0_logs FOR INSERT
  WITH CHECK (auth.role() = 'service_role');

CREATE POLICY auth0_logs_service_select ON public.auth0_logs FOR SELECT
  USING (auth.role() = 'service_role');

-- Authenticated users cannot access (no business logic depends on this table directly)
-- Only the service role (api-gateway's log handler) can read/write
CREATE POLICY auth0_logs_deny_anon ON public.auth0_logs FOR ALL
  USING (false);

COMMENT ON TABLE public.auth0_logs IS 'Auth0 log stream events received via POST /v1/auth0-logs. Source of truth for audit trail and compliance.';
COMMENT ON COLUMN public.auth0_logs.log_id IS 'Auth0 unique identifier for this log entry; used to deduplicate retries';
COMMENT ON COLUMN public.auth0_logs.details IS 'Full Auth0 log object for compliance and debugging; includes all context Auth0 provides';
