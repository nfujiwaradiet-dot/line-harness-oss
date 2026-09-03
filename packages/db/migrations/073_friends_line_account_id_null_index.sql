-- The every-tick backfill in scheduled.ts
-- (`UPDATE friends SET line_account_id = ? WHERE line_account_id IS NULL`)
-- had no index to find the NULL rows, so it scanned the whole friends table
-- on every cron tick even when there was nothing to backfill.
CREATE INDEX IF NOT EXISTS idx_friends_line_account_id_null
  ON friends (id)
  WHERE line_account_id IS NULL;
