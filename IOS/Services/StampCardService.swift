import Foundation
import SwiftData

enum StampCardServiceError: LocalizedError {
    case programNotFound
    case invalidStampRequirement
    case rewardMustBeRedeemedFirst
    case noRewardAvailable

    var errorDescription: String? {
        switch self {
        case .programNotFound:
            return "Bu karta bağlı bir program bulunamadı."
        case .invalidStampRequirement:
            return "Programın gerekli damga sayısı geçersiz."
        case .rewardMustBeRedeemedFirst:
            return "Yeni damga eklemeden önce kazanılan ödül kullanılmalı."
        case .noRewardAvailable:
            return "Kullanılabilecek bir ödül bulunmuyor."
        }
    }
}

enum StampCardService {

    static func addStamp(
        to card: StampCard,
        context: ModelContext
    ) throws {
        guard let program = card.program else {
            throw StampCardServiceError.programNotFound
        }

        guard program.requiredStamps > 0 else {
            throw StampCardServiceError.invalidStampRequirement
        }

        guard card.stampCount < program.requiredStamps else {
            throw StampCardServiceError.rewardMustBeRedeemedFirst
        }

        card.stampCount += 1
        card.lifetimeStamps += 1

        if card.stampCount == program.requiredStamps {
            card.availableRewards += 1
        }

        try context.save()
    }

    static func redeemReward(
        for card: StampCard,
        context: ModelContext
    ) throws {
        guard card.availableRewards > 0 else {
            throw StampCardServiceError.noRewardAvailable
        }

        card.availableRewards -= 1
        card.stampCount = 0

        try context.save()
    }
}
