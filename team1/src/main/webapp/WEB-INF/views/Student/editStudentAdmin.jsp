<%@ page 
        language="java" 
        contentType="text/html; charset=UTF-8"
        pageEncoding="UTF-8"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<link href="/resources/css/studentTable.css" rel="stylesheet">

<%@ include file="../header.jsp" %>
<%@ include file="../chat.jsp" %>
<script src="/resources/js/studentEdit.js"></script>


<div class="table">
    <form id="Form" method="POST" action="/Student/editStudentAdmin?target_id=${detail.id}">
        <table id="register" class="boardtable">

            <tr>
                <th><label for="id">학생아이디<span class="required">*</span></label></th>
                <td><input id="id" type="email" name="id" required value="${detail.id}">
                    <button type="button" id="checkbtn">중복확인</button>
                    <div id="checkMsg"></div>
                </td>
            </tr>
            <th><label for="name">이름<span class="required">*</span></label></th>
            <td><input id="name" type="text" name="name" required value="${detail.name}"></td>
            </tr>
            <tr>
                <th><label for="birthday">생년월일<span class="required">*</span></label></th>
                <td><input id="birthday" type="text" name="birthday" required maxlength="6" value="${detail.birthday}"
                        oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"></td>
            </tr>


            <tr>
                <th><label for="course_code">훈련과정<span class="required">*</span></label></th>
                <td><select name="course_code" id="course_code" required>
                        <option value="0">훈련과정 선택 </option>

<%-- 
                        <c:forEach var="courseDTO" items="${courseList}">
                            <option 
                            <c:if test="${courseDTO.code == detail.course_code}">selected="selected"</c:if> 
                            <c:out value="${courseDTO.name}" />>
                                
                             </option>
                        </c:forEach> --%>

						
						<c:forEach items="${courseList}" var="courseDTO">
							<p><c:out value="${courseDTO.code}"></c:out></p>
						  <option value="${courseDTO.code}" ${courseDTO.code == detail.course_code ? 'selected="selected"' : '' }>${courseDTO.name}</option>
						</c:forEach>



                    </select></td>

            </tr>
            <%-- <tr>
						<th>그룹아이디</th>
						<td><select name="groups_id" id="groups_id">
								<option value="1" <c:if test="${groups_id == 1}">selected</c:if>>1조</option>
								<option value="2" <c:if test="${groups_id == 2}">selected</c:if>>2조</option>
						</select></td>
					</tr> --%>
            <tr>

                <th>훈련상태</th>
                <td><select name="state" id="state">
                        <option value="훈련중" <c:if test="${state == 'now'}">selected</c:if>>훈련중</option>
                        <option value="훈련종료" <c:if test="${state == 'end'}">selected</c:if>>훈련종료</option>
                        <option value="중도하차" <c:if test="${state == 'drop'}">selected</c:if>>중도하차</option>
                    </select></td>
            </tr>
<!--             <tr>
                <th>출석일수</th>
                <td>50
                </td>
            </tr>
            <tr>
                <th>결석일수</th>
                <td>0
                </td>
            </tr>
            <tr>
                <th>시험점수</th>
                <td>
                    100
                </td>
            </tr> -->
            <tr>
                <th><label for="mobile_phone">핸드폰번호<span class="required">*</span></label></th>
                <td><input id="mobile_phone" type="tel" name="mobile_phone" maxlength="11"
                        oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"
                        value="${detail.mobile_phone}" required></td>
            </tr>
            <tr>
                <th><label for="temporarily_number">비상연락처</label></th>
                <td><input type="tel" id="temporarily_number" name="temporarily_number"
                        value="${detail.temporarily_number}"></td>
            </tr>

            <tr>
                <th><label for="address">기본주소<span class="required">*</span></label></th>
                <td><input id="address" name="address" class="address" type="text" 
                        value="${detail.address}" required></td>
            </tr>
            <tr>
                <th><label for="detail_address">상세주소</label></th>
                <td><input name="detail_address" id="detail_address" class="address" type="text"
                        value="${detail.detail_address}"></td>
            </tr>

        </table>
        <table id="register_button">
            <div class="button">
                <input type="submit" value="등록">
                <input type="button" class="back" value="취소" onclick="history.back(-1)">
            </div>
        </table>

    </form>
</div>

<%@ include file="../footer.jsp" %>