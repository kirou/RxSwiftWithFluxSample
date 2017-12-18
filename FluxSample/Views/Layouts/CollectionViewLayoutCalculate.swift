import Foundation
import Library

enum CellRatio {
    
    case imageBox
    
    var heightPerWidth: CGFloat {
        switch self {
        case .imageBox:
            return 1.0 / 1.0
        }
    }
}

final class CollectionViewLayoutCalculate {
    
    /// 端からViewまでのinsetsize
    static let viewInsetsHorizon: CGFloat = 15
    
    /// 行と行の間にどれだけinsetを入れるか
    fileprivate static let forCell: CGFloat = 10
    
    struct UserItem {
        /// 最低限どこまでcellとcellの間にinsetを入れるか
        static let cellInsets: CGFloat = 10
        /// 1行に最低どれだけitemを表示するか
        static let minLaneCount: CGFloat = 5
        /// 1行に最大どれだけitemを表示するか
        static let maxLaneCount: CGFloat = 10
        /// 最低限のセルの横幅
        static let minCellWidth: CGFloat = 50
    }
    
    static func cellSize(viewWidth: CGFloat, cellRatio: CellRatio = .imageBox) -> (laneCount: CGFloat, size: CGSize) {
        
        return seriesTitleCellCalculate(viewWidth: viewWidth, cellRatio: cellRatio)
    }
}

fileprivate extension CollectionViewLayoutCalculate {
    
    static func seriesTitleCellCalculate(viewWidth: CGFloat, cellRatio: CellRatio = .imageBox) -> (laneCount: CGFloat, size: CGSize) {
        
        let minImageWidth: CGFloat = UserItem.minCellWidth
        var laneCount: CGFloat = floor(viewWidth / minImageWidth)
        
        if laneCount > UserItem.maxLaneCount {
            laneCount = UserItem.maxLaneCount
        }
        
        if laneCount < UserItem.minLaneCount {
            laneCount = UserItem.minLaneCount
        }
        
        // 画像の幅の決定
        let cellMargin: CGFloat = forCell * (laneCount - 1)
        let width: CGFloat = ((viewWidth - cellMargin) / laneCount) - 1
        let height: CGFloat = floor(width * cellRatio.heightPerWidth)
        let size: CGSize = CGSize(width: width, height: height)
        
        return (laneCount: laneCount, size: size)
    }
}
