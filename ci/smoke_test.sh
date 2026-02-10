#!/usr/bin/env bash
set -e

URL="${1:-http://localhost:8080/}"
MAX_WAIT_SECONDS="${2:-180}"

echo "Smoke test: waiting up to ${MAX_WAIT_SECONDS}s for $URL"

end=$((SECONDS + MAX_WAIT_SECONDS))
while [ $SECONDS -lt $end ]; do
  CODE=$(curl -s -o /dev/null -w "%{http_code}" "$URL" || true)

  if [ "$CODE" = "200" ] || [ "$CODE" = "302" ]; then
    echo "Smoke test: $URL -> HTTP $CODE"
    echo "PASS"
    exit 0
  fi

  echo "Not ready yet (HTTP $CODE). Retrying..."
  sleep 5
done

echo "FAIL: expected 200 or 302 after ${MAX_WAIT_SECONDS}s"
exit 1
