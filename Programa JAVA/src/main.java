import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        GestorIncidencias gestor = new GestorIncidencias();
        boolean salir = false;

        System.out.println("================================");
        System.out.println("    GESTOR DE INCIDENCIAS IT    ");
        System.out.println("================================");

        // Bucle while para mantener el programa abierto
        while (!salir) {
            System.out.println("\n1. Crear incidencia");
            System.out.println("2. Ver incidencias");
            System.out.println("3. Buscar incidencia");
            System.out.println("4. Cambiar estado");
            System.out.println("5. Eliminar incidencia");
            System.out.println("6. Salir");
            System.out.print("\nSelecciona una opción: ");
            
            int opcion = scanner.nextInt();
            scanner.nextLine(); // Limpiar el buffer del scanner (Típico truco Junior)

            // Switch para el menú
            switch (opcion) {
                case 1:
                    System.out.println("\n--- NUEVA INCIDENCIA ---");
                    System.out.print("Nombre del usuario: ");
                    String usuario = scanner.nextLine();
                    
                    System.out.print("Equipo (Ej. PC-023): ");
                    String equipo = scanner.nextLine();
                    
                    System.out.print("Problema: ");
                    String problema = scanner.nextLine();
                    
                    System.out.println("Prioridad:\n 1. Baja\n 2. Media\n 3. Alta");
                    System.out.print("Selecciona (1-3): ");
                    int prioridad = scanner.nextInt();
                    scanner.nextLine(); // Limpiar buffer
                    
                    gestor.crear(usuario, equipo, problema, prioridad);
                    break;
                    
                case 2:
                    gestor.listar();
                    break;
                    
                case 3:
                    System.out.print("\nIntroduce el ID de la incidencia (Ej. INC-001): ");
                    String idBusqueda = scanner.nextLine();
                    Incidencia encontrada = gestor.buscar(idBusqueda);
                    
                    if (encontrada != null) {
                        System.out.println("\nIncidencia encontrada:");
                        System.out.println(encontrada.toString());
                    } else {
                        System.out.println("\n❌ No se encontró la incidencia.");
                    }
                    break;
                    
                case 4:
                    System.out.print("\nIntroduce el ID de la incidencia a modificar: ");
                    String idMod = scanner.nextLine();
                    
                    System.out.println("Nuevo estado:\n 1. EN PROCESO\n 2. RESUELTA");
                    System.out.print("Selecciona (1-2): ");
                    int opcEstado = scanner.nextInt();
                    scanner.nextLine();
                    
                    String nuevoEstado = (opcEstado == 1) ? "EN PROCESO" : "RESUELTA";
                    gestor.modificarEstado(idMod, nuevoEstado);
                    break;
                    
                case 5:
                    System.out.print("\nIntroduce el ID de la incidencia a eliminar: ");
                    String idEliminar = scanner.nextLine();
                    gestor.eliminar(idEliminar);
                    break;
                    
                case 6:
                    salir = true;
                    System.out.println("\nSaliendo del Gestor de Incidencias... ¡Hasta luego!");
                    break;
                    
                default:
                    System.out.println("\n❌ Opción no válida. Intenta de nuevo.");
            }
        }
        
        scanner.close();
    }
}