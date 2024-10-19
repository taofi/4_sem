package TagManager;

import database.ConnectionFactory;
import jakarta.servlet.jsp.JspException;
import jakarta.servlet.jsp.JspWriter;
import jakarta.servlet.jsp.tagext.TagSupport;
import java.io.IOException;
import java.sql.*;

@SuppressWarnings("serial")
public class VKSprintTable extends TagSupport {
    private String nameTable;
    public void setNameTable(String nameTable)
    {
        this.nameTable = nameTable;
    }
    @Override
    public int doStartTag() throws JspException
    {
        JspWriter out = pageContext.getOut();

        if(nameTable == null || nameTable.isEmpty()) {
            try {
                out.println("Значение атрибута для тега = NULL/EMPTY");
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }
        else {
            try {
                Connection connection = ConnectionFactory.getConnection();
                Statement statement = connection.createStatement();
                String query = "select * from " + nameTable;

                StringBuilder table = new StringBuilder("<table>\n<tr>");

                try (ResultSet resultSet = statement.executeQuery(query)) {
                    ResultSetMetaData metaData = resultSet.getMetaData();
                    int columnCount = metaData.getColumnCount();
                    for (int i = 1; i <= columnCount; i++) {
                        table.append("<th>").append(metaData.getColumnName(i)).append("</th>\n");
                    }

                    table.append("</tr>\n");

                    while (resultSet.next()) {
                        table.append("<tr>\n");

                        for (int i = 0; i < columnCount; i++) {
                            Object value = resultSet.getObject(i + 1);
                            String strValue = value.toString();
                            table.append("<td>").append(strValue).append("</td>");
                        }

                        table.append("</tr>\n");
                    }

                    resultSet.close();
                    statement.close();
                    connection.close();

                    try {
                        out.println(table + "</table>\n");
                    } catch (IOException e) {
                        throw new RuntimeException(e);
                    }
                }

            }
            catch (Exception e) {
                try {
                    out.println("Failed to connect to database " + e.getMessage());
                } catch (IOException ex) {
                    throw new RuntimeException(ex);
                }
            }
        }

        return SKIP_BODY;
    }
}
