package TagManager;

import jakarta.servlet.jsp.JspWriter;
import jakarta.servlet.jsp.tagext.TagSupport;
import jakarta.servlet.jsp.JspException;

import java.io.IOException;

@SuppressWarnings("serial")
public class VKSsubmit extends TagSupport {
    @Override
    public int doStartTag() throws JspException
    {
        JspWriter out = pageContext.getOut();
        try {
            out.println("<input type=\"submit\" required value=\"Вход\" name=\"input\">\n" +
                    " <input type=\"submit\" required value=\"Регистрация\" name=\"registration\">");
        } catch (IOException e) {
            throw new RuntimeException(e);
        }

        return SKIP_BODY;
    }
}
