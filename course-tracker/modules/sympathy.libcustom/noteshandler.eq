class noteshandler  : HTTPRequestHandler 
{
	String text1;
	String text2;
    Array final = Array.create();

	public void get(HTTPRequest req) {
		req.send_json(final);
	}

	public void post(HTTPRequest req) {
		var data = req.get_body_json_hash_table();
		if(data != null) {
			text1 = data.get_string("text1");
			text2 = data.get_string("text2");
			final.add(HashTable.create().set("Text2", text2).set("Text1", text1));
		}
		req.send_json(HashTable.create().set("status", "OK"));
	}
	
}