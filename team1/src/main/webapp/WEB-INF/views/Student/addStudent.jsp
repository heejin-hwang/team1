<%@ page 
        language="java" 
        contentType="text/html; charset=UTF-8"
        pageEncoding="UTF-8"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<link href="/resources/css/studentTable.css" rel="stylesheet">

<%@ include file="../header.jsp" %>
<%@ include file="../chat.jsp" %>
<script src="/resources/js/studentAdd.js"></script>


<div class="table">
    <form id="Form" method="POST" action="/Student/addStudent">
        <table id="register" class="boardtable">
            <tr>
                <th><label for="id">학생아이디<span class="required">*</span></label></th>
                <td><input id="id" type="email" name="id" required>
                    <button type="button" id="checkbtn">중복확인</button>
                    <div id="checkMsg"></div>
                </td>
            </tr>
            <tr>
                <th><label for="name">이름<span class="required">*</span></label></th>
                <td><input id="name" type="text" name="name" required></td>
            </tr>
            <tr>
                <th><label for="birthday">생년월일<span class="required">*</span></label></th>
                <td><input id="birthday" type="text" name="birthday" maxlength="6" required
                        oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"></td>
            </tr>
            <tr>
                <th><label for="course_code">훈련과정<span class="required">*</span></label></th>
                <td><select name="course_code" id="course_code" required>
                        <option value="0">훈련과정 선택 </option>

                        <c:forEach var="courseDTO" items="${courseList}">

                            <option value="${courseDTO.code}">${courseDTO.name}</option>
                        </c:forEach>
                    </select></td>
            </tr>

            <tr>
                <th><label for="state">훈련상태</label></th>
                <td><select name="state" id="state">
                        <option value="훈련중">훈련중</option>
                        <option value="훈련종료">훈련종료</option>
                        <option value="중도하차">중도하차</option>
                    </select></td>
            </tr>
<!--             <tr>
                <th>출석일수</th>
                <td></td>
            </tr>
            <tr>
                <th>결석일수</th>
                <td></td>
            </tr>
            <tr>
                <th>시험점수</th>
                <td></td>
            </tr> -->
            <tr>
                <th><label for="mobile_phone">핸드폰번호<span class="required">*</span></label></th>
                <td><input id="mobile_phone" type="tel" name="mobile_phone" maxlength="11"
                        oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" required>
                </td>
            </tr>
            <tr>
                <th><label for="temporarily_number">비상연락처</label></th>
                <td><input id="temporarily_number" type="tel" name="temporarily_number" maxlength="11"
                        oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"></td>
            </tr>
            <tr>
                <th><label for="address">기본주소<span class="required">*</span></label></th>
                <td><input id="address" name="address" class="address" type="text" required></td>
            </tr>
            <tr>
                <th><label for="detail_address">상세주소</label></th>
                <td><input id="detail_address" name="detail_address" class="address" type="text"></td>
            </tr>


        </table>
        <table id="register_button">
            <div class="button">
                <input id="registerSubmit" type="submit" value="등록" onclick="location.href='detailStudent';">
                <input type="button" value="취소" onclick="location.href='Student';">
            </div>
        </table>

    </form>
</div>
<%@ include file="../footer.jsp" %>
