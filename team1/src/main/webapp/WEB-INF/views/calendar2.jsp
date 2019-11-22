<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="http://cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.0/css/swiper.css">
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.0/js/swiper.min.js"></script>
    <title>Swiper</title>

    <style>
        .swiper-container {
            width: 505px;
            height: 208px;
        }
        .swiper-slide {
            text-align: center;
            font-size: 18px;
            background: #fff;
            /* Center slide text vertically */
            display: -webkit-box;
            display: -ms-flexbox;
            display: -webkit-flex;
            display: flex;
            -webkit-box-pack: center;
            -ms-flex-pack: center;
            -webkit-justify-content: center;
            justify-content: center;
            -webkit-box-align: center;
            -ms-flex-align: center;
            -webkit-align-items: center;
            align-items: center;
        }   
        
        .bx_group { 
           display: flex; 
           width: 750px;
           font-size: 15px;
        }
        
        .bx_group > div { 
            flex: 1;
            height: 208px;
            margin: 20px;
      }
      
      .bx_group > div h3 {
         margin : 20px 0;      
      }
            
        .swiper-button-next, .swiper-button-prev { 
            background: none; 
            font-size: 35px;
            width: 28px;
            height: 52px; 
            }
        .swiper-button-next {right: 15px;}
        .swiper-button-prev {left: 0;}
    </style>
    
    <script type="text/javascript">
       window.onload = function(){
           var dt = new Date();
           var week = new Array('일', '월', '화', '수', '목', '금', '토');
           var Year = dt.getFullYear();        
           var Month = "-" + (dt.getMonth()+1);
           var Day = "-" + dt.getDate();            
           
           if(Month.length < 2) Month = "0" + Month;
           if(Day.length < 2) Day = "0" + Day;
           
           var Today = Year.toString() + Month + Day + " (" + week[dt.getDay()] + "요일)";
           var Tomorrow = Year.toString() + Month + ("-" + (dt.getDate()+1)) + " (" + week[dt.getDay()+1] + "요일)";;
           
           document.getElementById("TODAY").innerHTML = Today;
           document.getElementById("TOMORROW").innerHTML = Tomorrow;
       } 
   
   </script>
    
    
<body>

   <div class="swiper-container">
        <div class="swiper-wrapper">
            <div class="swiper-slide">
                <div class="bx_group">
                    <div class="TODAY"><h3 id="TODAY"></h3>
                  <%@ include file="HOME/HomeSchedule.jsp" %>
                    </div>
                </div>
            </div>
            <div class="swiper-slide">
                <div class="bx_group">
                    <div class="TOMORROW"><h3 id="TOMORROW"></h3>
                       <%@ include file="HOME/HomeSchedule2.jsp" %>
                    </div>
                </div>
            </div>
        </div>
        <div class="swiper-button-next"><i class="xi-angle-right-thin"></i></div>
        <div class="swiper-button-prev"><i class="xi-angle-left-thin"></i></div>
    </div>

    <script>
        var swiper = new Swiper('.swiper-container', {
            navigation: {
            nextEl: '.swiper-button-next',
            prevEl: '.swiper-button-prev',
            },
        });
    </script>

</body>
</html>
























