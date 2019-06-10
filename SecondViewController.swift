//
//  SecondViewController.swift
//  popopo
//
//  Created by prithvi-pt2335 on 10/06/19.
//  Copyright © 2019 prithvi-pt2335. All rights reserved.
//

import Cocoa
import MapKit
class SecondViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource, MKLocalSearchCompleterDelegate {
    
    
    
    static var presented = false
    var delegate:ViewController?
    var searchString:String?
    @IBOutlet weak var tableView: NSTableView!
    var searchCompleter = MKLocalSearchCompleter()
    var searchResults = [MKLocalSearchCompletion]()
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(notificationAutoComplete), name: NSNotification.Name(rawValue: "AutoComplete"), object: nil)
        searchCompleter.delegate = self
        tableView.refusesFirstResponder = true
        tableView.delegate=self
        tableView.dataSource=self
        // Do view setup here.
    }
    
    override func viewDidAppear() {
        SecondViewController.presented=true
    }
    
    override func viewWillAppear() {
        searchResults.removeAll()
        tableView.reloadData()
    }

    
    override func viewDidDisappear() {
     
        SecondViewController.presented=false
    }
    
    
    @objc func notificationAutoComplete() {
        searchCompleter.queryFragment = searchString ?? ""
        print(searchString!)
    }
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        print("update")
        searchResults = completer.results
        print(searchResults.count)
        tableView.reloadData()
    }
    func numberOfRows(in tableView: NSTableView) -> Int {
                return searchResults.count
            }
    
            func tableViewSelectionDidChange(_ notification: Notification) {
                        guard let table = notification.object as? NSTableView else {
                            return
                        }
                        let row = table.selectedRow
                let searchResult = searchResults[row]
                delegate?.searchBar.stringValue=searchResult.title+searchResult.subtitle
                print(444)
                tableView.reloadData()
            }

    
            func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView?{
                let searchResult = searchResults[row]
                let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "defaultRow"), owner: self)as! KSTableCellView
                cell.detail.attributedStringValue = highlightedText(searchResult.title+"\n"+searchResult.subtitle, inRanges: searchResult.titleHighlightRanges, size: 13.0)
                print(searchResult.title+"\n"+searchResult.subtitle)
                return cell
            }
    
    
            func highlightedText(_ text: String, inRanges ranges: [NSValue], size: CGFloat) -> NSAttributedString {
                let attributedText = NSMutableAttributedString(string: text)
                let regular = NSFont.systemFont(ofSize: size)
                attributedText.addAttribute(NSAttributedString.Key.font, value:regular, range:NSMakeRange(0, text.count))
        
                let bold = NSFont.boldSystemFont(ofSize: size)
                for value in ranges {
                    attributedText.addAttribute(NSAttributedString.Key.font, value:bold, range:value.rangeValue)
                }
                return attributedText
            }
}



//extension NSTableView {
//    open override func mouseDown(with event: NSEvent) {
//        let globalLocation = event.locationInWindow
//        let localLocation = self.convert(globalLocation, from: nil)
//        let clickedRow = self.row(at: localLocation)
//        super.mouseDown(with: event)
//        if (clickedRow != -1) {
//            (self.delegate as? NSTableViewClickableDelegate)?.tableView(self, didClickRow: clickedRow)
//        }
//    }
//}
//
//protocol NSTableViewClickableDelegate: NSTableViewDelegate {
//    func tableView(_ tableView: NSTableView, didClickRow row: Int)
//}
