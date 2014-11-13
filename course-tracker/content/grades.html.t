<% include header.html.t %>
<div id="wrap">
<center>
<form action="/">
<button id="btn">HOME</button>
</form>
<hr>
<Center>

<div id="postnote">
<h1>SEM 1</h1>
<select id="subject">
  <option value="Seatwork">Seatwork</option>
  <option value="Homework">Homework</option>
  <option value="Quiz">Quiz</option>
  <option value="Project">Project</option>
</select>

<form>
<H1>Grade: </h1>
<input type="text" id="text"/><br>
</form>

<button onclick="post_form()">POST</button>
</div>
<div id="calendar">
<h1>==||GRADES||==</h1>

<p id="final"></p>
</div>

</div>



<script src="/template/ajax.js"></script>
<script>

function post_form() {
	var score = document.getElementById('text').value;
    var subject = document.getElementById('subject').value;
	ajax_post_json("/database", { 
		"text" : subject,
	    "grade" : score
		}, null);
}

function post_form2(text) {
   	
	ajax_post_json("/delete", { 
		"text1" : text
		}, null);
}




var myVar = setInterval(function(){myTimer()}, 1000);

function myTimer() {
		ajax_get_json("/database", function(o) {
		var length = o.grades.length;
		var text = "";
		
		for(var iCtr = 0; iCtr < length; iCtr++) {
			text +="<button onclick=\"post_form2("+o.grades[iCtr].id+")\">DELETE</button>"+ " " + o.grades[iCtr].subject +" : "+ o.grades[iCtr].grade + "<br>";
		
		}		
		
		document.getElementById('final').innerHTML = text;
	});
}

</script>
<% include footer.html.t %>