import Foundation
import UIKit
import Library

@IBDesignable final class UserListView: UIView {
    
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var didTapButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!

    @IBAction func didTapButtonAction() {
        didTapAllView?()
    }
    
    var inputNameLabel: String? {
        didSet {
            nameLabel.text = inputNameLabel
            nameLabel.sizeToFit()
        }
    }
    
    var data: [QiitaUser]? {
        didSet {
            guard let data = data, data.count > 0 else { return }
            
            /// セルのサイズを決定
            setCellSize(screenWidth: UIScreen.ex.width)
            
            invalidateIntrinsicContentSize()
            collectionView.reloadData()
            collectionView.isHidden = false
        }
    }
    
    /// 一覧ボタンを表示するか
    var isDisplayDidTapButton: Bool = true {
        didSet {
            didTapButton.isHidden = !isDisplayDidTapButton
        }
    }
    
    var didSelect: ((QiitaUser) -> Void)?
    var didTapAllView: (() -> Void)?

    fileprivate let sectionInsets: CGFloat = CollectionViewLayoutCalculate.viewInsetsHorizon
    fileprivate var cellSizeInfo: (laneCount: CGFloat, size: CGSize)?
    fileprivate let useCell = ImageCollectionViewCell.self

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        loadNib()
    }
    
    override func layoutSubviews() {
        
        self.nameLabel.preferredMaxLayoutWidth = self.bounds.width
        super.layoutSubviews()
    }
    
    override var intrinsicContentSize: CGSize {
        
        guard let data = data, let cellSizeInfo = cellSizeInfo else { return .zero }
        
        nameView.layoutIfNeeded()
        
        var size: CGSize = bounds.size
        let collectionViewOriginY = nameView.bounds.size.height
        let laneCount: CGFloat = CGFloat(data.count) / cellSizeInfo.laneCount
        let laneRoundUp: CGFloat = laneCount.rounded(.up)
        
        let cellFors: CGFloat = laneRoundUp * 10
        let collectionViewSizeHeight = laneRoundUp * cellSizeInfo.size.height
        let height: CGFloat = collectionViewSizeHeight
            + collectionViewOriginY
            + cellFors
        
        dump("intrinsicContentSizeintrinsicContentSizeintrinsicContentSize")
        dump(laneRoundUp)
        dump(collectionViewOriginY)
        dump(cellSizeInfo.size)
        dump(collectionViewSizeHeight)

        size.height = height
            
        return size
    }
    
    private func loadNib() {
        
        let bundle = Bundle(for: type(of: self))
        let view = UserListView.ex.instantiateUiView(
            withOwner: self,
            bundle: bundle
        )
        
        addSubview(view)
        ex.addConstraints(for: view)
        collectionView.ex.register(cellType: useCell, bundle: bundle)
        
        collectionView.isHidden = true
        collectionView.delegate = self
        collectionView.dataSource = self
        
        setCellSize(screenWidth: UIScreen.ex.width)
    }
    
    private func setCellSize(screenWidth: CGFloat) {
        
        let width = screenWidth - sectionInsets * 2
        
        cellSizeInfo = CollectionViewLayoutCalculate.cellSize(viewWidth: width)
    }
}

// MARK: - UICollectionViewDataSource

extension UserListView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.ex.dequeueReusableCell(with: useCell, for: indexPath)!
        guard let item = data?[indexPath.row] else { return cell }
        
        cell.inputThumbnail = item.profileImageUrl

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let model = data?[indexPath.row] else { return }
        didSelect?(model)
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension UserListView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let size = cellSizeInfo?.size else { return .zero }
        
        return size
    }
}
