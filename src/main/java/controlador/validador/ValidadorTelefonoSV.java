package controlador.validador;

import javax.faces.application.FacesMessage;
import javax.faces.component.UIComponent;
import javax.faces.context.FacesContext;
import javax.faces.validator.FacesValidator;
import javax.faces.validator.Validator;
import javax.faces.validator.ValidatorException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Validador para números telefónicos de El Salvador
 */
@FacesValidator("validadorTelefonoSV")
public class ValidadorTelefonoSV implements Validator {
    
    private static final String PATRON_TELEFONO_SV = "^[2367]\\d{3}-\\d{4}$";
    private Pattern patron;
    
    public ValidadorTelefonoSV() {
        patron = Pattern.compile(PATRON_TELEFONO_SV);
    }
    
    @Override
    public void validate(FacesContext context, UIComponent component, Object value) throws ValidatorException {
        if (value == null) {
            return;
        }
        
        String telefono = value.toString();
        Matcher matcher = patron.matcher(telefono);
        
        if (!matcher.matches()) {
            FacesMessage msg = new FacesMessage(
                "Formato de teléfono inválido", 
                "El número debe comenzar con 2, 3, 6 o 7, seguido de 3 dígitos, un guion y 4 dígitos más (####-####)");
            msg.setSeverity(FacesMessage.SEVERITY_ERROR);
            throw new ValidatorException(msg);
        }
    }
}

