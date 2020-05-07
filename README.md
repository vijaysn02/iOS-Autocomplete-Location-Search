# Location AutoComplete Search

## Introduction:

This project is created to understand the working of Location AutoComplete Search and also to have a ready made component for integration in the projects. 

If you want to implement it straight away, you can make copy the handler in the project and jump to the Usage part.

---------------------------------------------------------------------------------------------------

## Installation:

```
import Mapkit
```

----------------------------------------------------------------------------------------------------

## Configuration:

There is no specific configuration needed for this implementation.

----------------------------------------------------------------------------------------------------

## Coding Part - Handler:

There are four important section in this handler. (i) Defining the Location Search Types (ii) Initializing the Search Completer (iii) Detecting the change in Search Bar (iv) Get the Updated result from the Search Completer

### Defining the Location Search Types

```
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
```

### Initializing the Search Completer

```
    //MARK: - Initial Setup - setting up the search type and delegate
    extension AutoCompleteViewController {
        
        func initialViewSetup() {
            searchCompleter.delegate = self
            searchCompleter.resultTypes = resultType.searchType
        }
        
    }
```

### Detecting the change in Search Bar

```
    //MARK: - Search Bar Delegate - to detect the text change in search bar.
    extension AutoCompleteViewController: UISearchBarDelegate {
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            searchCompleter.queryFragment = searchText
        }
    }
```

### Get the Updated result from the Search Completer

```
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
```

----------------------------------------------------------------------------------------------------

## Helper Part

### Toast & Router are used for assisting the main functionality.

----------------------------------------------------------------------------------------------------

## Usage Part

### Invoke the below specific function to use in your View Controller. 

```
    //Triggering the Autocomplete search
    Router.navigateToAutoCompleteViewController(parentViewController: self,searchType: .pointOfInterest)
```

### Subscribe to the Autocomplete delegate to get the chosen location.

```
    //MARK: - Auto Complete Delegate
    extension ViewController:AutoCompleteDelegate {
      
        func selectedLocation(location: CLLocationCoordinate2D, locationName: String) {
            Toast.showasync(message: locationName, controller: self)
        }
        
    }

```



### Check out my Post about Location AutoComplete Search : [Location AutoComplete Search](https://vijaysn.com/uncategorized/ios-location-autocomplete)
