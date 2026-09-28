import Foundation

// MARK: - Enums de clasificación
// Uso un Enum con valor en bruto (String) para clasificar el hardware de red
enum DeviceType: String, CaseIterable {
    case router = "Router"
    case switchDevice = "Switch"
    case server = "Servidor"
    case workstation = "Puesto de Trabajo"
}

// Estados operativos en los que puede encontrarse un equipo IT
enum DeviceStatus: String {
    case active = "ACTIVO"
    case maintenance = "EN MANTENIMIENTO"
    case offline = "FUERA DE SERVICIO"
}

// MARK: - Modelo de datos
// En Swift es estándar usar Structs para modelos de datos (Type Value / Inmutabilidad segura)
struct Device {
    let id: String
    var name: String
    var ipAddress: String
    var type: DeviceType
    var status: DeviceStatus
    var notes: String? // Opcional: Puede contener una observación técnica o ser nulo (nil)

    // Método formateador para mostrar la información en consola
    func details() -> String {
        // Desempaquetado seguro con operador nil-coalescing (??)
        let noteDisplay = notes ?? "Sin observaciones"
        return "[\(id)] \(name) | Tipo: \(type.rawValue) | IP: \(ipAddress) | Estado: \(status.rawValue) | Notas: \(noteDisplay)"
    }
}