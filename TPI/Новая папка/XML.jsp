<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "x" uri = "http://java.sun.com/jsp/jstl/xml" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>XML</title>
</head>
<body>
<c:set var = "xmltext">
    <books>
        <book>
            <name>Padam History</name>
            <author>ZARA</author>
            <price>100</price>
        </book>

        <book>
            <name>Great Mistry</name>
            <author>NUHA</author>
            <price>2000</price>
        </book>
    </books>
</c:set>

<x:parse xml = "${xmltext}" var = "output"/>
<x:if select = "$output//book">
Document has at least one <book> element.
    </x:if>
    <br />

    <x:if select = "$output/books[1]/book/price > 100">
    Book prices are very high
    </x:if>
</body>
</html>
