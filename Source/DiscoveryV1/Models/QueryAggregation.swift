/**
 * Copyright IBM Corporation 2018
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 **/

import Foundation

/** An aggregation produced by the Discovery service to analyze the input provided. */
public enum QueryAggregation: Decodable {

    // reference: https://console.bluemix.net/docs/services/discovery/query-reference.html#aggregations

    case term(Term)
    case filter(GenericQueryAggregation)
    case nested(GenericQueryAggregation)
    case histogram(Histogram)
    case timeslice(GenericQueryAggregation)
    case topHits(GenericQueryAggregation)
    case uniqueCount(Calculation)
    case max(Calculation)
    case min(Calculation)
    case average(Calculation)
    case sum(Calculation)
    case generic(GenericQueryAggregation)

    private enum CodingKeys: String, CodingKey {
        case type = "type"
    }

    // swiftlint:disable:next cyclomatic_complexity
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        guard let type = try container.decodeIfPresent(String.self, forKey: .type) else {
            // the specification does not identify `type` as a required field,
            // so we need a generic catch-all in case it is not present
            self = .generic(try GenericQueryAggregation(from: decoder))
            return
        }
        switch type {
        case "term": self = .term(try Term(from: decoder))
        case "filter": self = .filter(try GenericQueryAggregation(from: decoder))
        case "nested": self = .nested(try GenericQueryAggregation(from: decoder))
        case "histogram": self = .histogram(try Histogram(from: decoder))
        case "timeslice": self = .timeslice(try GenericQueryAggregation(from: decoder))
        case "top_hits": self = .topHits(try GenericQueryAggregation(from: decoder))
        case "unique_count": self = .uniqueCount(try Calculation(from: decoder))
        case "max": self = .max(try Calculation(from: decoder))
        case "min": self = .min(try Calculation(from: decoder))
        case "average": self = .average(try Calculation(from: decoder))
        case "sum": self = .sum(try Calculation(from: decoder))
        default: self = .generic(try GenericQueryAggregation(from: decoder))
        }
    }

}
