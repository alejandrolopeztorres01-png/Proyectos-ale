import java.util.ArrayList;

public class GestorIncidencias {
    // Lista para guardar las incidencias
    private ArrayList<Incidencia> listaIncidencias;
    private int contadorId;

    // Constructor
    public GestorIncidencias() {
        this.listaIncidencias = new ArrayList<>();
        this.contadorId = 1; // Para generar IDs automáticos (ej: INC-001)
    }

    // Método para crear y guardar una incidencia
    public void crear(String usuario, String equipo, String problema, int opcionPrioridad) {
        String idGenerado = "INC-00" + contadorId;
        contadorId++;

        String prioridadStr = "";
        if (opcionPrioridad == 1) {
            prioridadStr = "BAJA";
        } else if (opcionPrioridad == 2) {
            prioridadStr = "MEDIA";
        } else {
            prioridadStr = "ALTA";
        }

        Incidencia nuevaIncidencia = new Incidencia(idGenerado, usuario, equipo, problema, prioridadStr);
        listaIncidencias.add(nuevaIncidencia);
        
        System.out.println("\n✅ Incidencia creada correctamente. ID: " + idGenerado);
    }

    // Método para listar todas las incidencias
    public void listar() {
        if (listaIncidencias.isEmpty()) {
            System.out.println("\nNo hay incidencias registradas.");
            return;
        }

        System.out.println("\n--- LISTA DE INCIDENCIAS ---");
        for (int i = 0; i < listaIncidencias.size(); i++) {
            System.out.println(listaIncidencias.get(i).toString());
        }
    }

    // Método para buscar una incidencia por su ID
    public Incidencia buscar(String idBuscado) {
        for (Incidencia inc : listaIncidencias) {
            if (inc.getId().equalsIgnoreCase(idBuscado)) {
                return inc; // Se encontró
            }
        }
        return null; // No se encontró
    }

    // Método para cambiar el estado
    public void modificarEstado(String id, String nuevoEstado) {
        Incidencia inc = buscar(id);
        if (inc != null) {
            inc.setEstado(nuevoEstado);
            System.out.println("\n✅ Estado actualizado correctamente a: " + nuevoEstado);
        } else {
            System.out.println("\n❌ No se ha encontrado ninguna incidencia con el ID: " + id);
        }
    }

    // Método para eliminar
    public void eliminar(String id) {
        Incidencia inc = buscar(id);
        if (inc != null) {
            listaIncidencias.remove(inc);
            System.out.println("\n🗑️ Incidencia " + id + " eliminada del sistema.");
        } else {
            System.out.println("\n❌ No se ha encontrado la incidencia.");
        }
    }
}