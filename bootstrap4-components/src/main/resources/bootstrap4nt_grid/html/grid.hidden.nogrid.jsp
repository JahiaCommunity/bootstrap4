<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib"%>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>


<c:set var="createAbsoluteAreas" value="${jcr:isNodeType(currentNode, 'bootstrap4mix:createAbsoluteAreas')}" />
<c:set var="moduleType" value="${createAbsoluteAreas? 'absoluteArea' : 'area'}" />
<c:set var="level" value="${createAbsoluteAreas? currentNode.properties.level.string : '0'}" />
<c:if test="${createAbsoluteAreas && renderContext.editModeConfigName eq 'studiomode'}">
    <c:set var="displayAbsoluteArea">
        <div class="card text-white bg-danger mb-3">
            <div class="card-header">
                <fmt:message key="bootstrap4nt_grid.absolute.area.title"/>
            </div>
            <div class="card-body">
                <p class="card-text">
                <fmt:message key="bootstrap4nt_grid.absolute.area.desc">
                    <fmt:param value="${level}"/>
                </fmt:message>
                </p>
            </div>
        </div>
    </c:set>
</c:if>
<c:if test="${renderContext.editMode}">
    <c:set var="createContainer" value="${jcr:isNodeType(currentNode,'bootstrap4mix:createContainer')}"/>
    <c:set var="createRow" value="${jcr:isNodeType(currentNode,'bootstrap4mix:createRow')}"/>
    <c:if test="${! createContainer && ! createRow}">
        <c:if test="${! fn:startsWith(currentNode.path,'/modules') || renderContext.editModeConfigName eq 'studiomode'}">
            <span class="text-muted">#${currentNode.name}</span>
        </c:if>
    </c:if>
</c:if>
<c:choose>
    <c:when test="${fn:startsWith(currentNode.path,'/modules') || renderContext.editModeConfigName eq 'studiomode'}">
        <c:set var="colName" value="${currentNode.name}"/>
    </c:when>
    <c:otherwise>
        <c:set var="colName" value="main"/>
    </c:otherwise>
</c:choose>

${displayAbsoluteArea}<template:area path="${colName}" areaAsSubNode="true" moduleType="${moduleType}" level="${level}"/>
