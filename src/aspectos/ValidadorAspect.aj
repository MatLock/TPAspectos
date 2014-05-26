package aspectos;

import java.util.HashMap;
import java.util.Map;

import Interfaces.ValidadorInterface;
import clases.NoopValidator;
import exceptions.ValorInvalidoException;

public aspect ValidadorAspect {
	
	private Map<Object, Map<String,ValidadorInterface>> map=
			new HashMap<Object, Map<String,ValidadorInterface>>();

	
	/* le pego a todas las variables de instancia de tipo String.
	 * este pointcut habla de cada vez que se setea una variable del tipo mencionado antes
	 */
	pointcut settersString():
		set (* clases..*);
	
	
	public ValidadorInterface obtenerValidador(Object target, String metodo){
		if (existeObject(target) && this.map.get(target).containsKey(metodo)) {	
			return this.map.get(target).get(metodo);
		}
		return new NoopValidator();
	}
	
	
	void around () throws ValorInvalidoException :settersString(){
		Object target = thisJoinPoint.getTarget();
		String variableNombre = thisJoinPoint.getSignature().getName(); // como es un set,le pido el nombre a la variable de instacia.
		Object value = thisJoinPoint.getArgs()[0];    // si fuera un call me estaria dando el nombre del metodo.
		                                                       // el get args me da los argumentos con el cual se va a setear la variable
		ValidadorInterface validador = this.obtenerValidador(target,variableNombre);
		if (validador.validar(value)) {
			proceed();
		} else {
			throw new ValorInvalidoException("Error del validador:  " + validador.toString());
		}
	}
	
	public boolean existeObject(Object p1){
		return this.map.containsKey(p1);
	}
	
	public void agregarConValidador(Object p1, String instVar, ValidadorInterface validador){
		this.map.get(p1).put(instVar, validador);
	}
	
	public void agregarValidador(Object p1, String instVar, ValidadorInterface validador) {
		if (!this.existeObject(p1)) {
			this.map.put(p1, new HashMap<String,ValidadorInterface>());
		}
		this.agregarConValidador(p1,instVar, validador);
	}
}
