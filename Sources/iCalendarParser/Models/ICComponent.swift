import Foundation

struct ICComponent {
    let properties: [ICProperty]
    let childProperties: [ICProperty]
    
    /// Returns a property that matches the name
    func getProperty(
        name: String
    ) -> ICProperty? {
        return properties
            .filter { $0.name.hasPrefix(name) }
            .first
    }
    
    /// Returns a property that matches the name
    func getProperties(
        name: String
    ) -> [ICProperty]? {
        return properties
            .filter { $0.name.hasPrefix(name) }
    }
    
    // MARK: - Build property
    
    /// Returns `ICDateTime` from properties
    func buildProperty(
        of name: String
    ) -> ICDateTime? {
        guard let prop = getProperty(name: name) else {
            return nil
        }
       
        return PropertyBuilder.buildDateTime(from: prop)
    }
    
    /// Returns `String` from properties
    func buildProperty(
        of name: String
    ) -> String? {
        guard let prop = getProperty(name: name) else {
            return nil
        }
        
        return prop.value
    }
    
    /// Returns `Int` from properties
    func buildProperty(
        of name: String
    ) -> Int? {
        guard let prop = getProperty(name: name) else {
            return nil
        }
        
        return Int(prop.value)
    }
    
    /// Returns `ICRRule` from properties
    func buildProperty(
        of name: String
    ) -> ICRRule? {
        guard let prop = getProperty(name: name) else {
            return nil
        }
        
        return PropertyBuilder.buildRRule(from: prop)
    }
    
    /// Returns `[Attendee]` from properties
    func buildAttendees(
        of name: String
    ) -> [ICAttendee]? {
        guard let props = getProperties(name: name) else {
            return nil
        }
        
        return PropertyBuilder.buildAttendees(from: props)
    }
    
    /// Returns all non-standard properties if exists
    func getNonStandardProperties() -> [String: String]? {
        var dict = [String: String]()
        
        properties
            .filter { $0.name.hasPrefix("X-") }
            .forEach { dict[$0.name] = $0.value }
        
        guard !dict.isEmpty else {
            return nil
        }
        
        return dict
    }
    
    // MARK: - Private functions
    
    /// Returns a property that matches the name in the given properties
    private func getProperty(
        name: String,
        from elements: [ICProperty]
    ) -> ICProperty? {
        return elements
            .filter { $0.name.hasPrefix(name) }
            .first
    }
}
