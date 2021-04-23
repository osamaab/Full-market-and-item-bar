//
//  PaymentCardValidator.swift
//  talabyeh
//
//  Created by Hussein Work on 17/11/2020.
//  Copyright © 2020 Dominate. All rights reserved.
//

import Foundation

struct PaymentCardValidator: ValidatorType {
    
    var acceptedTypes: [PaymentCardType]
    
    init(acceptedTypes: [PaymentCardType] = PaymentCardType.allCases){
        self.acceptedTypes = acceptedTypes
    }
    
    func validated(_ input: String?) throws -> String {
        guard let input = input else {
            throw ValidationError("Enter an input please")
        }
        
        
        let numbersOnly = input.replacingOccurrences(
             of: "[^0-9]+",
             with: "",
             options: .regularExpression,
             range: nil
         )
         let formattedCardNumber = numbersOnly.trimmingCharacters(
             in: CharacterSet.whitespacesAndNewlines
         )

         guard luhnCheck(cardNumber: formattedCardNumber) else {
            throw ValidationError("Invalid card number")
         }
        
         guard let cardType = PaymentCardType(cardNumber: formattedCardNumber) else {
            throw ValidationError("Invalid card number")
         }

         let isSupported = acceptedTypes.contains(cardType)
        if isSupported {
            return input
        } else {
            throw ValidationError("Unsupported credit card type")
        }
    }
    
    private func luhnCheck(cardNumber: String) -> Bool {
        guard cardNumber.count > PaymentCardType.Constants.minimumLengthForValidation else {
            return false
        }
        let originalCheckDigit = Int(String(cardNumber.last!))
        
        var sum = 0
        let reversedCharacters = cardNumber.dropLast().reversed().map { String($0) }
        for (idx, element) in reversedCharacters.enumerated() {
            guard let digit = Int(element) else {
                return false
            }
            if idx % 2 == 0 && 0...8 ~= digit {
                sum += (digit * 2) % 9
            } else {
                sum += digit
            }
        }
        
        sum *= 9
        let computedCheckDigit = sum % 10
        
        return computedCheckDigit == originalCheckDigit
    }
}



/// Payment card type enum for credit/debit cards
public enum PaymentCardType: String, CaseIterable {

    internal enum Constants {

        /// Minimum length of card number required before doing number validation.
        static let minimumLengthForValidation = 12
        /// Minimum length of card number required before performing suggestion.
        static let minimumLengthForSuggestion = 4
    }

    case amex = "American Express"
    case mastercard = "MasterCard"
    case maestro = "Maestro"
    case visa = "Visa"
    case visaElectron = "Visa Electron"
    case discover = "Discover"
    case dinersClub = "Diners Club"

    /**
     Initializer.
     - parameter cardNumber: Credit/Debit card number with which card type should be attempted to
     be made.
     */
    public init?(cardNumber: String) {
        guard let type = PaymentCardType.typeForCardNumber(cardNumber) else {
            return nil
        }

        self.init(rawValue: type.rawValue)
    }

    /// This method actually validates the card number.
    private static func typeForCardNumber(_ cardNumber: String?) -> PaymentCardType? {

        guard let cn = cardNumber else {
            return nil
        }
        return PaymentCardType.allCases.first {
            return NSPredicate(format: "SELF MATCHES %@", $0.cardNumberRegex).evaluate(with: cn)
        }
    }

    private var cardNumberRegex: String {

        switch self {
        case .amex:
            // 15 digits starts with 34|37
            return "^3[47]\\d{13}$"
        case .mastercard:
            // 16 digits starts with 51-55|2221-2720
            return "^((5[1-5]\\d{4}|677189)\\d{10})|((222[1-9]|22[3-9]\\d|2[3-6]\\d{2}|27[0-1]\\d|2720)\\d{12})$"
        case .maestro:
            // 16 or 19 digits, starting with 5018|5020|5038|6304|6703|6708|6759|6761-6763
            return "^(5018|5020|5038|6304|670[38]|6759|676[1-3])\\d{12}(?:\\d{3})?$"
        case .visaElectron:
            // 13 or 16 digits. starts with 417500|4026|4405|4508|4844|4913|4917.
            return "^(417500\\d{7}|4(026|405|508|844|91[37])\\d{9})(?:\\d{3})?$"
        case .visa:
            // 13 or 16 digits. starts with 4
            return "^4\\d{12}(?:\\d{3})?$"
        case .discover:
            // 16 or 19 digits. starts with 6011|644-649|65|622
            return "^6(?:011|4[4-9]\\d|5\\d{2}|22\\d)\\d{12}(?:\\d{3})?$"
        case .dinersClub:
            // 14 digits. Starting with 300-305|36|38
            return "^3(?:0[0-5]|[68]\\d)\\d{11}$"
        }
    }
}
