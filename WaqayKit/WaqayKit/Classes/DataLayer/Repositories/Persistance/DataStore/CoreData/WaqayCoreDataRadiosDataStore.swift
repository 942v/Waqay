//
//  WaqayCoreDataRadiosDataStore.swift
//  Pods
//
//  Created by Guillermo Andrés Sáenz Urday on 5/9/20.
//

import Foundation
import CoreData
import PromiseKit

public class WaqayCoreDataRadiosDataStore {
    
    private let coreDataStack: CoreDataStack
    
    public init(with coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
    }
}

extension WaqayCoreDataRadiosDataStore: RadiosDataStore {
    public func readUser() -> Promise<User> {
        return Promise<User> { seal in
            readUserSync(seal: seal)
        }
    }
    
    public func update(radiosData: [RadioData]) -> Promise<Bool> {
        return Promise<Bool> { seal in
            updateAsync(radiosData: radiosData, seal: seal)
        }
    }
    
    public func mainContext() -> NSManagedObjectContext {
        coreDataStack.mainContext
    }
    
    public func newChildContext() -> NSManagedObjectContext {
        coreDataStack.newChildContext()
    }
    
    public func saveMainContext() {
        coreDataStack.saveContext()
    }
    
    public func save(_ context: NSManagedObjectContext) {
        coreDataStack.saveContext(context)
    }
}

// MARK: - User
private extension WaqayCoreDataRadiosDataStore {
    func makeUserFetchRequest() -> NSFetchRequest<User> {
        let fetchRequest = NSFetchRequest<User>(entityName: User.entityName)
        return fetchRequest
    }
    
    func readUserSync(seal: Resolver<User>) {
        let userFetchRequest = makeUserFetchRequest()
        do {
            let userFetchResult = try coreDataStack.mainContext.fetch(userFetchRequest)
            guard let user = userFetchResult.first else {
                createUserSync(seal: seal)
                return
            }
            seal.fulfill(user)
        } catch let error {
            seal.reject(error)
        }
    }
    
    func createUserSync(seal: Resolver<User>) {
        let user = User(context: coreDataStack.mainContext)
        coreDataStack.saveContext()
        seal.fulfill(user)
    }
}

private extension WaqayCoreDataRadiosDataStore {
    func updateAsync(radiosData: [RadioData], seal: Resolver<Bool>) {
        let updaterContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        updaterContext.parent = coreDataStack.mainContext
        
        do {
            for radioData in radiosData {
                let fetchRequest = NSFetchRequest<Radio>(entityName: Radio.entityName)
                fetchRequest.predicate = NSPredicate(format: "%K == %@", #keyPath(Radio.name), radioData.name)
                
                let results = try updaterContext.fetch(fetchRequest)
                var object = results.first
                if object == nil {
                    object = Radio(context: updaterContext)
                }
                
                guard let radio = object else {
                    // TODO: Return error
                    fatalError("Error")
                }
                
                radio.id = Int16(radioData.id)
                radio.name = radioData.name
                radio.website = radioData.website
                update(radio: radio, streamsData: radioData.streams, in: updaterContext)
                update(radio: radio, socialNetworksData: radioData.socialNetworks, in: updaterContext)
                update(radio: radio, frequenciesData: radioData.frequencies, in: updaterContext)
            }
        } catch let error as NSError {
            fatalError("Error: \(error.localizedDescription)")
        }
        
        updaterContext.perform {
            do {
                try updaterContext.save()
            } catch let error as NSError {
                // TODO: Return error
                fatalError("Error: \(error.localizedDescription)")
            }
            
            self.coreDataStack.saveContext()
        }
        seal.fulfill(true)
    }
    
    private func update(radio: Radio, streamsData: [RadioStreamData], in context: NSManagedObjectContext) {
        
        if let currentStreams = radio.streams {
            radio.removeFromStreams(currentStreams)
        }
        
        for streamData in streamsData {
            let stream = Stream(context: context)
            
            stream.subname = streamData.subname
            stream.explanation = streamData.description
            stream.stream = streamData.stream
            stream.renewStream = streamData.renewStream
            stream.logo = streamData.logo
            
            radio.addToStreams(stream)
        }
    }
    
    private func update(radio: Radio, frequenciesData: [RadioFrequencyData]?, in context: NSManagedObjectContext) {
        
        guard let data = frequenciesData else {
            return
        }
        
        if let currentFrequencies = radio.frequencies {
            radio.removeFromFrequencies(currentFrequencies)
        }
        
        for frequencyData in data {
            let frequency = Frequency(context: context)
            
            frequency.city = frequencyData.city
            frequency.modulation = frequencyData.modulation
            
            radio.addToFrequencies(frequency)
        }
    }
    
    private func update(radio: Radio, socialNetworksData: RadioSocialNetworksData?, in context: NSManagedObjectContext) {
        
        guard let data = socialNetworksData else {
            return
        }
        
        let socialNetworks = SocialNetworks(context: context)
        
        socialNetworks.instagram = data.instagram
        socialNetworks.facebook = data.facebook
        socialNetworks.youtube = data.youtube
        socialNetworks.twitter = data.twitter
        socialNetworks.whatsapp = data.whatsapp
        socialNetworks.telephoneNumber = data.telephoneNumber
        
        radio.socialNetworks = socialNetworks
    }
}
