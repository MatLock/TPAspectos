package test;

import static org.junit.Assert.*;

import org.junit.Test;

import aspectos.ContadorLlamadasAspect;
import clases.Persona;


/** !whitincode (*.bla(..) "saco los metodos que empiecen con bla"**/
public class contadorLlamadastest {

	  	@Test
	    public void sampleTest () {
	        Persona p1 = new Persona(null);
	        p1.getNombre();
	        p1.setNombre(" Nico ");
	        p1.setNombre(" Carlos ");
	        Persona p2 = new Persona(null);
	        int llamadas_p1_getNombre =
	            ContadorLlamadasAspect.aspectOf().cantLlamadas(p1,"getNombre");
	        int llamadas_p1_setNombre =
	            ContadorLlamadasAspect.aspectOf().cantLlamadas(p1,"setNombre");
	        int llamadas_p2_setNombre =
	            ContadorLlamadasAspect.aspectOf().cantLlamadas(p2,"setNombre");
	        assertEquals(llamadas_p1_getNombre , 1) ;
	        assertEquals(llamadas_p1_setNombre , 2) ;
	        assertEquals(llamadas_p2_setNombre , 0) ;
	    }
	  	
	  	/** obtener una variable de instancia desde un aspecto
	  	 * a = thisJointPoint.getSignature()."getter" -- me da la variable de instancia
	  	 * object.getClass().getField(a) -- me da la variable de instancia!!
	  	 * a.getValue(obj) -- me da el valor de la variable!
	  	 */

    }


