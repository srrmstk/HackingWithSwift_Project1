//
//  DetailViewController.swift
//  Project1
//
//  Created by srrmstk on 23.05.2023.
//

import UIKit

class DetailViewController: UIViewController {
  @IBOutlet var imageView: UIImageView!

  var selectedImage: String?
  var currentImageIndex: Int?
  var allImageCount: Int?

  override func viewDidLoad() {
    super.viewDidLoad()

    navigationItem.largeTitleDisplayMode = .never
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))

    if let currentIndex = currentImageIndex, let imageCount = allImageCount {
      title = "Picture \(currentIndex) of \(imageCount)"
    }
    if let image = selectedImage {
      imageView.image = UIImage(named: image)
    }
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.hidesBarsOnTap = true
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.hidesBarsOnTap = false
  }

  @objc func shareTapped() {
    guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
      return
    }

    let activityViewController = UIActivityViewController(activityItems: [selectedImage ?? "", image], applicationActivities: [])
    activityViewController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
    present(activityViewController, animated: true)
  }

  /*
   // MARK: - Navigation

   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */

}
