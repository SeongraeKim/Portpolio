<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="board.BoardDTO"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String id = (String)session.getAttribute("id");
	//한글처리
	request.setCharacterEncoding("UTF-8");
	// notice.jsp에서 요청받아 넘어온 num, pageNum 값 변수에 저장
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
%>  
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>글 상세보기</title>
		
		<!-- 기본 css 설정 -->
		<link href="../css/style.css?ver=1" rel="stylesheet">
		<!-- Bootstrap CSS -->
    	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
		
		<script type="text/javascript">
			function content_update() {
				document.fr.action = "update.jsp#wrap";
				fr.submit();
			}
			function content_delete() {
				document.fr.action = "delete.jsp#wrap";
				fr.submit();
			}
			function reWrite() {
				document.fr.action = "reWrite.jsp#wrap";
				fr.submit();
			}
		</script>
		
	</head>
	<body>
		<!-- Header -->
		<jsp:include page="../inc/top.jsp"/>
		<!-- HeaderEND -->
		
	<%
		// BoardDAO에서 DB작업을 위해 BoardDAO 객체 생성
		BoardDAO dao = new BoardDAO();
		// 조회수 증가 메서드 호출
		dao.updateReadCount(num);
		// BoardDTO에서 글정보를 검색해서 얻기
		BoardDTO dto = dao.getBoard(num);
		
		// 하나의 글 정보를 가져온 dto 객체를 호출해 변수에 값 저장
		int DBnum = dto.getNum();
		int DBreadcount = dto.getReadcount();
		Timestamp DBdate = dto.getDate();
		String DBname = dto.getName();
		String DBsubject = dto.getSubject();
		String DBcontent = "";
		
		if(dto.getContent() != null){
			
			DBcontent = dto.getContent().replace("\r\n", "<br>");
		}
		
		int DBRe_ref = dto.getRe_ref();
		int DBRe_lev = dto.getRe_lev();
		int DBRe_seq = dto.getRe_seq();
	%>
		
		<!-- 글상세보기 -->
		<div class="m-5">
			<h2 align="left">글 상세보기</h2>
			<form method="post" name="fr">
				<table class="table table-bordered mt-4">
					<tr>
						<th class="table-dark text-center align-middle">번호</th>
						<td><input class="form-control" value="<%=DBnum %>" readonly></td>
						<th class="table-dark text-center align-middle">작성자</th>
						<td><input class="form-control" value="<%=DBname %>" readonly></td>
						<th class="table-dark text-center align-middle">작성일</th>
						<td><input class="form-control" value="<%=new SimpleDateFormat("yyyy.MM.dd").format(DBdate) %>" readonly></td>
						<th class="table-dark text-center align-middle">IP</th>
						<td><input class="form-control" value="<%=dto.getIp() %>" readonly></td>
						<th class="table-dark text-center align-middle">조회수</th>
						<td><input class="form-control" value="<%=DBreadcount %>" readonly></td>
					</tr>
					<tr>
						<th class="table-dark text-center align-middle">제목</th>
						<td colspan="9"><input type="text" name="subject" value="<%=DBsubject %>" class="form-control" readonly></td>
						
					</tr>
					<tr>
						<th class="table-dark text-center align-middle">내용</th>
						<td colspan="9"><textarea rows="10" class="form-control" readonly><%=DBcontent %></textarea></td>
					</tr>
				</table>
				
				<input type="hidden" name="num" value="<%=num%>">
				<input type="hidden" name="pageNum" value="<%=pageNum%>">
				<input type="hidden" name="re_ref" value="<%=DBRe_ref%>">
				<input type="hidden" name="re_lev" value="<%=DBRe_lev%>">
				<input type="hidden" name="re_seq" value="<%=DBRe_seq%>">
			</form>
			
			<!-- 하단버튼 -->
			<div class="d-flex">
				<div class="mr-auto">
					<input type="button" value="글목록" class="btn btn-dark" onclick="location.href='notice.jsp?pageNum=<%=pageNum%>'">
				</div>
	<%
					if(id != null){		// 로그인 했을 경우

						if(id.equals(DBname)){
	%>
							<input type="button" value="수정하기" class="btn btn-dark mr-1" onclick="content_update()">
							<input type="button" value="삭제하기" class="btn btn-dark mr-1" onclick="content_delete()">
	<%
						}
	%>
							<input type="button" value="답글작성" class="btn btn-dark" onclick="reWrite()">
	<%
					}
	%>
			</div>
		</div>
		<!-- 글상세보기 END -->
		<!-- Foooter -->
		<jsp:include page="../inc/footer.jsp"/>
		<!-- FoooterEND -->
	</body>
</html>










