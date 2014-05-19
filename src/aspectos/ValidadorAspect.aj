package aspectos;

import java.util.HashMap;


import clases.ValidarStringNoVacio;
import exceptions.ValorInvalidoException;

public aspect ValidadorAspect {
	
	private HashMap<Object,HashMap<String,ValidarStringNoVacio>> map=
			new HashMap<Object, HashMap<String,ValidarStringNoVacio>>();

	
	/* le pego a todas las variables de instancia de tipo String.
	 * este pointcut habla de cada vez que se setea una variable del tipo mencionado antes
	 */
	pointcut settersString():
		set (String clases..*);
	
	
	public ValidarStringNoVacio obtenerValidador(Object target, String metodo){
		if(this.map.containsKey(target)){	
			if (this.map.get(target).containsKey(metodo)){
			return this.map.get(target).get(metodo);
			}	
		}return new ValidarStringNoVacio();
	}
	
	
	void around () throws ValorInvalidoException :settersString(){
		Object target = thisJoinPoint.getTarget();
		String variableNombre = thisJoinPoint.getSignature().getName(); // como es un set,le pido el nombre a la variable de instacia.
		String value = (String) thisJoinPoint.getArgs()[0];    // si fuera un call me estaria dando el nombre del metodo.
		                                                       // el get args me da los argumentos con el cual se va a setear la variable
		ValidarStringNoVacio validador = this.obtenerValidador(target,variableNombre);
		if (validador.validar(value)){
			proceed();
		}else{
			throw new ValorInvalidoException("Error del validador:  " + validador.toString());
		}
	}
	
	public boolean existeObject(Object p1){
		return this.map.containsKey(p1);
	}
	
	public void agregarConValidador(Object p1, String instVar,ValidarStringNoVacio validador){
		this.map.get(p1).put(instVar, validador);
	}
	
	public void agregarPorPrimeraVez(Object p1, String instVar, ValidarStringNoVacio validador){
		HashMap<String,ValidarStringNoVacio> newMap = new HashMap<String,ValidarStringNoVacio>();
		newMap.put(instVar,validador);
		this.map.put(p1, newMap);
	}
	
	public void agregarValidador(Object p1, String instVar,
			ValidarStringNoVacio validador) {
		if ( this.existeObject(p1)){
			this.agregarConValidador(p1,instVar, validador);
		}else{
			this.agregarPorPrimeraVez(p1,instVar,validador);
		}
		
	}
}
