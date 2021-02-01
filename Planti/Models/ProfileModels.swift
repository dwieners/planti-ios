//
//  ProfileModels.swift
//  Planti
//
//  Created by Dominik Wieners on 31.01.21.
//

import Foundation
import SwiftUI

enum AchievementType: String, CaseIterable, Codable {
    var id: Int {
        self.hashValue
    }
   case STANDARD = "STANDARD"
   case HORNS_HAT = "HORNS_HAT"
   case PUMPKIN_HAT = "PUMPKIN_HAT"
   case FRANKENSTEIN_HAT = "FRANKENSTEIN_HAT"
}



func getImage(by archivementType: AchievementType) -> Image{
    switch archivementType {
    case .STANDARD:
        return Image("witch-hat")
    case .HORNS_HAT:
        return Image("horns")
    case .PUMPKIN_HAT:
        return Image("pumpkin")
    case .FRANKENSTEIN_HAT:
        return Image("frankenstein")
    }
}



func getImage(by figureType: FigureType) -> Image {
    switch figureType {
    case .WITCH:
        return Image("witch_character")
    case .WIZARD:
        return Image("wizard_character")
    }
}




///
/// # MyAvatar
///
struct MyAvatar: Codable, Identifiable {
    let id: Int
    let username: String
    let score: Int
    let avatar_name: String
    let figure_type: FigureType
    let achievements: [MyAchievementItem]
}



///
/// # MyArchivementItem
///
struct MyAchievementItem: Codable, Identifiable{
    let id: Int
    let name: String
    let description: String
    let type: AchievementType
  
}

///
/// # MyInventory
///
struct MyInventoryItem: Codable, Identifiable {
    let id: Int
    let name: String
    let description: String
    let score_to_unlock: Int
    let type: AchievementType
    let unlocked: Bool
}


///
/// # MyMissions
///
struct MyMissions: Codable {
    let active: [MyActiveMission]
    let inactive: [MyInactiveMission]
}

///
/// # MyActiveMission
///
struct MyActiveMission: Codable, Identifiable {
    let id: Int
    let image_url: String?
    let title: String
    let description: String
    let complete_targets: Int
    let total_targets: Int
}

///
/// # MyInactiveMission
///
struct MyInactiveMission: Codable, Identifiable {
    let id: Int
    let image_url: String?
    let title: String
    let description: String
    let complete_targets: Int
    let total_targets: Int
}



///
/// # MyMissionInfoStatus
///
struct MyMissionInfoStatus: Codable {
    let mission: MyMissionStatus
    let mission_targets: [MyMissionTargetStatus]
}

///
/// # MyMissionStatus
///
struct MyMissionStatus: Codable, Identifiable {
    let id: Int
    let image_url: String?
    let title: String
    let description: String
    let points: Int
    let is_active: Bool
}


///
/// # MyMissionTargetStatus
///
struct MyMissionTargetStatus: Codable, Identifiable {
    let id: Int
    let title: String
    let description: String?
    let is_completed: Bool
}


///
/// # MyMissionCompleteStatus
///

struct MyMissionTargetCompleteStatus: Codable {
    let mission_title: String
    let target_title: String
}

