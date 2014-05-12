package clases;

import annotations.Monitored;


public class Persona {

	private String nombre;


	
	public Persona(String nombre) {
		super();
		this.nombre = nombre;
	}

    @Monitored
	public String getNombre() {
		return nombre;
	}
	@Monitored
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	
	public static void main(String[] args) {
		Persona persona = new Persona("Fede");
		persona.getNombre();
		persona.getNombre();
		persona.setNombre("abc");
	}
	
	
}
