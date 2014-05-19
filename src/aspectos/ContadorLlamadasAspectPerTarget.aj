package aspectos;

import java.util.HashMap;

import annotations.Monitored;

public aspect ContadorLlamadasAspectPerTarget pertarget(execution(@Monitored * clases..*())){

	private HashMap<String, Integer> map = new HashMap<String, Integer>();

	pointcut metodosMonitoreados():
		call (@Monitored * clases.*.*(..) );

	after() returning: metodosMonitoreados(){
		String metodo = thisJoinPoint.getSignature().getName();

		if (this.map.containsKey(metodo)) {
			this.actualizarSiExiste(metodo);
		} else {
			this.agregarSiNoExiste(metodo);
		}
	}

	// /////////////////////////////////////////////////////////
	// METODOS //
	// ///////////////////////////////////////////////////////

	public void agregarSiNoExiste(String metodo) {
		this.map.put(metodo, 1);
	}

	public void actualizarSiExiste(String metodo) {
		if (map.containsKey(metodo)) {
			Integer cantLlamadas = map.get(metodo);
			cantLlamadas += 1;
			map.put(metodo, cantLlamadas);
		} else {
			map.put(metodo, 1);
		}
	}

	public int cantLlamadas(String metodo) {
		if (this.map.containsKey(metodo)) {
			Integer cantLlamadas = this.map.get(metodo);
			return cantLlamadas;
		}
		return 0;
	}

}