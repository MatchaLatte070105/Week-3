import Foundation

struct ShippingAddress: Codable, Hashable {
    var fullName: String
    var phoneNumber: String
    var streetAddress: String
    var ward: String
    var district: String
    var city: String
    
    init(fullName: String = "", phoneNumber: String = "", streetAddress: String = "", ward: String = "", district: String = "", city: String = "TP. Hồ Chí Minh") {
        self.fullName = fullName
        self.phoneNumber = phoneNumber
        self.streetAddress = streetAddress
        self.ward = ward
        self.district = district
        self.city = city
    }
    
    var fullAddressString: String {
        return "\(streetAddress), \(ward), \(district), \(city)"
    }
}
