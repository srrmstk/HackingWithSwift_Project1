//
//  ViewController.swift
//  Project1
//
//  Created by srrmstk on 22.05.2023.
//

import UIKit

class ViewController: UITableViewController {
  var pictures = [String]()

  override func viewDidLoad() {
    super.viewDidLoad()

    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(recommendApp))

    title = "Storm Viewer"
    let fm = FileManager.default
    let path = Bundle.main.resourcePath!
    let items = try! fm.contentsOfDirectory(atPath: path)

    for item in items {
      if item.hasPrefix("nssl") {
        pictures.append(item)
      }
    }
    pictures.sort()
  }

  @objc func recommendApp() {
    let recommendString = "Hey! I'm using \"Project1\" app, go and try too!"
    let vc = UIActivityViewController(activityItems: [recommendString], applicationActivities: [])
    vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
    present(vc, animated: true)
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return pictures.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
    var content = cell.defaultContentConfiguration()
    content.text = pictures[indexPath.row]
    cell.contentConfiguration = content
    return cell
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let detailViewController = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
      detailViewController.selectedImage = pictures[indexPath.row]
      detailViewController.allImageCount = pictures.count
      detailViewController.currentImageIndex = indexPath.row + 1
      navigationController?.pushViewController(detailViewController, animated: true)
    }
  }


}

