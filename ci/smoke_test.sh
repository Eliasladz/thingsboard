#!/usr/bin/env bash
set -e

URL="${1:-http://localhost:8080/}"

CODE=$(curl -s -o /dev/null -w "%{http_code}" "$URL" || true)
echo "Smoke test: $URL -> HTTP $CODE"

if [ "$CODE" != "200" ] && [ "$CODE" != "302" ]; then
  echo "FAIL: expected 200 or 302"
  exit 1
fi

echo "PASS"
