<%@ include file="/WEB-INF/jsp/include.jsp" %>
<c:set var="portletNamespace" scope="request"><portlet:namespace/></c:set>
<c:set var="hasErrors" scope="request" value="${errors.errorCount == 0}"/>

<div id="bookmarksPortlet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bookmarks.css" type="text/css"/>
    <script src="${pageContext.request.contextPath}/script/bookmarks.js" type="text/javascript"></script>
    <script type="text/javascript">
        new BookmarksPortletData(   "${portletNamespace}",      //namespace
                                    "newWindow",                //bookmark_form_newWindow
                                    "url",                      //bookmark_form_url
                                    "emptyBookmarkForm",        //bookmark_forms_empty
                                    "errorBookmarkForm",        //bookmark_forms_error
                                    "url_",                     //bookmark_reference_url
                                    "bookmarksTreeAndForm",     //bookmarksTreeAndForm
                                    "bookmarksChildFolder_",    //entry_childFolderPrefix
                                    "entryEditButtons",         //entry_edit_buttons
                                    "cancelLink",               //entry_edit_cancelLink
                                    "editLink",                 //entry_edit_editLin
                                    "editBookmark",             //entry_form_action_editBookmar
                                    "editFolder",               //entry_form_action_editFolder
                                    "newBookmark",              //entry_form_action_newBookmark
                                    "newFolder",                //entry_form_action_newFolder
                                    "folderPath",               //entry_form_folderPath
                                    "folderActionLabel",        //entry_form_folderPathLabel
                                    "name",                     //entry_form_nam
                                    "note",                     //entry_form_note
                                    "entryImg_",                //entry_imagePrefix
                                    "referenceFolderPath",      //entry_reference_folderPath
                                    "name_",                    //entry_reference_nam
                                    "note_",                    //entry_reference_note
                                    "emptyFolderForm",          //folder_forms_empty
                                    "errorFolderForm",          //folder_forms_error
                                    "/img/folder-closed.gif",   //folder_image_closed
                                    "/img/folder-opened.gif",   //folder_image_open
                                    "emptyOptionsForm",         //options_forms_empty
                                    "errorOptionsForm",         //options_forms_error
                                    "optionsLink",              //options_showLink
                                    "<spring:message code="portlet.script.folder.create" javaScriptEscape="true"/>",                    //messages_folder_create
                                    "<spring:message code="portlet.script.folder.move" javaScriptEscape="true"/>",                      //messages_folder_move
                                    "<spring:message code="portlet.script.delete.confirm.bookmark.prefix" javaScriptEscape="true"/>",   //messages_delete_bookmark_prefix
                                    "<spring:message code="portlet.script.delete.confirm.bookmark.suffix" javaScriptEscape="true"/>",   //messages_delete_bookmark_suffix
                                    "<spring:message code="portlet.script.delete.confirm.folder.prefix" javaScriptEscape="true"/>",     //messages_delete_folder_prefix
                                    "<spring:message code="portlet.script.delete.confirm.folder.suffix" javaScriptEscape="true"/>");    //messages_delete_folder_suffix
    </script>


    <div style="float: right;">
        <c:if test="${hasErrors}">
            <c:set var="optionsLinkClass" value="hidden" scope="page"/>
        </c:if>
        <a id="${portletNamespace}optionsLink" href="#" class="${optionsLinkClass}" onclick="showOptionsForm('${portletNamespace}');return false;"><spring:message code="portlet.view.options"/></a>
    </div>
    
    <c:if test="${hasErrors && !empty optionsCommand}">
        <bm:optionsForm formName="errorOptionsForm" commandName="optionsCommand" hidden="false" namespace="${portletNamespace}"/>
    </c:if>
    <bm:optionsForm formName="emptyOptionsForm" commandName="emptyOptionsCommand" hidden="true" namespace="${portletNamespace}"/>
    

    <div id="${portletNamespace}bookmarksTreeAndForm">
        <c:set var="bookmarkEntries" value="${bookmarkSet.sortedChildren}" scope="page"/>
        <c:choose>
            <c:when test="${fn:length(bookmarkEntries) > 0}">
                <bm:treeFolder treeName="bookmarks" folderIdSuffix="RootEntry" entries="${bookmarkEntries}" parentIdPath="${bookmarkSet.id}" namespace="${portletNamespace}" cssClass="bookmarkList"/>
                <br/>
            </c:when>
            <c:otherwise>
                <div class="portlet-font">
                    <spring:message code="portlet.view.noBookmarks"/>
                </div>
            </c:otherwise>
        </c:choose>
        
        <a href="#" onclick="newBookmark('${portletNamespace}');return false;" class="jsTextLink portlet-form-label"><spring:message code="portlet.view.addBookmark"/></a>
        &nbsp;&nbsp;&nbsp;
        <a href="#" onclick="newFolder('${portletNamespace}');return false;" class="jsTextLink portlet-form-label"><spring:message code="portlet.view.addFolder"/></a>
        <c:if test="${fn:length(bookmarkEntries) > 0}">
            &nbsp;&nbsp;&nbsp;    
            <a href="#" id="${portletNamespace}editLink" onclick="toggleEditMode('${portletNamespace}', true);return false;" class="jsTextLink portlet-form-label"><spring:message code="portlet.view.edit.show"/></a>
            <a href="#" id="${portletNamespace}cancelLink" onclick="toggleEditMode('${portletNamespace}', false);return false;" class="jsTextLink portlet-form-label hidden"><spring:message code="portlet.view.edit.hide"/></a>
        </c:if> 
        
        <c:if test="${hasErrors && !empty bookmarkCommand}">
            <bm:bookmarkForm formName="errorBookmarkForm" commandName="bookmarkCommand" entries="${bookmarkEntries}" hidden="false" namespace="${portletNamespace}"/>
        </c:if>
        <bm:bookmarkForm formName="emptyBookmarkForm" commandName="emptyBookmarkCommand" entries="${bookmarkEntries}" hidden="true" namespace="${portletNamespace}"/> 
        
        <c:if test="${hasErrors && !empty folderCommand}">
            <bm:folderForm formName="errorFolderForm" commandName="folderCommand" entries="${bookmarkEntries}" hidden="false" namespace="${portletNamespace}"/>
        </c:if>
        <bm:folderForm formName="emptyFolderForm" commandName="emptyFolderCommand" entries="${bookmarkEntries}" hidden="true" namespace="${portletNamespace}"/>
    </div>
</div>