<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-migrate/3.1.0/jquery-migrate.min.js"></script>


    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js" type="text/javascript"></script>
     
    <script type="text/javascript">
        $(document).ready(function(){
            // 옵션추가 버튼 클릭시
            $("#addItemBtn").click(function(){
                // item 의 최대번호 구하기
                var lastItemNo = $("#example tr:last").attr("class").replace("item", "");
 
                var newitem = $("#example tr:eq(1)").clone();
                newitem.removeClass();
                newitem.find("td:eq(0)").attr("rowspan", "1");
                newitem.addClass("item"+(parseInt(lastItemNo)+1));
 
                $("#example").append(newitem);
            });
 
 
            // 항목추가 버튼 클릭시
            $(".addBtn").live("click", function(){
                var clickedRow = $(this).parent().parent();
                var cls = clickedRow.attr("class");
 
                // tr 복사해서 마지막에 추가
                var newrow = clickedRow.clone();
                newrow.find("td:eq(0)").remove();
                newrow.insertAfter($("#example ."+cls+":last"));
 
                // rowspan 조정
                resizeRowspan(cls);
            });
             
             
            // 삭제버튼 클릭시
            $(".delBtn").live("click", function(){
                var clickedRow = $(this).parent().parent();
                var cls = clickedRow.attr("class");
                 
                // 각 항목의 첫번째 row를 삭제한 경우 다음 row에 td 하나를 추가해 준다.
                if( clickedRow.find("td:eq(0)").attr("rowspan") ){
                    if( clickedRow.next().hasClass(cls) ){
                        clickedRow.next().prepend(clickedRow.find("td:eq(0)"));
                    }
                }
 
                clickedRow.remove();
 
                // rowspan 조정
                resizeRowspan(cls);
            });
 
            // cls : rowspan 을 조정할 class ex) item1, item2, ...
            function resizeRowspan(cls){
                var rowspan = $("."+cls).length;
                $("."+cls+":first td:eq(0)").attr("rowspan", rowspan);
            }
        });
    </script>
</head>
 
<body>
<button id="addItemBtn">주요기능추가</button>
<table id="example" border="1px">
        <tr>
            <th>주요기능</th>
            <th>세부기능</th>
            <th>완료체크</th>
            <th>세부내용</th>
            <th>옵션추가</th>
        </tr>
        <tr class="item1">
            <td><input type="text" name="part_project"  /><button class="addBtn">세부기능추가</button></td>
            <td><input type="text" name="detail_part"/></td>
            <td><input type="checkbox" name="done"/></td>
            <td><input type="text" name="detail_content"/></td>
            <td><button class="delBtn">삭제</button></td>
        </tr>
        <tr class="item2">
            <td><input type="text" /><button class="addBtn">세부기능추가</button></td>
            <td><input type="text" /></td>
            <td><input type="checkbox" /></td>
            <td><input type="text" /></td>
            <td><button class="delBtn">삭제</button></td>
        </tr>
        <tr class="item3">
            <td><input type="text" /><button class="addBtn">세부기능추가</button></td>
            <td><input type="text" /></td>
            <td><input type="checkbox" /></td>
            <td><input type="text" /></td>
            <td><button class="delBtn">삭제</button></td>
        </tr>
        <tr class="item4">
            <td><input type="text" /><button class="addBtn">세부기능추가</button></td>
            <td><input type="text" /></td>
            <td><input type="checkbox" /></td>
            <td><input type="text" /></td>
            <td><button class="delBtn">삭제</button></td>
        </tr>
</table>
</body>
</html>  

