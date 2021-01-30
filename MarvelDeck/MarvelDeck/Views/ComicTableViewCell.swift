//
//  ComicTableViewCell.swift
//  MarvelDeck
//
//  Created by Lee McCormick on 1/30/21.
//

import UIKit

class ComicTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var comicImageView: UIImageView!
    @IBOutlet weak var comicTitelLabel: UILabel!
    @IBOutlet weak var comicPriceLabel: UILabel!
    
    // MARK: - Methods
    func updateViews(comic: Comic.Data.Result) {
        comicTitelLabel.text = comic.title
        comicPriceLabel.text = "Page: \(comic.pageCount)"
        
        ComicController.fetchThumbnail(for: comic) { (result) in
            DispatchQueue.main.async {
                switch result {
                
                case .success(let thumbnail):
                    self.comicImageView.image = thumbnail
                case .failure(let error):
                    self.comicImageView.image = UIImage(named: "forest")
                }
            }
        }
    }
}
