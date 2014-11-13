<% include header.html.t %>

<div id="wrap">
<center>
<form action="/">
<button id="btn">HOME</button>
</form>
<hr>
</Center>

<div id="postnote">
<form>
<h1>SUBJECT:</h1>
<select id="Subject">
  <option value="Sem1">Sem1</option>
  <option value="IT102">IT102</option>
  <option value="Others">Others</option>
</select>
<h1>Note:</h1>
<input type="text" id="Note" />
</form>
<button onclick="javascript: post_form()">POST</button>
</div>

<div id="calendar">
<b><h1>====||NOTES||====</h1></b>
<p id="out"></p>
</div>

</div>


<script src="/template/ajax.js"></script>
<script>

function post_form() {
	var sub = document.getElementById('Subject').value;
    var note = document.getElementById('Note').value;
	ajax_post_json("/boardDB", { 
		"sub" : sub,
	    "note" : note
		}, null);
}

function post_form2(text) {
   	
	ajax_post_json("/DeleteboardDB", { 
		"text1" : text
		}, null);
}




var myVar = setInterval(function(){myTimer()}, 1000);

function myTimer() {
		ajax_get_json("/boardDB", function(o) {
		var length = o.board.length;
		var text = "";
		
		for(var iCtr = 0; iCtr < length; iCtr++) {
			text +="<button onclick=\"post_form2("+o.board[iCtr].id+")\">DELETE</button>"+ " " + o.board[iCtr].subject +" : "+ o.board[iCtr].text + "<br>";
		
		}		
		
		document.getElementById('out').innerHTML = text;
	});
}

</script>
<% include footer.html.t %>