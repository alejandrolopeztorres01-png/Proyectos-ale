import Foundation

// Uso una clase para el gestor, ya que mantendrá un único estado compartido en memoria
class DeviceManager {
    // Array privado para almacenar los equipos (encapsulación)
    private var devices: [Device] = []
    private var counter: Int = 1

    init() {
        // Cargo algunos datos de prueba para que el reclutador vea registros nada más probarlo
        loadSeedData()
    }

    // Datos iniciales de demostración
    private func loadSeedData() {
        devices.append(Device(id: "NET-001", name: "Cisco-Core-2960", ipAddress: "192.168.1.1", type: .switchDevice, status: .active, notes: "Switch central de distribución"))
        devices.append(Device(id: "NET-002", name: "Edge-Router-01", ipAddress: "192.168.1.254", type: .router, status: .active, notes: "Salida WAN primaria"))
        devices.append(Device(id: "SRV-001", name: "Active-Directory-VM", ipAddress: "192.168.1.10", type: .server, status: .maintenance, notes: "Parcheando sistema"))
        counter = 3
    }

    // Registrar un nuevo equipo
    func addDevice(name: String, ip: String, type: DeviceType, notes: String?) {
        let generatedId = String(format: "DEV-%03d", counter)
        counter += 1

        let newDevice = Device(
            id: generatedId,
            name: name,
            ipAddress: ip,
            type: type,
            status: .active,
            notes: notes
        )
        devices.append(newDevice)
        print("\n✅ Dispositivo registrado: \(name) con ID: \(generatedId)")
    }

    // Listado general
    func listAll() {
        if devices.isEmpty {
            print("\n⚠️ No hay equipos registrados en el inventario.")
            return
        }
        print("\n================== INVENTARIO DE RED ==================")
        for dev in devices {
            print(dev.details())
        }
        print("=======================================================")
    }

    // Filtro por categoría utilizando funciones de orden superior de Swift (.filter)
    func filterByType(type: DeviceType) {
        let results = devices.filter { $0.type == type }
        
        if results.isEmpty {
            print("\n⚠️ No se encontraron equipos de tipo: \(type.rawValue)")
            return
        }

        print("\n--- Dispositivos encontrados: \(type.rawValue) ---")
        for dev in results {
            print(dev.details())
        }
    }

    // Modificar el estado operativo buscando por ID
    func updateStatus(id: String, newStatus: DeviceStatus) {
        // Buscamos el índice del elemento en el array
        if let index = devices.firstIndex(where: { $0.id.uppercased() == id.uppercased() }) {
            devices[index].status = newStatus
            print("\n✅ Estado de \(id) actualizado a: \(newStatus.rawValue)")
        } else {
            print("\n❌ No se localizó ningún dispositivo con ID: \(id)")
        }
    }
}