package aspectos;

import java.util.HashMap;

import annotations.Monitored;

public aspect ContadorLlamadasAspect{

	private HashMap<Object,HashMap<String,Integer>> map = new HashMap<Object, HashMap<String,Integer>>();
	
	pointcut metodosMonitoreados():
		call (@Monitored * clases.*.*(..) );
	
	
	
	public void actualizarSiExiste(Object target,String metodo){
		HashMap<String,Integer>dict = this.map.get(target);
		if(dict.containsKey(metodo)){
		Integer valor = dict.get(metodo);
		valor += 1;
		dict.put(metodo, valor);
		}else{
			dict.put(metodo, 1);
		}
	}
	
	public void agregarSiNoExiste(Object target,String metodo){
		HashMap<String, Integer> nuevoMap = new HashMap<String, Integer>();
		nuevoMap.put(metodo, 1);
		this.map.put(target,nuevoMap);
	}
	
	public int cantLlamadas(Object target,String metodo){
		if(this.map.containsKey(target) && this.map.get(target).containsKey(metodo)){
			Integer valor = this.map.get(target).get(metodo);
			return valor;
		}
		return 0;
	}
	
	
	after() returning: metodosMonitoreados(){
		Object target = thisJoinPoint.getTarget();
		String metodo = thisJoinPoint.getSignature().getName();
		
		if (this.map.containsKey(target)){
			this.actualizarSiExiste(target, metodo);
		}else{
			this.agregarSiNoExiste(target, metodo);
		}
	}
}
