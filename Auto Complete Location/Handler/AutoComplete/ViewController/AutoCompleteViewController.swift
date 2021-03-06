//
//  ViewController.swift
//  Sportrush Ambulance
//
//  Created by TPFLAP146 on 22/02/20.
//  Copyright © 2020 spotrush. All rights reserved.
//

import UIKit
import MapKit

//MARK: - Protocol - to return back values to view controller
protocol AutoCompleteDelegate {
    func selectedLocation(location:CLLocationCoordinate2D,locationName:String)
}

//MARK: - Location Search Types - to choose the correct type of search
enum LocationSearchTypes {
    
    case address
    case query
    case pointOfInterest
    
    var searchType : MKLocalSearchCompleter.ResultType {
     
        switch self {
      
        case .address: return .address
        case .query: return .query
        case .pointOfInterest: return .pointOfInterest
      
      }
        
    }
}

//MARK: - View Controller - Initialization
class AutoCompleteViewController: UIViewController {
    
    var searchCompleter = MKLocalSearchCompleter()
    var searchResults = [MKLocalSearchCompletion]()
    
    var delegate:AutoCompleteDelegate?
    var resultType:LocationSearchTypes = .address
    
    @IBOutlet weak var searchResultsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialViewSetup()
    }
}


//MARK: - Initial Setup - setting up the search type and delegate
extension AutoCompleteViewController {
    
    func initialViewSetup() {
        searchCompleter.delegate = self
        searchCompleter.resultTypes = resultType.searchType
    }
    
}

//MARK: - Button Actions
extension AutoCompleteViewController {
    
    @IBAction func backButtonClicked(sender:Any) {
        Router.closeViewController(viewController: self)
    }
    
}


//MARK: - Search Bar Delegate - to detect the text change in search bar.
extension AutoCompleteViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchCompleter.queryFragment = searchText
    }
}

//MARK: - Local Search Delegate - to get the result for the location query
extension AutoCompleteViewController: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        searchResultsTableView.reloadData()
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        // handle error
    }
}

//MARK: - Table View - Data Source
extension AutoCompleteViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchResult = searchResults[indexPath.row]
        let cell = LocationCell(style: .subtitle, reuseIdentifier: nil)
        
        //Setting up the address
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.subtitle
        return cell
    }
}

//MARK: - Table View - Delegate
extension AutoCompleteViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let completion = searchResults[indexPath.row]
        
        let searchRequest = MKLocalSearch.Request(completion: completion)
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            if let response = response {
                let coordinate = response.mapItems[0].placemark.coordinate
                
                //Sending back the chosen location
                self.delegate?.selectedLocation(location: coordinate, locationName: completion.title)
                Router.closeViewController(viewController: self)
            }
            
        }
        
        
    }
}



