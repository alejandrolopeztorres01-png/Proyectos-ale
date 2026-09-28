public class Incidencia {
    // Atributos privados (Encapsulación)
    private String id;
    private String usuario;
    private String equipo;
    private String problema;
    private String prioridad;
    private String estado;

    // Constructor
    public Incidencia(String id, String usuario, String equipo, String problema, String prioridad) {
        this.id = id;
        this.usuario = usuario;
        this.equipo = equipo;
        this.problema = problema;
        this.prioridad = prioridad;
        this.estado = "PENDIENTE"; // Por defecto, al crearla está pendiente
    }

    // Getters y Setters
    public String getId() {
        return id;
    }

    public String getUsuario() {
        return usuario;
    }

    public String getEquipo() {
        return equipo;
    }

    public String getProblema() {
        return problema;
    }

    public String getPrioridad() {
        return prioridad;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    // Método para imprimir la incidencia de forma bonita
    @Override
    public String toString() {
        return id + " | " + usuario + " | " + equipo + " | " + prioridad + " | " + estado + " | Problema: " + problema;
    }
}