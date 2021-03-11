//
//  ColorDataSource.swift
//  CollectionDiffable
//
//  Created by Lee McCormick on 3/10/21.
//

import UIKit

class Color{
    let shade: UIColor
    let family: ColorSection
    let id = UUID()
    
    init(color: UIColor, family: ColorSection) {
        self.shade = color
        self.family = family
    }
}

extension Color: Hashable {
    static func == (lhs: Color, rhs: Color) -> Bool {
        lhs === rhs
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(shade)
        hasher.combine(family)
        hasher.combine(id)
    }
}

enum ColorSection: String, CaseIterable{
    case warm
    case cool
    
    var title: String {
        self.rawValue.uppercased()
    }
}

class ColorDataSource: UICollectionViewDiffableDataSource<ColorSection, Color> {
  
    init(collectionView: UICollectionView) {
        super.init(collectionView: collectionView) { (collectionView, indexPath, color) -> UICollectionViewCell? in
    
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath)
            
            cell.backgroundColor = color.shade
            return cell
        }
        
            collectionView.collectionViewLayout = constructLayout()
    }
    
    func applyItems(_ colors: [Color]) {
        var snapshot = NSDiffableDataSourceSnapshot<ColorSection, Color>()
        snapshot.appendSections(ColorSection.allCases)
        snapshot.appendItems(colors.filter {$0.family == .cool}, toSection: .cool)
        snapshot.appendItems(colors.filter {$0.family == .warm}, toSection: .warm)
        
        apply(snapshot)
    }
    
    func constructLayout() -> UICollectionViewLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
       
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.5))
       
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        
        group.interItemSpacing = .fixed(5)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.contentInsets = .init(top: 5,
                                      leading: 5,
                                      bottom: 5,
                                      trailing: 5)
        
        section.interGroupSpacing = 5
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
}
