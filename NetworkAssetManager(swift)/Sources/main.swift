import Foundation

// Instancia del controlador
let manager = DeviceManager()
var isRunning = true

print("================================================")
print("     NETWORK ASSET MANAGER - SWIFT CONSOLE      ")
print("================================================")

// Bucle principal de ejecución
while isRunning {
    print("\n1. Ver todos los dispositivos")
    print("2. Registrar nuevo dispositivo")
    print("3. Filtrar por tipo (Switch, Router, Servidor...)")
    print("4. Cambiar estado operativo (Mantenimiento / Activo)")
    print("5. Salir")
    print("\nSelecciona una opción: ", terminator: "")

    // Lectura de entrada por consola validada de forma segura
    guard let input = readLine(), let option = Int(input) else {
        print("❌ Entrada inválida. Introduce un número del 1 al 5.")
        continue
    }

    switch option {
    case 1:
        manager.listAll()

    case 2:
        print("\n--- REGISTRO DE DISPOSITIVO ---")
        print("Nombre del equipo: ", terminator: "")
        let name = readLine() ?? "Sin nombre"

        print("Dirección IP (ej. 192.168.1.50): ", terminator: "")
        let ip = readLine() ?? "0.0.0.0"

        print("Tipo de dispositivo:\n 1. Router\n 2. Switch\n 3. Servidor\n 4. Puesto de Trabajo")
        print("Selecciona (1-4): ", terminator: "")
        let typeOption = Int(readLine() ?? "4") ?? 4

        let selectedType: DeviceType
        switch typeOption {
        case 1: selectedType = .router
        case 2: selectedType = .switchDevice
        case 3: selectedType = .server
        default: selectedType = .workstation
        }

        print("Observaciones (opcional): ", terminator: "")
        let notesInput = readLine()
        // Si el usuario da a Enter en blanco, guardamos nil
        let notes = (notesInput?.isEmpty ?? true) ? nil : notesInput

        manager.addDevice(name: name, ip: ip, type: selectedType, notes: notes)

    case 3:
        print("\n¿Qué categoría deseas filtrar?:")
        print(" 1. Routers\n 2. Switches\n 3. Servidores\n 4. Puestos de Trabajo")
        print("Selecciona (1-4): ", terminator: "")
        let catOption = Int(readLine() ?? "1") ?? 1

        let category: DeviceType
        switch catOption {
        case 1: category = .router
        case 2: category = .switchDevice
        case 3: category = .server
        default: category = .workstation
        }
        manager.filterByType(type: category)

    case 4:
        print("\nIntroduce el ID del dispositivo (ej. NET-001): ", terminator: "")
        let idToUpdate = readLine() ?? ""

        print("Nuevo estado:\n 1. ACTIVO\n 2. EN MANTENIMIENTO\n 3. FUERA DE SERVICIO")
        print("Selecciona (1-3): ", terminator: "")
        let statusOption = Int(readLine() ?? "1") ?? 1

        let newStatus: DeviceStatus
        switch statusOption {
        case 2: newStatus = .maintenance
        case 3: newStatus = .offline
        default: newStatus = .active
        }

        manager.updateStatus(id: idToUpdate, newStatus: newStatus)

    case 5:
        isRunning = false
        print("\nCerrando sesión de Network Asset Manager. ¡Hasta pronto!")

    default:
        print("❌ Opción no reconocida.")
    }
}