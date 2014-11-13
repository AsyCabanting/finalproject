<% include header.html.t %>

<div id="wrapper">
<center>
<form action="/">
<button id="btn">HOME</button>
</form>
<hr>
<Center>



</center>

<div id="calendar">
<br>
<TABLE BORDER=3 CELLSPACING=3 CELLPADDING=3> 
<TR>
<TD COLSPAN="7" ALIGN=center><B>November 2014</B></TD> 
</TR>
<TR> 
<TD COLSPAN="7" ALIGN=center><I></I></TD>
</TR>
<TR> 
<TD ALIGN=center>Sun</TD>
<TD ALIGN=center>Mon</TD>
<TD ALIGN=center>Tue</TD>
<TD ALIGN=center>Wed</TD>
<TD ALIGN=center>Thu</TD>
<TD ALIGN=center>Fri</TD>
<TD ALIGN=center>Sat</TD>
</TR>
<TR> 
<TD ALIGN=center></TD>
<TD ALIGN=center></TD>
<TD ALIGN=center></TD>
<TD ALIGN=center></TD>
<TD ALIGN=center></TD>
<TD ALIGN=center></TD>
<TD ALIGN=center>1</TD>
</TR>
<TR> 
<TD ALIGN=center>2</TD>
<TD ALIGN=center>3</TD>
<TD ALIGN=center>4</TD>
<TD ALIGN=center>5</TD>
<TD ALIGN=center>6</TD>
<TD ALIGN=center>7</TD>
<TD ALIGN=center>8</TD>
</TR>
<TR> 
<TD ALIGN=center>9</TD>
<TD ALIGN=center>10</TD>
<TD ALIGN=center>11</TD>
<TD ALIGN=center>12</TD>
<TD ALIGN=center>13</TD>
<TD ALIGN=center>14</TD>
<TD ALIGN=center>15</TD>
</TR>
<TR> 
<TD ALIGN=center>16</TD>
<TD ALIGN=center>17</TD>
<TD ALIGN=center>18</TD>
<TD ALIGN=center>19</TD>
<TD ALIGN=center>20</TD>
<TD ALIGN=center>21</TD>
<TD ALIGN=center>22</TD>
</TR>
<TR> 
<TD ALIGN=center>23</TD>
<TD ALIGN=center>24</TD>
<TD ALIGN=center>25</TD>
<TD ALIGN=center>26</TD>
<TD ALIGN=center>27</TD>
<TD ALIGN=center>28</TD>
<TD ALIGN=center>29</TD>
</TR>
<TR> 
<TD ALIGN=center>30</TD>
<TD ALIGN=center></TD>
<TD ALIGN=center></TD>
<TD ALIGN=center></TD>
<TD ALIGN=center></TD>
<TD ALIGN=center></TD>
<TD ALIGN=center></TD>

</TR>
</TABLE>
</div>


<div id="postnote">

<form>
<h1>SUBJECT</h1>
<select id="Subject">

  <option value="Sem1">Sem1</option>
  <option value="IT102">IT102</option>
  <option value="Others">Others</option>

</select>
<h1>Reminder</h1>
<input type="text" id="Rem" />
</form>
<br>

<form>
<button onclick="javascript: post_form()" id="btn" >POST</button>
</form>
<br></br>
</div>

<center>

	<h1>REMINDER BOARD</h1>

<h3 id="out"></h3>
</center>
</div>


<script src="/template/ajax.js"></script>
<script>

function post_form() {
	var sub = document.getElementById('Subject').value;
    var rem = document.getElementById('Rem').value;
	ajax_post_json("/notesdb", { 
		"sub" : sub,
	    "rem" : rem
		}, null);
}

function post_form2(text) {
   	
	ajax_post_json("/deletenote", { 
		"text1" : text
		}, null);
}




var myVar = setInterval(function(){myTimer()}, 1000);

function myTimer() {
		ajax_get_json("/notesdb", function(o) {
		var length = o.notes.length;
		var text = "";
		
		for(var iCtr = 0; iCtr < length; iCtr++) {
		text +="<button onclick=\"post_form2("+o.notes[iCtr].id+")\">DELETE</button>"+ " " + o.notes[iCtr].subject +" : "+ o.notes[iCtr].note + "<br>";
		
		}		
		
		document.getElementById('out').innerHTML = text;
	});
}

</script>
<% include footer.html.t %>