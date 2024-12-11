//
//  NotificationType.swift
//  Hydd
//
//  Created Macbook Pro on 21/03/2020.
//  Copyright © 2020 Syed Kashan. All rights reserved.

import Foundation

enum NotificationType: String {
    case mission_accepted = "mission_accepted",
    driver_onway = "driver_onway",
    day_completed = "day_completed",
    mission_completed = "mission_completed",
    client_onboard = "client_onboard",
    driver_waiting = "driver_waiting",
    location_changed = "location_changed",
    client_cancelled = "client_cancelled",
    mission_ending = "mission_ending",
    driver_cancelled = "driver_cancelled",
    mission_registered = "mission_registered",
    chat_pn = "chat_pn"
}
