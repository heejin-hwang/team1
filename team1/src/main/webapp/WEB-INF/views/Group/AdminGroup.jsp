<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<link href="/resources/css/AdminGroup.css" rel="stylesheet">
<link href="/resources/css/general.css" rel="stylesheet">
<link href="/resources/css/style.css" rel="stylesheet">


<!-- <script type="text/javascript" src="/resources/js/AdminGroup.js"></script> -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.1.0/jquery-migrate.min.js"></script>
<%@ include file="../header.jsp"%>
<%@ include file="../chat.jsp"%>

<script>

	$(function() {
		$(".setting").on({
			"mouseover focus" : function() {
				$(this).children(".updateBox").css("display", "block");
			},
			"mouseout" : function() {
				$(this).children(".updateBox").css("display", "none");
			}
		});

	});

	function newGroup() {
		window.open('/Group/RegisterGroup', '그룹 추가',
				'width=800, height=600, top=130,left=300');
	}

	function editMember(course_code, groups_id, course_name, groups_name) {
		console.log("\t+ coursecode: ", course_code);
		console.log("\t+ groupsid: ", groups_id);
		console.log("\t+ coursename", course_name);
		console.log("\t+ groupsname", groups_name);

		window.open('/Group/EditGroup?coursecode=' + course_code + '&groupsid='
				+ groups_id + '&coursename=' + course_name + '&groupsname='
				+ groups_name, '그룹원 수정',
				'width=800, height=600, top=130,left=300');
	}

	function addMember(course_code, groups_id, course_name, groups_name) {
		console.log("\t+ coursecode: ", course_code);
		console.log("\t+ groupsid: ", groups_id);
		console.log("\t+ coursename", course_name);
		console.log("\t+ groupsname", groups_name);

		window.open('/Group/AddMember?coursecode=' + course_code + '&groupsid='
				+ groups_id + '&coursename=' + course_name + '&groupsname='
				+ groups_name, '그룹원 추가',
				'width=800, height=600, top=130,left=300');

	}

	function checkDelete(groups_id, course_name, groups_name) {
		console.log("\t+ groupsid: ", groups_id);
		console.log("\t+ coursename", course_name);
		console.log("\t+ groupsname", groups_name);

		if (confirm('<'+course_name+'>' + ' ' + groups_name + "를 정말 삭제하시겠습니까?") == true) {

			location.href = "/Group/removeGroup?groupsid=" + groups_id;

		} else {
			return false;
		}

	}
</script>


<div id="box">
	<c:if test="${ job_id == 2 }">
		<div class="update">
			<!--버튼은 공통 디자인-->
			<button class="admingroup_bo" onclick="newGroup()">그룹추가</button>
			<button class="admingroup_bo"
				onclick="location.href='/Assignment/main'">과제</button>
		</div>
	</c:if>


	<!--그룹 목록 나오는 큰 영역-->
	<div>
		<table id="groupTable">
		
			<tr id="head">
				<td colspan="3">Group (<c:out value='${ groupSize }' />)
				</td>
			</tr>
			
			<c:if test="${ groupSize == 0 }">
				<tr>
					<td>
					<br>
					<img src="/resources/img/noGroupImg.png" alt="no group" width="100" height="100">
					
						<h3>현재 등록된 조가 없습니다.</h3>
					</td>
					<tr>	
			</c:if>

			<!------------ for문으로 tr 반복 생성 ------------>
			<c:forEach items="${grouplist}" var="group">
				<c:if test="${ group.cstate == 'Running' }">
					<tr class="groupList">

						<td style="width: 70%;">${group.cname}</td>

						<!----- 조 인원 아이콘 ----->
						<td rowspan="2" style="width: 15%;"><span
							style="color: #4C4C4C"><i class="fa fa-users fa-lg"
								aria-hidden="true" id="usersIcon"></i></span> <%
 	int count = 0;
 %> <c:forEach items="${ memberCount }" var="member">
								<c:if test="${group.gid == member.gid}">
									<c:set var="count" value="${ member.scount }" />
									<%
										count = Integer.parseInt(pageContext.getAttribute("count").toString());
									%>
								</c:if>
							</c:forEach> <%
 	if (count != 0) {
 				out.println(count + "명");
 			} else {
 				out.println("0명");
 			}
 %></td>

						<!----- 셋팅 아이콘 ----->
						<c:if test="${ job_id == 2 }">
							<td class="setting" rowspan="2" style="width: 10%;">
								<!--setting--> <span style="color: #4C4C4C"> <i
									class="fa fa-cog fa-lg" aria-hidden="true"></i>
							</span>
								<div class="updateBox">
									<!-- 그룹원 수정 -->
									<a
										onclick="editMember('${group.gccode}', '${ group.gid }', '${group.cname}', '${group.gname}')">그룹원수정</a><br>

									<!-- 그룹원 추가 -->
									<a
										onclick="addMember('${group.gccode}', '${ group.gid }', '${group.cname}', '${group.gname}')">그룹원추가</a><br>

									<hr style="width: 90%;">

									<!-- 그룹 삭제 -->
									<a
										onclick="checkDelete('${ group.gid }', '${group.cname}', '${group.gname}')">그룹
										삭제</a><br>
								</div>
							</td>
						</c:if>

					</tr>
					<!----- 조 이름 ----->
					<tr>
						<td style="width: 70%; height: 90%;"><a href='/Group/Group?id=${group.gid}&course_code=${group.gccode}'>${group.gname}</a></td>
					</tr>
				</c:if>

				<c:if test="${  group.cstate == 'Closed'  }">

					<tr class="groupList" style="background-color: #eee;">

						<td style="width: 70%;">${group.cname}</td>

						<!----- 조 인원 아이콘 ----->
						<td rowspan="2" style="width: 15%;"><span
							style="color: #4C4C4C"><i class="fa fa-users fa-lg"
								aria-hidden="true" id="usersIcon"></i></span> <%
 	int count = 0;
 %> <c:forEach items="${ memberCount }" var="member">
								<c:if test="${group.gid == member.gid}">
									<c:set var="count" value="${ member.scount }" />
									<%
										count = Integer.parseInt(pageContext.getAttribute("count").toString());
									%>
								</c:if>
							</c:forEach> <%
 	if (count != 0) {
 				out.println(count + "명");
 			} else {
 				out.println("0명");
 			}
 %></td>

						<!----- 셋팅 아이콘 ----->
						<c:if test="${ job_id == 2 }">
							<td class="setting" rowspan="2" style="width: 10%;">
								<!--setting--> <span style="color: #4C4C4C"> <i
									class="fa fa-cog fa-lg" aria-hidden="true"></i>
							</span>
								<div class="updateBox">
									<!-- 그룹원 수정 -->
									<a
										onclick="editMember('${group.gccode}', '${ group.gid }', '${group.cname}', '${group.gname}')">그룹원수정</a><br>

									<!-- 그룹원 추가 -->
									<a
										onclick="addMember('${group.gccode}', '${ group.gid }', '${group.cname}', '${group.gname}')">그룹원추가</a><br>

									<hr style="width: 90%;">

									<!-- 그룹 삭제 -->
									<a
										onclick="checkDelete('${ group.gid }', '${group.cname}', '${group.gname}')">그룹
										삭제</a><br>
								</div>
							</td>
						</c:if>

					</tr>
					<!----- 조 이름 ----->
					<tr style="background-color: #eee;">
						<td style="width: 70%; height: 90%;"><a href='/Group/Group?id=${group.gid}&course_code=${group.gccode}'>${group.gname}</a></td>
					</tr>

				</c:if>



			</c:forEach>
			<!------------ for문 여기까지 ------------>
		</table>

	</div>

</div>

<%@ include file="../footer.jsp"%>