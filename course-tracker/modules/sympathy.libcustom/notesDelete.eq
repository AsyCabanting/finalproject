public class notesDelete : HTTPRequestHandler {
  //The SQLDatabase data type can represent any kind of SQl database.

    SQLDatabase db;

 public bool configure(File appdir, HashTable settings) {
        if(base.configure(appdir,settings) == false) {
            return(false);
        }

        //Open the database: An SQLite database, saved as a file within the site directory.
        db = SQLiteDatabase.for_file(appdir.entry("notesdb.sqlite"), true, get_logger());
        
		if(db == null) {
            log_error("Failed to open database.");
            return(false);
        }
   
  	   //All initialization is successfully done.
        log_message("SimpleDatabaseHandler initialization complete.");
        return(true);
    }


	bool delete_record(String data) {
			var sql ="DELETE FROM mynotes WHERE ( id ) = ( ? );";
			var stmt = db.prepare(sql);
			stmt.add_param_str(data);
			return(db.execute(stmt));
	}

	public void post(HTTPRequest req) {
	
		var data = req.get_body_json_hash_table();

		if(data != null) {
		
		   delete_record(data.get_string("text1"));
		}
		req.send_response(HTTPResponse.for_html_string("<center><b>Content Saved!</b><br><br><form method=link action=\"/index\"><input type=\"submit\" value=\"HOME\" /></form><form method=link action=\"/database\"><input type=\"submit\" value=\"Go to Database\" /></form> "));
	}
}