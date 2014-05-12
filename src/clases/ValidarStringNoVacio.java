package clases;

import Interfaces.ValidadorInterface;

public class ValidarStringNoVacio implements ValidadorInterface<String> {

	@Override
	public boolean validar(String value) {
		 return value.length() > 0;
	} 

}
