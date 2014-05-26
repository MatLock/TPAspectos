package clases;

import Interfaces.ValidadorInterface;

/**
 * @author publico
 */
public class NoopValidator<T> implements ValidadorInterface<T> {
	public static final NoopValidator SHARED_INSTANCE = new NoopValidator();

	@Override
	public boolean validar(T value) {
		return true;
	}

}
