//
//  Radio+CoreDataProperties.swift
//  
//
//  Created by Guillermo Sáenz on 5/18/20.
//
//

import Foundation
import CoreData


extension Radio {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Radio> {
        return NSFetchRequest<Radio>(entityName: "Radio")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var website: URL?
    @NSManaged public var frequencies: NSSet?
    @NSManaged public var socialNetworks: SocialNetworks?
    @NSManaged public var streams: NSSet?
    @NSManaged public var users: NSSet?

}

// MARK: Generated accessors for frequencies
extension Radio {

    @objc(addFrequenciesObject:)
    @NSManaged public func addToFrequencies(_ value: Frequency)

    @objc(removeFrequenciesObject:)
    @NSManaged public func removeFromFrequencies(_ value: Frequency)

    @objc(addFrequencies:)
    @NSManaged public func addToFrequencies(_ values: NSSet)

    @objc(removeFrequencies:)
    @NSManaged public func removeFromFrequencies(_ values: NSSet)

}

// MARK: Generated accessors for streams
extension Radio {

    @objc(addStreamsObject:)
    @NSManaged public func addToStreams(_ value: Stream)

    @objc(removeStreamsObject:)
    @NSManaged public func removeFromStreams(_ value: Stream)

    @objc(addStreams:)
    @NSManaged public func addToStreams(_ values: NSSet)

    @objc(removeStreams:)
    @NSManaged public func removeFromStreams(_ values: NSSet)

}

// MARK: Generated accessors for users
extension Radio {

    @objc(addUsersObject:)
    @NSManaged public func addToUsers(_ value: User)

    @objc(removeUsersObject:)
    @NSManaged public func removeFromUsers(_ value: User)

    @objc(addUsers:)
    @NSManaged public func addToUsers(_ values: NSSet)

    @objc(removeUsers:)
    @NSManaged public func removeFromUsers(_ values: NSSet)

}
