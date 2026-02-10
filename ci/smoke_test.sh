#!/usr/bin/env bash
#
# Copyright © 2016-2026 The Thingsboard Authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

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
