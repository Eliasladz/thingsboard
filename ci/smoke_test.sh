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

LOG_FILE="${1:-tb.log}"
MAX_WAIT_SECONDS="${2:-180}"

echo "Smoke test: waiting up to ${MAX_WAIT_SECONDS}s for startup messages in ${LOG_FILE}"

end=$((SECONDS + MAX_WAIT_SECONDS))
while [ $SECONDS -lt $end ]; do
  if [ -f "$LOG_FILE" ]; then
    if grep -Eiq "Tomcat started on port|Started .*Application|Starting .*Application|Starting ThingsBoard|Started ThingsBoard" "$LOG_FILE"; then
      echo "PASS: startup signature found in logs"
      exit 0
    fi
  fi
  echo "Not ready yet (no startup signature). Retrying..."
  sleep 5
done

echo "FAIL: no startup signature found after ${MAX_WAIT_SECONDS}s"
echo "Last 200 lines of logs:"
tail -n 200 "$LOG_FILE" || true
exit 1

