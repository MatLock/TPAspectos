package aspectos;

import java.util.HashMap;

import clases.Persona;
import clases.ValidarStringNoVacio;

public aspect ValidadorAspect {
	
	private HashMap<Object,HashMap<String,ValidarStringNoVacio>> map=
			new HashMap<Object, HashMap<String,ValidarStringNoVacio>>();

	pointcut settersString(Object target, String value):
		set (* clases..*) && args(value) && target(target);
	
	
	after (Object target, String value) returning: settersString(target,value){
	}

	
	
	public void agregarValidador(Object p1, String string,
			ValidarStringNoVacio validarStringNoVacio) {
		// TODO Auto-generated method stub
		
	}
}
