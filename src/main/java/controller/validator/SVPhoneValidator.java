package controller.validator;

import javax.faces.application.FacesMessage;
import javax.faces.component.UIComponent;
import javax.faces.context.FacesContext;
import javax.faces.validator.FacesValidator;
import javax.faces.validator.Validator;
import javax.faces.validator.ValidatorException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Validator for El Salvador phone numbers
 */
@FacesValidator("svPhoneValidator")
public class SVPhoneValidator implements Validator {
    
    private static final String SV_PHONE_PATTERN = "^[2367]\\d{3}-\\d{4}$";
    private Pattern pattern;
    
    public SVPhoneValidator() {
        pattern = Pattern.compile(SV_PHONE_PATTERN);
    }
    
    @Override
    public void validate(FacesContext context, UIComponent component, Object value) throws ValidatorException {
        if (value == null) {
            return;
        }
        
        String phone = value.toString();
        Matcher matcher = pattern.matcher(phone);
        
        if (!matcher.matches()) {
            FacesMessage msg = new FacesMessage(
                "Formato de teléfono inválido", 
                "El número debe comenzar con 2, 3, 6 o 7, seguido de 3 dígitos, un guion y 4 dígitos más (####-####)");
            msg.setSeverity(FacesMessage.SEVERITY_ERROR);
            throw new ValidatorException(msg);
        }
    }
}

