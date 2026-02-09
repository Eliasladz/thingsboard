/**
 * Copyright © 2016-2026 The Thingsboard Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.thingsboard.server.cache.customer;

import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

public class CustomerCacheKeyTest {

    @Test
    public void testNormalizeTitleNull() {
        assertThat(CustomerCacheKey.normalizeTitle(null)).isNull();
    }

    @Test
    public void testNormalizeTitleEmpty() {
        assertThat(CustomerCacheKey.normalizeTitle("")).isEmpty();
        assertThat(CustomerCacheKey.normalizeTitle("   ")).isEmpty();
    }

    @Test
    public void testNormalizeTitleCaseConversion() {
        assertThat(CustomerCacheKey.normalizeTitle("Customer Name"))
                .isEqualTo("customer name");
        assertThat(CustomerCacheKey.normalizeTitle("CUSTOMER NAME"))
                .isEqualTo("customer name");
    }

    @Test
    public void testNormalizeTitleWhitespaceNormalization() {
        assertThat(CustomerCacheKey.normalizeTitle("Customer  Name"))
                .isEqualTo("customer name");
        assertThat(CustomerCacheKey.normalizeTitle("  Customer   Name  "))
                .isEqualTo("customer name");
    }

}
