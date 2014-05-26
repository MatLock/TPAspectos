package aspectos;

import java.util.HashMap;
import java.util.Map;

import annotations.Monitored;

public aspect ContadorLlamadasAspect{

	private Map<Object,Map<String,Integer>> map = new HashMap<Object, Map<String,Integer>>();
	
	pointcut metodosMonitoreados():
		call (@Monitored * clases.*.*(..) );
	
	
	
	public void actualizarSiExiste(Object target,String metodo){
		Map<String,Integer> dict = this.map.get(target);
		if (dict.containsKey(metodo)) {
			Integer valor = dict.get(metodo);
			valor += 1;
			dict.put(metodo, valor);
		}else{
			dict.put(metodo, 1);
		}
	}
	
	public void agregarSiNoExiste(Object target) {
		this.map.put(target,new HashMap<String, Integer>());
	}
	
	public int cantLlamadas(Object target,String metodo){
		if(this.map.containsKey(target) && this.map.get(target).containsKey(metodo)){
			Integer valor = this.map.get(target).get(metodo);
			return valor;
		}
		return 0;
	}
	
	
	after() : metodosMonitoreados(){
		Object target = thisJoinPoint.getTarget();
		String metodo = thisJoinPoint.getSignature().getName();
		if (!this.map.containsKey(target)) {
			this.agregarSiNoExiste(target);
		}
		this.actualizarSiExiste(target, metodo);
	}
}
