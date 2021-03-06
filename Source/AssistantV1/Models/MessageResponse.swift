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
import RestKit

/**
 A response from the Watson Assistant service.
 */
public struct MessageResponse: Codable, Equatable {

    /**
     The text of the user input.
     */
    public var input: MessageInput?

    /**
     An array of intents recognized in the user input, sorted in descending order of confidence.
     */
    public var intents: [RuntimeIntent]

    /**
     An array of entities identified in the user input.
     */
    public var entities: [RuntimeEntity]

    /**
     Whether to return more than one intent. A value of `true` indicates that all matching intents are returned.
     */
    public var alternateIntents: Bool?

    /**
     State information for the conversation. To maintain state, include the context from the previous response.
     */
    public var context: Context

    /**
     An output object that includes the response to the user, the dialog nodes that were triggered, and messages from
     the log.
     */
    public var output: OutputData

    /**
     An array of objects describing any actions requested by the dialog node.
     */
    public var actions: [DialogNodeAction]?

    /// Additional properties associated with this model.
    public var additionalProperties: [String: JSON]

    // Map each property name to the key that shall be used for encoding/decoding.
    private enum CodingKeys: String, CodingKey {
        case input = "input"
        case intents = "intents"
        case entities = "entities"
        case alternateIntents = "alternate_intents"
        case context = "context"
        case output = "output"
        case actions = "actions"
        static let allValues = [input, intents, entities, alternateIntents, context, output, actions]
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        input = try container.decodeIfPresent(MessageInput.self, forKey: .input)
        intents = try container.decode([RuntimeIntent].self, forKey: .intents)
        entities = try container.decode([RuntimeEntity].self, forKey: .entities)
        alternateIntents = try container.decodeIfPresent(Bool.self, forKey: .alternateIntents)
        context = try container.decode(Context.self, forKey: .context)
        output = try container.decode(OutputData.self, forKey: .output)
        actions = try container.decodeIfPresent([DialogNodeAction].self, forKey: .actions)
        let dynamicContainer = try decoder.container(keyedBy: DynamicKeys.self)
        additionalProperties = try dynamicContainer.decode([String: JSON].self, excluding: CodingKeys.allValues)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(input, forKey: .input)
        try container.encode(intents, forKey: .intents)
        try container.encode(entities, forKey: .entities)
        try container.encodeIfPresent(alternateIntents, forKey: .alternateIntents)
        try container.encode(context, forKey: .context)
        try container.encode(output, forKey: .output)
        try container.encodeIfPresent(actions, forKey: .actions)
        var dynamicContainer = encoder.container(keyedBy: DynamicKeys.self)
        try dynamicContainer.encodeIfPresent(additionalProperties)
    }

}
