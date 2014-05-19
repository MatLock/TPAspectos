package test;

import static org.junit.Assert.*;

import org.junit.Test;

import aspectos.ValidadorAspect;
import clases.Persona;
import clases.ValidarStringNoVacio;
import exceptions.ValorInvalidoException;

public class NombreNoVacioTest {
	
	
	@Test
    public void noDebePermitirNombresVacios () {
        Persona p1 = new Persona();
        ValidadorAspect.aspectOf().agregarValidador(p1, "nombre", new ValidarStringNoVacio()); 
        p1.setNombre("Nico");
        assertEquals("Nico", p1.getNombre()); // Se asigna el nombre correctamente
        try {
            p1.setNombre("");
            fail("Debera haber tirado excepcion al asignarle un nombre vacio");
        }
        catch (ValorInvalidoException e) {
            assertEquals("Nico", p1.getNombre()); // El nombre no cambio
        }
    }
}
