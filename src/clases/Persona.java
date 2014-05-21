package clases;

import annotations.Monitored;

@Monitored
public class Persona {

	private String nombre;

    @Monitored
	public String getNombre() {
		return nombre;
	}
	@Monitored
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
}
