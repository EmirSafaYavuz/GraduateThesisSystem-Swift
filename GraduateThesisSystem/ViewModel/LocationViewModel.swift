//
//  LocationViewModel.swift
//  GraduateThesisSystem
//
//  Created by Emir Safa Yavuz on 23.12.2023.
//

import Foundation

class LocationViewModel: ObservableObject {
    @Published var locations: [Location] = []
    
    func getAllLocations() {
        LocationAPI.getAllLocations { result in
            switch result {
            case .success(let fetchedLocations):
                DispatchQueue.main.async {
                    self.locations = fetchedLocations
                }
            case .failure(let error):
                print("Error loading locations: \(error)")
            }
        }
    }
    
    func addLocation(location: Location) {
        LocationAPI.addLocation(location: location) { result in
            switch result {
            case .success(let addedLocation):
                DispatchQueue.main.async {
                    self.locations.append(addedLocation)
                }
            case .failure(let error):
                print("Error adding location: \(error)")
            }
        }
    }
    
    func deleteLocation(with locationId: Int?) {
        guard let locationId = locationId else {
            print("Location id is nil, cannot delete.")
            return
        }
        
        LocationAPI.deleteLocation(with: locationId) { result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.locations.removeAll { $0.id == locationId }
                }
            case .failure(let error):
                print("Error deleting location: \(error)")
            }
        }
    }
}
