package test;
import static org.junit.Assert.*;

import org.junit.Test;

import aspectos.ContadorLlamadasAspectPerTarget;
import clases.Persona;


/** !whitincode (*.bla(..) "saco los metodos que empiecen con bla"**/
public class contadorLlamadasPerTargetTest {

 	@Test
   public void sampleTest () {
       Persona p1 = new Persona();
       p1.getNombre();
       p1.setNombre(" Nico ");
       p1.setNombre(" Carlos ");
       Persona p2 = new Persona();
       int llamadas_p1_getNombre =
       	 ContadorLlamadasAspectPerTarget.aspectOf(p1).cantLlamadas("getNombre");
       int llamadas_p1_setNombre =
       	 ContadorLlamadasAspectPerTarget.aspectOf(p1).cantLlamadas("setNombre");
       int llamadas_p2_setNombre =
       	 ContadorLlamadasAspectPerTarget.aspectOf(p2).cantLlamadas("setNombre");
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