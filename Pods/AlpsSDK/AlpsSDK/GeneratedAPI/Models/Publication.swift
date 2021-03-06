//
// Publication.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


/** A publication can be seen as a JavaMessagingService (JMS) publication extended with the notion of a geographical zone. The zone is defined as circle with a center at the given location and a range around that location.  */
open class Publication: JSONEncodable {

    /** The id (UUID) of the publication. */
    public var id: String?
    /** The timestamp of the publication creation in seconds since Jan 01 1970 (UTC).  */
    public var createdAt: Int64?
    /** The id (UUID) of the world that contains device to attach a publication to. */
    public var worldId: String?
    /** The id (UUID) of the device to attach a publication to. */
    public var deviceId: String?
    /** The topic of the publication. This will act as a first match filter. For a subscription to be able to match a publication they must have the exact same topic.  */
    public var topic: String?
    /** In some cases a develop might want to show the location.  */
    public var location: Location?
    /** The range of the publication in meters. This is the range around the device holding the publication in which matches with subscriptions can be triggered.  */
    public var range: Double?
    /** The duration of the publication in seconds. If set to &#39;0&#39; it will be instant at the time of publication. Negative values are not allowed.  */
    public var duration: Double?
    /** The dictionary of key, value pairs. Allowed values are number, boolean, string and array of afformentioned types */
    public var properties: [String: Any]?

    public init() {}

    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["id"] = self.id
        nillableDictionary["createdAt"] = self.createdAt?.encodeToJSON()
        nillableDictionary["worldId"] = self.worldId
        nillableDictionary["deviceId"] = self.deviceId
        nillableDictionary["topic"] = self.topic
        nillableDictionary["location"] = self.location?.encodeToJSON()
        nillableDictionary["range"] = self.range
        nillableDictionary["duration"] = self.duration
        nillableDictionary["properties"] = self.properties

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
