//
//  ViewController.swift
//  popopo
//
//  Created by prithvi-pt2335 on 09/06/19.
//  Copyright © 2019 prithvi-pt2335. All rights reserved.
//

//import Cocoa
//import MapKit
//class ViewController: NSViewController {
//
//    @IBOutlet weak var customView: NSView!
//    @IBOutlet weak var tableView: NSTableView!
//    @IBOutlet weak var scrollView: NSScrollView!
//    @IBOutlet weak var searchBar: NSSearchField!
//    var searchCompleter = MKLocalSearchCompleter()
//    var searchResults = [MKLocalSearchCompletion]()
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        searchBar.delegate=self
//        searchCompleter.delegate = self
//        tableView.delegate=self
//        tableView.dataSource=self
////        tableView.selectionHighlightStyle = .regular
//        // Do any additional setup after loading the view.
//    }
//
//    override var representedObject: Any? {
//        didSet {
//        // Update the view, if already loaded.
//        }
//    }
//
//
//}
//
//extension ViewController: NSSearchFieldDelegate {
//
//     func controlTextDidChange(_ obj: Notification){
//        let searchObject:NSSearchField? = obj.object as? NSSearchField
//        if searchObject==self.searchBar{
//            searchCompleter.queryFragment = searchObject!.stringValue
//            customView.alphaValue=1
//
//        }
//    }
//
//    func controlTextDidEndEditing(_ obj: Notification) {
//        let searchObject:NSSearchField? = obj.object as? NSSearchField
//        if searchObject==self.searchBar{
//            customView.alphaValue=0.0
//
//        }
//    }
//
//}
//
//extension ViewController: MKLocalSearchCompleterDelegate {
//
//    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
//        searchResults = completer.results
//        tableView.reloadData()
//    }
//
//    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
//        // handle error
//    }
//}
//extension ViewController: NSTableViewDataSource , NSTableViewDelegate{
//
//    func numberOfRows(in tableView: NSTableView) -> Int {
////        print(searchResults.count)
//        return searchResults.count
//    }
//    func tableViewSelectionDidChange(_ notification: Notification) {
//                guard let table = notification.object as? NSTableView else {
//                    return
//                }
//                let row = table.selectedRow
//        let searchResult = searchResults[row]
//        searchBar.stringValue=searchResult.title+searchResult.subtitle
//        searchBar.sizeToFit()
//        print(444)
////        customView.alphaValue=0
//         tableView.selectionHighlightStyle = .none
//        tableView.reloadData()
//    }
//
//    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView?{
//        let searchResult = searchResults[row]
//        let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "defaultRow"), owner: self)as! KSTableCellView
////        print(searchResult.title,"pooo",searchResult.subtitle,"iiii")
//        cell.detail.attributedStringValue = highlightedText(searchResult.title+"\n"+searchResult.subtitle, inRanges: searchResult.titleHighlightRanges, size: 13.0)
//        return cell
//    }
//    func highlightedText(_ text: String, inRanges ranges: [NSValue], size: CGFloat) -> NSAttributedString {
//        let attributedText = NSMutableAttributedString(string: text)
//        let regular = NSFont.systemFont(ofSize: size)
//        attributedText.addAttribute(NSAttributedString.Key.font, value:regular, range:NSMakeRange(0, text.count))
//
//        let bold = NSFont.boldSystemFont(ofSize: size)
//        for value in ranges {
//            attributedText.addAttribute(NSAttributedString.Key.font, value:bold, range:value.rangeValue)
//        }
//        return attributedText
//    }
//}
import Cocoa

class ViewController: NSViewController,NSSearchFieldDelegate{
    @IBOutlet weak var searchBar: NSSearchField!
    var secondVC:SecondViewController?
    override func viewDidLoad() {
                super.viewDidLoad()
        searchBar.delegate=self
    }
    func controlTextDidChange(_ obj: Notification){
                let searchObject:NSSearchField? = obj.object as? NSSearchField
                if searchObject==self.searchBar{
                    if(secondVC == nil){
                        secondVC=storyboard?.instantiateController(withIdentifier: "vc") as? SecondViewController
                    }
                    secondVC!.delegate=self
                    secondVC!.searchString = searchBar.stringValue
//                    print(secondVC)
                    
                   
                    
                    if(SecondViewController.presented == false && secondVC!.searchString != ""){
                    self.present(secondVC!, asPopoverRelativeTo: searchBar.bounds, of: searchBar, preferredEdge: .maxY, behavior: .semitransient)
                    }
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AutoComplete"), object: nil)

                }
            }
    
}
